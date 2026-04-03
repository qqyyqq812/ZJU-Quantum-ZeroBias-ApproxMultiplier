#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import sys

def to_signed(val, bits=8):
    if val >= (1 << (bits - 1)):
        return val - (1 << bits)
    return val

def booth_encode(b_bits):
    """标准的 Radix-4 Booth 编码器"""
    # b_bits: {b[i+1], b[i], b[i-1]}
    if b_bits == 0b000 or b_bits == 0b111:
         return 0, 0, True  # +0, -0
    elif b_bits == 0b001 or b_bits == 0b010:
         return 0, 0, False # +A
    elif b_bits == 0b011:
         return 0, 1, False # +2A
    elif b_bits == 0b100:
         return 1, 1, False # -2A
    elif b_bits == 0b101 or b_bits == 0b110:
         return 1, 0, False # -A
    return 0, 0, True

def run_test(use_true_neg=False):
    errors = []
    
    for a in range(256):
        a_s = to_signed(a, 8)
        
        for b in range(256):
            b_s = to_signed(b, 8)
            golden = a_s * b_s
            
            # Booth 编码过程
            b_ext = (b << 1) & 0x1FF # 补 0
            
            sum_val = 0
            for i in range(4):
                b_slice = (b_ext >> (2*i)) & 0b111
                neg, two, zero = booth_encode(b_slice)
                
                # 基准部分积
                pp_base = (a_s << 1) if two else a_s
                
                if zero:
                    pp = 0
                else:
                    if neg:
                        if use_true_neg:
                            pp = -pp_base
                        else:
                            # 模拟 ~A 的效果 (Python 里 ~x = -x - 1)
                            # 等同于在这一行的最低位缺了一个 "+1"
                            pp = -pp_base - 1
                    else:
                        pp = pp_base
                
                # 累加到正确的位置
                sum_val += (pp << (2*i))
                
            # 注意：如果使用 ~A 而不补偿，误差是恒为负的
            # 我们记录这种误差
            errors.append(sum_val - golden)
            
    mean_error = sum(errors) / len(errors)
    max_err = max(errors)
    min_err = min(errors)
    
    return mean_error, max_err, min_err

if __name__ == "__main__":
    print("=== 控制变量验证：Neg 取反位省略的系统偏差 ===")
    
    mean1, max1, min1 = run_test(use_true_neg=True)
    print(f"[1] 精确取反 (-A): Mean Error = {mean1:.4f}, Range = [{min1}, {max1}]")
    
    mean2, max2, min2 = run_test(use_true_neg=False)
    print(f"[2] 省略 +1 位 (~A, 无补偿): Mean Error = {mean2:.4f}, Range = [{min2}, {max2}]")
    
    print("\n结论：")
    if abs(mean2) > 0.0001:
         print(f"省略 +1 会导致不可抵消的单向系统偏差，Mean={mean2}。")
         print("原因为：~x = -x - 1。只要出现负部分积，必损失 1。由于移位操作，误差会被放大了 1, 4, 16, 64 倍！")
         print("这意味着负部分积越多，负系统偏差越严重，绝不会和正数互补！")
    else:
         print("偏差可以自动抵消。")
