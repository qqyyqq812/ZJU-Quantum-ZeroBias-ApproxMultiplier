# Approximate Radix-4 Booth Multiplier (Chisel)

面向 DNN 推理加速器的零均值偏差近似乘法器，基于 Chisel HDL 实现。  
最终设计为 **V3 Scheme D**：通过 Row 0 Special Amnesty 实现绝对零均值偏差。

## 项目核心目录结构 (ZBA-R4ABM Git Repo)

```text
/
├── .gitignore             # 🚨 极其严苛的编译产物防沾染墙
├── src/main/scala/        # 💎 (Paper-Only Codebase) 极简底层算子源码
│   ├── KMap_V3_Final_SchemeD.scala   # ★ DAC 核心对比变体 (ZBA-R4ABM)
│   ├── KMap_V3_Mixed_Approx.scala    # ALWANN 异构混切策略
│   ├── GatedPE.scala                 # PPA 零功耗门控核
│   └── StructuralExactBooth8.scala   # 物理极值对照参考
├── docs/                  # 🌟 仿真验证规范与学术可视化图床
│   ├── Agent2系统仿真指南.md
│   ├── 实验数据与图表规划.md
│   └── Visual-Lab/                   # 💡【全新】宏观帕累托神经联动大屏
├── eval_alwann/           # 🌟 预留予 Agent 2 进行 Colab 深度学习精度代理推演的空地舱
├── synth/                 # Agent 1 进行底盘 DC 综合时保留的权威脚本
└── backup_legacy_src/     # 📦 原型演化垃圾场封存 (包含 step1~3 及老旧实现)
```

## 当前进度里程碑 (Current Status)

✅ **底层清洗完备**：彻底拔除冗余代码，进入“提交级”纯粹状态。
✅ **可视化降维打击**：成功集成由 `ECharts` 驱动的 Pareto 雷达展台，全链路贯通硬/软件联动。
✅ **云端管道铺设**：已初始化 Git 并与 GitHub `ZJU-Quantum-ZeroBias-ApproxMultiplier` 直连。接下来静候 Agent 2 下场跑数据。

## 编译

```bash
# 生成所有变体的 Verilog
make

# 运行 ChiselTest 测试
make test
```

需要 SBT + Chisel 5 环境。详见 `build.sbt`。

## 关联生态

此仓库为底层硬件极简剥离态，真正的海量中间评测物依旧隔离并保存在外围大沙盒中（`~/chipyard_workspace/docs/parallel/`），互不侵犯。
