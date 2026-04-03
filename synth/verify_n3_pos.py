import sys

def to_signed(val, bits=8):
    if val >= (1 << (bits - 1)):
        return val - (1 << bits)
    return val

def booth_encode(b_bits):
    if b_bits == 0b000 or b_bits == 0b111: return 0, 0, True
    elif b_bits == 0b001 or b_bits == 0b010: return 0, 0, False
    elif b_bits == 0b011: return 0, 1, False
    elif b_bits == 0b100: return 1, 1, False
    elif b_bits == 0b101 or b_bits == 0b110: return 1, 0, False
    return 0, 0, True

def run_test():
    errors = []
    
    for a in range(256):
        a_s = to_signed(a, 8)
        
        for b in range(256):
            b_s = to_signed(b, 8)
            golden = a_s * b_s
            
            b_ext = (b << 1) & 0x1FF
            
            sum_val = 0
            for i in range(4):
                b_slice = (b_ext >> (2*i)) & 0b111
                
                # BARC special handling for Row 0
                if i == 0 and b_slice == 0b100:
                    neg, two, zero = 1, 1, False  # -2A normally
                    # but encoder might trick to +A? 
                    # Wait, no. Standard encoder: 100 is -2A.
                
                neg, two, zero = booth_encode(b_slice)
                
                # if row0_is_100 and !a_is_zero -> BARC adds -A.
                
                pp_base = (a_s << 1) if two else a_s
                
                if zero:
                    pp = 0
                else:
                    if neg:
                        pp = -pp_base - 1
                        # Compensate immediately at position 2i
                        sum_val += (1 << (2*i))
                    else:
                        pp = pp_base
                
                sum_val += (pp << (2*i))
                
            errors.append(sum_val - golden)
            
    return sum(errors) / len(errors)

if __name__ == "__main__":
    print(f"Mean error with +1 at 2i: {run_test()}")
