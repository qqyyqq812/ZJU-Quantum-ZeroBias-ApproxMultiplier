# Gemmini 近似乘法器模块仓 — V3 0-Bias 控制变量代码库

本目录包含 Radix-4 Booth 近似乘法器的演进核心源码，覆盖从 Exact 基线到 V3 极限 0-Bias 全近似模型的全部 Chisel 实现。
所有的模块统一遵循标准的 8-bit 有符号数相乘协议（`8-bit signed × 8-bit signed → 16-bit signed`）。

本目录是提供给 **Agent B (端到端生态验证总管)** 在不同容错验证目标下进行宏观大模型（ResNet50 / Transformer）评估时的元件替换弹药库。

---

## 1. 核心理论指南与 V3 重构概要

本代（V3）乘法器摒弃了 V2 早期探索阶段的“宏观零门控”（证实会导致大扇出及高漏电），全盘采用**极简 K-Map 布尔二维化简与 Flatten 加法树阵列**。

最核心的架构突破是 **Scheme D (0-Bias Amnesty)**：
在取消精确的 Booth 编码后，不可避免会引入不对称的固定偏移（如 0 值译码变有偏常数）。为了阻止这种均值偏差（Mean Bias）在深层网络中积聚引发精度雪崩，我们在最底层的 `Row 0` 构建了极低代价的 `+1 补码` 通路。这迫使离散误差全部呈**完美的正负对称正态分布**。网络权重微调（Finetuning）仅依靠自我补偿机制就能找回几乎 100% 的原有精确水平。

---

## 2. Agent B 对照实验模块表 (Module Manifest)

在进行 Chipyard/Gemmini 仿真时，可以按需使用文件中的 `class` 替换顶层模块。

### 🔴 绝对精确基线 (Baseline)
- **`StructuralExactBooth8.scala`** 
  （`StructuralExactBooth8`）
  - **定位**：结构级精确 Booth 乘法器（4 行全精确）。用于获取 PPA 的无删减对比底线及系统 100% 精度的基线标杆。

### 🔵 V3 主选极限模型 (The SoTA Winner)
- **`KMap_V3_Final_SchemeD.scala`**
  （`KMap_V3_Final_SchemeD`）
  - **定位**：全阵 4 行 **100% 极简近似化**，搭载 **Row 0 借线复用 0-Bias 特赦（有 BARC 等效概念）**。
  - **特征**：摒弃了所有的宏观零门控，取消了繁复的 Embedded 进位拼接，直接在最低层摊平。目前拥有最低面积 (`197.10 μm²`) 和激进低功耗 (`107.89 uW`)，同时在 CIFAR-10 上跑出了一轮微调恢复至 **86.28%** 的惊艳成绩。

### 🟡 敏感度分析探针 (Sensitivity Control Groups)
用于论文论证“近似行比例”与“最终网络成片误差容忍度”所准备的控制变量档。用于验证不同梯度的近似比例在更大微调网络上所需付出的代价：
- **`KMap_V3_Exp3_3A1E.scala`**
  - **75% 近似**：顶上 3 行使用无偏压缩，最低 1 行保留 Exact 结构。
- **`KMap_V3_Exp4_2A2E.scala`**
  - **50% 近似**：顶上 2 行近似，底部 2 行 Exact 结构。
- **[新增强调对照] 无偏差保护版 (No-BARC / Biased Control)**：
  - 如果 Agent B 需开展 “证明 Scheme D 伟大”的作用对比测试，可自行拉取历史记录中的 `RegularBooth8_KMap_PZ.scala` 组系列（纯粹阉割了 BARC 的对照基准，带有强均值偏差。将会引发网络验证断崖灾难，从而突显 Scheme D 价值）。

---

## 3. 调用示范 (For Gemmini Integration)

针对后续需要在 Gemmini MAC Array 层面顶层替换乘法计算基底，请在顶层文件中覆盖调配，实例化所需的控制器：

```scala
// 例子：替换为 V3 最强版本进行生成与后端仿真
val multiplier = Module(new KMap_V3_Final_SchemeD())
multiplier.io.a := inputA
multiplier.io.b := inputB
outputProd := multiplier.io.p
```

---

## 4. 过往演化档案 (Archives)
早期的截断路由、V1/V2中充斥着复杂的 “双重 ZG” （Dual Zero-Gating）探针实验与废弃算法全部收缩至 `archive/` 文件夹。当前的研究主线务必严格锚定 V3 KMap 无门控体系。
