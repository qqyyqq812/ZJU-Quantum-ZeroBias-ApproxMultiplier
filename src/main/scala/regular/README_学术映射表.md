# 🏛️ ZBA-BM 算子血统与学术映射白皮书

> **Author**: Agent 1 & Director (ZBA-BM 算子极值突击队)  
> **Date**: 2026-04-01  
> **Status**: 🟢 Cleaned (已断舍离，符合顶会开源代码规范)

这里的 `src/main/scala/regular/` 曾经包含了长达一个月、多达 19 份的迭代源码（屎山）。为了确保开源代码库的防呆性与架构解耦性，所有的非定档历史验证代码（如内嵌门控版、缝合加法树版、纯补偿版等）均已被移入 `archive/`。

**当前根目录仅保留参与打榜的 5 大纯正血统算子！以下是绝密的对应字典！**

---

## 📖 第一章：核心代码 ↔ 综合网表 ↔ 论文论述 映射表

下表定义了我们在 Chisel 代码中的「类命名」、在 `/generated_rtl` 和 DC 综合报告中的「文件指代」、以及论文里「用英语表述的心智模型」之间的严格映射规律：

| Scala 组合类文件 | 衍生模块 (类名 & Verilog名) | 论文体系架构代号 | 架构物理特征 (DNA) |
| :--- | :--- | :--- | :--- |
| `StructuralExactBooth8.scala` | `StructuralExactBooth8` | **Baseline (Exact Booth)** | 纯精确结构，保留独立编码器，是我们所有节流减排的起点。 |
| `KMap_V3_Mixed_Approx.scala` | `KMap_V3_1Row_Approx` | **V3 Schema (N=1)** | **纯正 V3 基因**：无零门控探针 `NoZG` + 扁平加法树 `FlattenTree` + 强制 `Row_0 Amnesty`（特赦最低行） |
| *(同上母机衍生)* | `KMap_V3_2Row_Approx` | **V3 Schema (N=2)** | 同上。截断两行，包含特赦。 |
| *(同上母机衍生)* | `KMap_V3_3Row_Approx` | **V3 Schema (N=3)** | 同上。截断三行，包含特赦。*(论文揭示“精度悬崖”就发生在 N=2 到 N=3 之间)* |
| *(同上母机衍生)* | `KMap_V3_4Row_Approx` | **V3 Schema (N=4)** | **终局版**。全截断 4 行，包含特赦。面积节省 32%，功耗节省 26%。 |
| `KMap_V3_Final_SchemeD.scala` | `KMap_V3_Final_SchemeD` | **V3 Scheme D (The Crown)**| 实际上等价于 `KMap_V3_4Row_Approx`。保留单独的 Scala 文件并命名为 `Final_SchemeD` 是为了纪念这一极值突破。 |

---

## 🏛️ 第二章：`archive/` 历史纪元大坟墓说明函

如果您在阅读论文时，想要去挖掘 `BARC` 是怎么做的，或者前几代（未抛弃门控）的 `Pure_Approx` 是怎么写的，请下沉到对应的归档区寻找：

1. **`v1_exploration/` (远古 V1 纪元)**
   - 包含文件：`RegularBooth8*.scala`
   - 背景：试图用纯卡诺图去压缩。体积庞杂，性能奇差。
2. **`v2_exploration/` (旧帝国 V2 纪元)**
   - 包含文件：`KMap_Mixed_Approx.scala` (注意与外面的 V3_Mixed 区分)
   - 背景：已经发现了 4 行截断法。**但是算子内部包含了 `is_zero` 判断**，加法树采用的是人工位移 OR （缝隙回填）。这是后来我们痛定思痛去改写 V3 的原罪来源。
3. **`v3_sub_experiments/` (百团大战 V3 子验证)**
   - 包含文件：`KMap_V3_Exp...scala`
   - 背景：我们在寻找“特赦谁最划算”时的实验废案（比如试过 3A1E、2A2E、和纯粹 Base 无任何特赦版）。

---

## 🌟 第三章：辅助系统支撑 (GatedPE)

根目录不仅有算子，还有唯一的系统级外壳：
*   **`GatedPE.scala`**：
    这是为了后续和 `gemmini` 深度绑定（并且向审稿人证明可以动态调频降本）而写的 **系统级操作数隔离封装壳**。
    也是 Agent 2 负责 `Visual Lab` (可视化动态水管演示) 时的主要逻辑宿主！
