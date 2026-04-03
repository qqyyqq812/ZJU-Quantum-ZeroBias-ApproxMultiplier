import torch
import torch.nn as nn
import torch.nn.functional as F
from torchvision import models
import numpy as np
import os
import json
import time

# ======= 动态传参区 (配置防断联) =======
SAVE_DIR = "results_local"
SAVE_FILE = os.path.join(SAVE_DIR, "eval_history.json")
START_LAYER = 30 # Layer depth where Approximation begins 
BATCH_SIZE = 8   
EVAL_STEPS = 1000  

device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
os.makedirs(SAVE_DIR, exist_ok=True)

print("🚀 [Live Ammo] 初始化实弹发射框架. Device:", device)

# --- 装载 Agent 1 锻造的真理 64KB LUT ---
LUT_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), "luts")
if not os.path.exists(os.path.join(LUT_DIR, "lut_exact.npy")):
    raise FileNotFoundError("未探测到 Agent 1 的 LUT 文件！请确认 luts/ 目录存在并包含 .npy")

lut_exact_flat = torch.from_numpy(np.load(f"{LUT_DIR}/lut_exact.npy").flatten()).to(device)
lut_unbiased_flat = torch.from_numpy(np.load(f"{LUT_DIR}/lut_unbiased.npy").flatten()).to(device)

LUT_DICT = {
    'Exact': lut_exact_flat,
    'Unbiased': lut_unbiased_flat
}

# --- 核弹头: Agent 1 ApproxConv2d ---
class ApproxConv2d(nn.Conv2d):
    def forward(self, input: torch.Tensor) -> torch.Tensor:
        if self.groups > 1:
             return super().forward(input)

        lut = LUT_DICT['Unbiased']
        exact_lut = LUT_DICT['Exact']
        
        w_max = self.weight.abs().max().clamp(min=1e-5)
        x_max = input.abs().max().clamp(min=1e-5)
        w_scale = 127.0 / w_max
        x_scale = 127.0 / x_max
        
        W_q = torch.round(self.weight * w_scale).clamp(-128, 127).to(torch.int32)
        X_q = torch.round(input * x_scale).clamp(-128, 127).to(torch.int32) 
        
        X_unf = F.unfold(X_q.float(), self.kernel_size, self.dilation, self.padding, self.stride).to(torch.int32)
        N, CKK, L = X_unf.shape
        out_c = W_q.shape[0]
        
        W_q = W_q.view(out_c, -1).to(torch.uint8).long()
        X_unf = X_unf.to(torch.uint8).long()
        
        out_q_list = []
        
        for b in range(N):
            x_b = X_unf[b]
            W_br = W_q.unsqueeze(2).expand(out_c, CKK, L)
            X_br = x_b.unsqueeze(0).expand(out_c, CKK, L)
            
            idx = X_br.to(device) * 256 + W_br.to(device)
            prods_approx = torch.take(lut, idx)
            out_q_b = prods_approx.sum(dim=1).float()
            out_q_list.append(out_q_b)
            
        out_q = torch.stack(out_q_list)
        out = out_q / (w_scale * x_scale)
        
        H_out = int(np.sqrt(L))
        out = out.view(N, out_c, H_out, H_out)
        
        if self.bias is not None:
            out += self.bias.view(1, -1, 1, 1)
            
        return out

# ALWANN 层级替换法 (只在深层启动)
def apply_alwann_replacement(model, start_layer_idx):
    conv_idx = 0
    def replace_recursive(module):
        nonlocal conv_idx
        for name, child in module.named_children():
            if isinstance(child, nn.Conv2d):
                if conv_idx >= start_layer_idx:
                    new_layer = ApproxConv2d(
                        child.in_channels, child.out_channels, child.kernel_size,
                        child.stride, child.padding, child.dilation, child.groups,
                        child.bias is not None
                    )
                    new_layer.weight.data.copy_(child.weight.data)
                    if child.bias is not None:
                        new_layer.bias.data.copy_(child.bias.data)
                    setattr(module, name, new_layer)
                conv_idx += 1
            else:
                replace_recursive(child)
    replace_recursive(model)


def load_checkpoint():
    if os.path.exists(SAVE_FILE):
        try:
            with open(SAVE_FILE, 'r') as f:
                data = json.load(f)
            print(f"🔥 检测到有效云盘历史结界，恢复至 Step -> {data['step']}")
            return data['step'], data['cos_sims']
        except Exception as e:
            print("读取历史检查点失败，将全新开始: ", e)
    return 0, []

def save_checkpoint(step, cos_sims):
    data = {'step': step, 'cos_sims': cos_sims, 'timestamp': time.time()}
    tmp_file = SAVE_FILE + ".tmp"
    with open(tmp_file, 'w') as f:
        json.dump(data, f)
    os.replace(tmp_file, SAVE_FILE)

def execute_evaluation_loop():
    print(f"=== 🚀 启动装药版 ALWANN 实代评估！切入阈值层: {START_LAYER} ===")
    
    current_step, cos_sim_history = load_checkpoint()
    
    if current_step >= EVAL_STEPS:
        print("🎉 该实验配置的评估任务已通关！")
        return
        
    print("⏳ 装载并替换模型卷积层 (Agent1 ZB-ALUT)...")
    # 建立双轴对比：一个完美Baseline，一个 ALWANN-LUT 模型
    model_exact = models.resnet50(pretrained=False).to(device)
    model_approx = models.resnet50(pretrained=False).to(device)
    
    # 将模型精确权重迁移给两个实例保持对比一致性
    model_approx.load_state_dict(model_exact.state_dict())
    
    # 实弹植入
    apply_alwann_replacement(model_approx, START_LAYER)
    
    model_exact.eval()
    model_approx.eval()
    
    print("🔥 LUT 实弹火控通过检测，进入推断回圈...")
    # 为了保证相同的测试用例可复现
    torch.manual_seed(42)
    
    for step in range(current_step, EVAL_STEPS):
        # ImageNet 仿真批次输入雷达
        dummy_input = torch.randn(BATCH_SIZE, 3, 224, 224).to(device)
        
        with torch.no_grad():
            out_exact = model_exact(dummy_input)
            out_approx = model_approx(dummy_input)
            
        # 计算该 Batch 的输出向量余弦相似度
        cos_sim = F.cosine_similarity(out_exact.flatten(), out_approx.flatten(), dim=0).item()
        cos_sim = max(0.0, cos_sim)
        
        cos_sim_history.append(float(cos_sim))
        
        # 为了防抖，每 10 步强制落盘一次（真实GPU运算代价很大，随时可能被抢占）
        if (step + 1) % 10 == 0:
            print(f"--- 进度通报: {step+1}/{EVAL_STEPS} | Batch_Cos_Sim: {cos_sim:.5f} --")
            save_checkpoint(step + 1, cos_sim_history)
            
    # 终局锁盘
    save_checkpoint(EVAL_STEPS, cos_sim_history)
    print("✅ 全部评估流程执行完毕，物理隔离区数据已落锁！")

if __name__ == "__main__":
    execute_evaluation_loop()
