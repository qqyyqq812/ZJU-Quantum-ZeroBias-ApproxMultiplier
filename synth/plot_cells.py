#!/usr/bin/env python3
import re
import sys
import matplotlib.pyplot as plt
import numpy as np

# 日志文件路径
log_file = "/home/qq/projects/approx-multiplier/synth/synth_all.log"

def parse_synthesis_log(filepath):
    """从 Yosys 日志提取四个版本的面积与门类型统计"""
    data = {}
    current_module = None
    
    # 模式匹配
    module_pattern = re.compile(r'=== (\w+) ===')
    cell_count_pattern = re.compile(r'^\s*([0-9]+)\s+([0-9\.]+)?\s+([A-Z0-9_]+)$')
    
    try:
        with open(filepath, 'r') as f:
            for line in f:
                mod_match = module_pattern.search(line)
                if mod_match:
                    current_module = mod_match.group(1)
                    data[current_module] = {'cells': {}}
                    continue
                
                if current_module and "cells" in line and "Area" not in line:
                    pass # title line
                    
                cell_match = cell_count_pattern.match(line)
                if current_module and cell_match:
                    count = int(cell_match.group(1))
                    cell_type = cell_match.group(3)
                    if cell_type != 'cells':
                        # 按主要逻辑门分类
                        base_type = cell_type.split('_')[0]
                        # 把数字去掉，比如 NAND2/NAND3/NAND4 都叫 NAND
                        base_type = ''.join([i for i in base_type if not i.isdigit()])
                        
                        if base_type not in data[current_module]['cells']:
                            data[current_module]['cells'][base_type] = 0
                        data[current_module]['cells'][base_type] += count
                        
    except FileNotFoundError:
        print(f"Error: {filepath} not found.")
        sys.exit(1)
        
    return data

def plot_stacked_bar(data):
    """绘制堆叠柱状图"""
    # 我们关注的四个版本
    modules = ['ExactBooth8', 'RegularBooth8NoBRC', 'RegularBooth8', 'RegularBooth8Full']
    labels = ['Exact (基准)', 'Approx-NoBRC (无补偿)', 'Approx-BARC (仅偏置补偿)', 'Approx-Full (终极5→4压缩)']
    
    # 获取所有的门类型
    all_types = set()
    for mod in modules:
        if mod in data:
            all_types.update(data[mod]['cells'].keys())
            
    # 只关注核心的门类型，把冷门的合并到 "Other"
    core_types = ['AND', 'NAND', 'OR', 'NOR', 'XOR', 'XNOR', 'MUX', 'INV', 'AOI', 'OAI']
    
    # 准备画图数据
    plot_data = {t: [] for t in core_types + ['Other']}
    
    for mod in modules:
        if mod not in data:
            print(f"Warning: {mod} not found in log.")
            continue
            
        mod_cells = data[mod]['cells']
        other_count = 0
        
        for t in all_types:
            count = mod_cells.get(t, 0)
            if t in core_types:
                plot_data[t].append(count)
            else:
                other_count += count
        plot_data['Other'].append(other_count)

    # 开始绘图 - 并排对比的堆叠柱状图
    fig, ax = plt.subplots(figsize=(14, 9))
    
    # 设置中文字体 (应对 Linux 环境，如果没有中文字体会变成方块，尽量用英文或通用配置)
    plt.rcParams['font.sans-serif'] = ['DejaVu Sans', 'WenQuanYi Micro Hei', 'Noto Sans CJK SC', 'SimHei']
    plt.rcParams['axes.unicode_minus'] = False
    
    x = np.arange(len(modules))
    width = 0.6
    
    bottom = np.zeros(len(modules))
    
    # 颜色设定
    colors = plt.cm.tab20(np.linspace(0, 1, len(plot_data)))
    
    for (ctype, counts), color in zip(plot_data.items(), colors):
        if sum(counts) > 0:  # 只画非空的门
            bars = ax.bar(x, counts, width, bottom=bottom, label=ctype, color=color, edgecolor='white')
            # 在图中标注显著的数量 (大于15个门的时候)
            for bar, count in zip(bars, counts):
                if count > 15:
                    ax.text(bar.get_x() + bar.get_width()/2, bar.get_y() + bar.get_height()/2, 
                            f'{count}', ha='center', va='center', color='black', fontsize=9, fontweight='bold')
            bottom += np.array(counts)

    # 添加顶部的总面积标注
    areas = [630.95, 324.25, 415.49, 417.08] # 从之前日志硬编码的面积
    total_cells = [536, 269, 347, 342]
    
    for i, (area, cells) in enumerate(zip(areas, total_cells)):
        ax.text(i, bottom[i] + 10, f'Total Cells: {cells}\nArea: {area} μm²', 
                ha='center', va='bottom', fontweight='bold', fontsize=11,
                bbox=dict(facecolor='white', alpha=0.8, edgecolor='gray', boxstyle='round,pad=0.5'))

    ax.set_title('Gemmini 矩阵乘数单元 (Nangate 45nm) 门级组成与面积对比', fontsize=16, pad=20)
    ax.set_ylabel('逻辑门数量 (Cell Count)', fontsize=14)
    ax.set_xticks(x)
    ax.set_xticklabels(labels, fontsize=12, rotation=15)
    
    # 把图例放到外面
    ax.legend(title='逻辑门类型', bbox_to_anchor=(1.05, 1), loc='upper left', fontsize=11)
    
    plt.tight_layout()
    plt.grid(axis='y', linestyle='--', alpha=0.7)
    
    out_path = "/home/qq/chipyard_workspace/docs/technical/门级统计对比图.png"
    plt.savefig(out_path, dpi=300, bbox_inches='tight')
    print(f"Saved plot to {out_path}")

if __name__ == "__main__":
    data = parse_synthesis_log(log_file)
    plot_stacked_bar(data)
