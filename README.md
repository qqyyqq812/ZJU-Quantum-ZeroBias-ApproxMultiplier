# Approximate Radix-4 Booth Multiplier (Chisel)

面向 DNN 推理加速器的零均值偏差近似乘法器，基于 Chisel HDL 实现。  
最终设计为 **V3 Scheme D**：通过 Row 0 Special Amnesty 实现绝对零均值偏差。

## 项目结构

```
src/main/scala/regular/     # Chisel 源码（所有乘法器变体）
  ├── KMap_V3_Final_SchemeD.scala   # ★ 最终设计
  ├── KMap_V3_Exp{1-4}_*.scala      # 消融实验变体
  ├── StructuralExactBooth8.scala   # 精确参考基线
  └── step{1-3}_*/                  # 设计演化中间步骤
tools/                       # 验证与分析脚本
generated_rtl/               # 编译产物（.v/.fir/.anno.json）
generated_rtl/data/          # LUT 数据、误差分析 CSV
quartus/                     # Quartus FPGA 综合工程
synth/                       # 综合脚本
```

## 编译

```bash
# 生成所有变体的 Verilog
make

# 运行 ChiselTest 测试
make test
```

需要 SBT + Chisel 5 环境。详见 `build.sbt`。

## 关联仓库

集成环境与文档位于 `~/chipyard_workspace/`（含 Gemmini 集成、RTL 仿真、论文草稿）。
