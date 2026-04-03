# 📐 Agent 2 系统仿真指南 (Methodology)

> **导语**：本指南熔铸了 Agent 2 在实践中对“底层 RTL 连线局限性”的深刻反思，结合了 Director（总控台）对国际体系结构顶刊（TC/DAC/ICCAD）标准评估模型的深度溯源调研。此为本作战区评估阶段的最高学术宪法。

## 一、 方法论的纠偏与确立

> [!WARNING]
> ### ❌ 摒弃“研发工程师视角”（过度工程化陷阱）
> *   **误区回放**：曾经试图深入修改 Chisel，为执行控制器（ExecuteController）连线，并使用 Verilator 抓取 VCD 波形测算全系统功耗。
> *   **为何致命**：顶刊评审极不认同用功能仿真（Verilator）直接套估真实芯片功耗。且在底层布线上花再多时间，也不能为最终的“精度-系统耗能”图谱增加一丝一毫的理论置信度。

> [!TIP]
> ### ✅ 确立“架构师学术视角”（代数聚合与代理映射）
> *   顶会的标答并不是把上亿晶体的 SoC 放进 PTPX 死磕，而是 **解析聚合（Analytical Aggregation）+ 行为级建模**。
> *   通过将系统解耦为“宏观骨架调度代价”与“微观算子能量”，用代数合成物理系统的宏观表现。极大加速论证且无懈可击。

## 二、 顶级仿真的落地路线 (The Sign-off Approach)

### 1. 精度侧 (Accuracy)：基于 LUT 的功能靶场突破
*   由于我们的算子强在应对大模型稀疏性，测试标准必须上探至 **ResNet-50**。
> [!IMPORTANT]
> *   **软件替代策略**：绝不跑缓慢的硬件级仿真！使用 Agent 1 提炼的 64KB 级极致对照查找表 (LUT)，在纯 C / PyTorch 代码中执行数学替换。这能与底层 Verilog 保持 100% 的比特物理级误差等效，并能在几分钟内跑发几十万张图片，得出各种 ALWANN 跳档配置下的准确度损率。

### 2. 功耗侧 (Power/Energy)：原生计数器与代数拼合
*   利用未魔改过的原生 Gemmini Spike 环境去跑基础版 C 测例（如 `resnet50_quick.c`），拉出**原生系统对主干、SRAM 内存调度的极准确性能基数（Performance Counters）**和整体相乘总数（MAC Ops）。
*   结合软件拦截测出的“绝对值为0”的比例（命中零控门），扣减无效操作。
*   利用 Agent 1 在 DC 中跑出的确凿数据（-34.54% 面积，-37.32% 功耗），按照以下公式刚性合成全盘系统功耗：
    $$E_{System} = E_{Base\_SRAM\_Dispatch} + \sum \left( Ops \times (1 - P_{zero}) \times (\text{Agent1\_MAC\_PPA}) \right)$$

## 三、 硬核实施流水线 (防卡死与环境白盒规范)

为彻底根除“黑盒等待”焦虑并防范终端静默卡死，所有流水线动作必须按以下白盒细则执行：

> [!CAUTION]
> ### 💥 战区 A：准确率测点靶场 (Colab Zero-Touch 一键部署模式)
> **受众与核心纲领**：主理人已腾出 Colab 算力位。Agent 2 必须将其当作远端云端集装箱来开发，**严格遵循 User 的“零接触” (Zero-Touch) 铁律**！（强烈参考文档：`/home/qq/projects/量子电路/docs/technical/Workflow_Colab_ZeroTouch_Agentic_Deployment.md`）
> 
> **底层执行物 (Repository Python 代码)**：
> Agent 2 需在本地目录写死所有底层算法：
> 1. 编写桥接主脚本 `eval_resnet_lut_proxy.py`：使用深度学习框架注入 Agent 1 传过来的 64KB `ZBA-LUT` 进行卷积层软替换运算。
> 2. **断点高频落盘机制 (Interrupt-Resume)**：单次 ImageNet/CIFAR-10 全推理在云端耗时也较长，代码中必须实现：每处理 100 批次即往挂载目录覆盖写入 `eval_history.json`。确保主理人随时掐停查看时，不丢失验证进度。
> 
> **云端起飞板构造 (.ipynb 范式化编写)**：
> Agent 2 需为 Colab 量身定做一份包含如下机制的 `.ipynb` 发射台配置：
> 1. **强制读盘清洗 & Repo 热更新**：首行执行 `%cd /content`，`!rm -rf [当前仓库名]`，强制进行全新的 `git clone`，确保云盘不会读取到历史脏代码！
> 2. **自动防断联注入 (KeepAlive)**：利用 `IPython.display.Javascript` 直接在后台 `setInterval` 点击前端页面，保障云容器挂夜机时不掉线断联。
> 3. **极度解耦的数据层**：强制调用 `drive.mount` 挂载 Google Drive，并使用硬链接或软链接，将输出数据锚入特定的隔离版面目录下（如 `results/resnet_eval_v1/`）。
> 
> **交付指令**：
> Agent 2 绝不可以直接让主理人在网页上黏贴代码。代码改完后，必须在本地执行 `git commit && git push` 全线上云，并告知主理人：**“发射台已推流完成，请去浏览器刷新并点击 Run All！”**

> [!TIP]
> ### 💥 战区 B：底盘架构操作数扒取 (本地 Chipyard 工作区)
> **环境要求**：原生的 WSL2 目录 (`gemmini-rocc-tests`)。
> **核心任务**：直接编译尚未被魔改架构污染的 `resnet50_quick.c`。
> **执行命令**：`spike --extension=gemmini pk build/bareMetalC/resnet50_quick-baremetal`。利用 **Spike (RISC-V ISA 指令级模拟器)** 极速扒取原生 Gemmini 执行时的总体主干算数（如 `total_MACs`, `total_SRAM_accesses`）。
> **耗时与防挂起守则**：
> 1. Spike 模拟在本地预期仅需 **5 - 15 分钟**。
> 2. **强制铁律**：严禁调用极为缓慢的 Verilator 系统级软仿。在包裹 Bash 执行流时加上 `timeout 30m` 的守护进程指令。

> [!IMPORTANT]
> ### 💥 战区 C：代数大合并与帕累托绘图 (本地前端脚本)
> **环境要求**：本地轻量级 Python 环境 + `matplotlib`。
> **核心任务**：叠合战区A（准确率下坠点）和战区B（操作宏观基数），写入战区C的汇总数学脚本，瞬间输出多参数情况下的 2D 帕累托散点坐标。预期耗时：**瞬间 (< 5S)**。


## 三、 结论与意义
放弃死板的全栈 RTL 实现证明，使用严谨数学模型解耦评估，完全接轨前沿顶刊的评价套路。不仅让整个系统级论文的论证速度提高了上百倍，并以绝对的数据清晰度规避了繁琐 Bug 对大决战进程的阻挠。
