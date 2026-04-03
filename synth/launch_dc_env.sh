#!/bin/bash
# 激活底层 Synopsys 环境变量并带守护执行 DC 综合跑分
# 0. 底层安全护航：激活靶向无损 MAC 虚拟网卡沙盒，防止毁坏本机局域网生态
/home/qq/scripts/patch_eda_mac.sh || echo "⚠️ MAC 沙盒绑定异常，尝试继续执行..."

# 1. 设置环境变量 (假设 license 已在默认端口生效，或者系统已有全局路径)
export SYNOPSYS=/home/qq/EDA/Synopsys
export DC_HOME=$SYNOPSYS/dc_2023/
export PATH=$DC_HOME/bin:$PATH
export LM_LICENSE_FILE=27000@localhost

# 2. 切换到工作区并建立日志
cd /home/qq/projects/approx-multiplier/synth

echo "开始执行 DC 综合风暴 (带 180s 守护机制)..."
# 使用 timeout 和 dc_shell -f 来跑脚本，抛弃交互
timeout 180s dc_shell -f run_v3_final_ppa.tcl > synth_v3_final.log 2>&1

if [ $? -eq 0 ]; then
    echo "综合成功完成，日志已写入 synth_v3_final.log"
else
    echo "综合执行出错或超时，错误码 $?"
    # 输出末尾的错误日志方便调试
    tail -n 20 synth_v3_final.log
fi
