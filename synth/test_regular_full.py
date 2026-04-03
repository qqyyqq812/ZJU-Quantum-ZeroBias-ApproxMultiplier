#!/usr/bin/env python3
"""
RegularBooth8Full 仿真验证
验证 Neg 嵌入 + BARC 补偿后的 Mean Error
"""

import numpy as np

def booth_encode_approx(b_bits, is_row0=False):
    """近似 Radix-4 Booth 编码"""
    if b_bits == 0b000 or b_bits == 0b111:
        return 0, 0, True  # zero, two, is_zero
    elif b_bits == 0b001 or b_bits == 0b010:
        return 0, 0, False  # +A
    elif b_bits == 0b011:
        if is_row0:
            return 0, 0, False  # Row 0: 011 不出现，用 +A 占位（不会被选）
        else:
            return 0, 1, False  # Row 1+: two=1 → +2A → +A
    elif b_bits == 0b100:
        if is_row0:
            return 1, 1, False  # Row 0: 100 → -2A → -A (two=1)
        else:
            return 1, 1, False  # Row 1+: -2A → -A
    elif b_bits == 0b101 or b_bits == 0b110:
        return 1, 0, False  # -A
    else:
        raise ValueError(f"Invalid b_bits: {b_bits:03b}")

def regular_booth8_full(a, b):
    """
    RegularBooth8Full 软件模型
    - 位取反 PPG: ~A 而非 -A
    - Neg 位嵌入到下一行
    - BARC 补偿
    """
    # 符号扩展
    a_s = np.int8(a)
    a_is_zero = (a == 0)
    
    # b_extended = Cat(b, 0)
    b_ext = (b << 1) & 0x1FF
    
    # 4 行编码
    pp_raw = []
    neg_bits = []
    
    for i in range(4):
        shift = 2 * i
        b_bits = (b_ext >> shift) & 0b111
        neg, two, zero = booth_encode_approx(b_bits, is_row0=(i==0))
        
        row_is_zero = zero or a_is_zero
        neg_bits.append(0 if row_is_zero else neg)
        
        # 位取反：~A 而非 -A
        a_or_2a = (a << 1) if two else a
        pp_unsigned = (~a_or_2a & 0xFF) if neg else a_or_2a
        pp_raw.append(0 if row_is_zero else pp_unsigned)
    
    # Wallace Tree 阵列（18-bit）
    rows = []
    
    # Row 0: (1, ~S, PP[7:0], 0) << 0
    s0 = (pp_raw[0] >> 7) & 1
    rows.append((1 << 17) | ((~s0 & 1) << 16) | (pp_raw[0] << 8))
    
    # Row 1: (1, ~S, PP[7:0], Neg0, 0, 0) << 0
    s1 = (pp_raw[1] >> 7) & 1
    rows.append((1 << 17) | ((~s1 & 1) << 16) | (pp_raw[1] << 8) | (neg_bits[0] << 2))
    
    # Row 2: (1, ~S, PP[7:0], Neg1, 0, 0, 0, 0) << 0
    s2 = (pp_raw[2] >> 7) & 1
    rows.append((1 << 17) | ((~s2 & 1) << 16) | (pp_raw[2] << 8) | (neg_bits[1] << 4))
    
    # Row 3: (1, ~S, PP[7:0], Neg2, 0, 0, 0, 0, 0, 0) << 0
    s3 = (pp_raw[3] >> 7) & 1
    rows.append((1 << 17) | ((~s3 & 1) << 16) | (pp_raw[3] << 8) | (neg_bits[2] << 6))
    
    # Neg3 单独贡献
    neg3_contrib = neg_bits[3] << 15
    
    # BARC 补偿
    row0_is_100 = ((b_ext & 0b111) == 0b100)
    barc = (-a_s if (row0_is_100 and not a_is_zero) else 0)
    
    # 累加（18-bit 有符号）
    sum_val = 0
    for row in rows:
        # 转换为 18-bit 有符号
        if row & (1 << 17):
            sum_val += row - (1 << 18)
        else:
            sum_val += row
    
    # Neg3 和 BARC
    sum_val += (neg3_contrib - (1 << 16) if neg3_contrib & (1 << 15) else neg3_contrib)
    sum_val += barc
    
    # 截取 16-bit
    result = sum_val & 0xFFFF
    if result & 0x8000:
        result -= 0x10000
    
    return result

# 全遍历测试
if __name__ == "__main__":
    errors = []
    total = 0
    
    print("Testing RegularBooth8Full...")
    for a in range(256):
        for b in range(256):
            # 转换为有符号 int8（-128 ~ 127）
            a_s = a if a < 128 else a - 256
            b_s = b if b < 128 else b - 256
            golden = a_s * b_s
            
            approx = regular_booth8_full(a, b)
            error = approx - golden
            
            if error != 0:
                errors.append(error)
            total += 1
    
    mean_error = sum(errors) / total if errors else 0.0
    
    print(f"\nTotal samples: {total}")
    print(f"Error count: {len(errors)}")
    print(f"Mean error: {mean_error}")
    print(f"Total error: {sum(errors)}")
    
    if abs(mean_error) < 0.001:
        print("\n✅ PASS: Zero-Bias achieved!")
    else:
        print(f"\n❌ FAIL: Mean error = {mean_error}")
        print("\nFirst 10 errors:")
        for i, err in enumerate(errors[:10]):
            print(f"  {i+1}. {err}")
