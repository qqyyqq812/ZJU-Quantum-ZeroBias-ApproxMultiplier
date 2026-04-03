#!/bin/bash
set -e

# =========================================================================
# 本地战区B: Spike 芯片原生宏观测计 (Native Architectural Bounds Guard)
# =========================================================================

echo "🚀 [Spike Hunter] 进入 WSL2/Native 本地纯净执行流"
echo "---"

# 进入老旧的 Chipyard 环境仅供提取纯真态 MAC
source /home/qq/miniconda3/etc/profile.d/conda.sh || true
source /home/qq/chipyard_workspace/chipyard/env.sh

cd /home/qq/chipyard_workspace/chipyard/sims/verilator

OUTPUT_LOG="/tmp/spike_native_resnet50.log"
TARGET_BINARY="/home/qq/chipyard_workspace/chipyard/generators/gemmini/software/gemmini-rocc-tests/build/imagenet/resnet50_quick-baremetal"

echo "⏳ 执行目标锁死: resnet50_quick-baremetal"
echo "🛡️ 全面拒止耗时的 Verilator。仅启用 RISC-V Spike 以最快速度刺探出底层执行极限。"

# 生命周期铁律：挂靠 30 分钟生命墙
timeout 30m spike --extension=gemmini $TARGET_BINARY > $OUTPUT_LOG 2>&1 || {
    EXIT_CODE=$?
    if [ $EXIT_CODE -eq 124 ]; then
        echo "💥 严重预警：Spike 指令集撞钟 30 分钟！强制系统级掐死。"
        exit 1
    elif [ $EXIT_CODE -ne 0 ]; then
        echo "💥 错误：异常中止，故障码 $EXIT_CODE"
        exit 1
    fi
}

echo "✅ 截获完毕，提取无污染数据骨架："
echo "----------------------------------------"
grep -i "Total MACs" $OUTPUT_LOG || echo "(日志未显式包含 MACs 字样，转为在汇编栈寻线)"
grep -i "SRAM Accesses" $OUTPUT_LOG || echo "(未显式输出 SRAM 记录)"

echo "----------------------------------------"
echo "🗄️ 全文冷数据压入存档: $OUTPUT_LOG"
