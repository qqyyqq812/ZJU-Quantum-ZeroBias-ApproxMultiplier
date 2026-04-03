FIRRTL version 1.2.0
circuit DynamicApproxMultiplier :
  module R4ABE2_Dynamic :
    input clock : Clock
    input reset : UInt<1>
    input io_b_bits : UInt<3> @[src/main/scala/empty/DynamicApproxMultiplier.scala 29:14]
    input io_is_approx : UInt<1> @[src/main/scala/empty/DynamicApproxMultiplier.scala 29:14]
    output io_negate : UInt<1> @[src/main/scala/empty/DynamicApproxMultiplier.scala 29:14]
    output io_zero : UInt<1> @[src/main/scala/empty/DynamicApproxMultiplier.scala 29:14]
    output io_two : UInt<1> @[src/main/scala/empty/DynamicApproxMultiplier.scala 29:14]

    node _io_negate_T = bits(io_b_bits, 2, 2) @[src/main/scala/empty/DynamicApproxMultiplier.scala 39:25]
    node _io_zero_T = eq(io_b_bits, UInt<1>("h0")) @[src/main/scala/empty/DynamicApproxMultiplier.scala 43:27]
    node _io_zero_T_1 = eq(io_b_bits, UInt<3>("h7")) @[src/main/scala/empty/DynamicApproxMultiplier.scala 43:50]
    node _io_zero_T_2 = or(_io_zero_T, _io_zero_T_1) @[src/main/scala/empty/DynamicApproxMultiplier.scala 43:36]
    node _two_exact_T = eq(io_b_bits, UInt<2>("h3")) @[src/main/scala/empty/DynamicApproxMultiplier.scala 48:30]
    node _two_exact_T_1 = eq(io_b_bits, UInt<3>("h4")) @[src/main/scala/empty/DynamicApproxMultiplier.scala 48:53]
    node two_exact = or(_two_exact_T, _two_exact_T_1) @[src/main/scala/empty/DynamicApproxMultiplier.scala 48:39]
    node _io_two_T = mux(io_is_approx, UInt<1>("h0"), two_exact) @[src/main/scala/empty/DynamicApproxMultiplier.scala 49:16]
    io_negate <= _io_negate_T @[src/main/scala/empty/DynamicApproxMultiplier.scala 39:13]
    io_zero <= _io_zero_T_2 @[src/main/scala/empty/DynamicApproxMultiplier.scala 43:13]
    io_two <= _io_two_T @[src/main/scala/empty/DynamicApproxMultiplier.scala 49:10]

  module PartialProductGenerator :
    input clock : Clock
    input reset : UInt<1>
    input io_a : SInt<8> @[src/main/scala/empty/DynamicApproxMultiplier.scala 61:14]
    input io_negate : UInt<1> @[src/main/scala/empty/DynamicApproxMultiplier.scala 61:14]
    output io_partial_product : SInt<9> @[src/main/scala/empty/DynamicApproxMultiplier.scala 61:14]

    node a_ext = pad(io_a, 9) @[src/main/scala/empty/DynamicApproxMultiplier.scala 68:19 69:9]
    node _io_partial_product_T = sub(asSInt(UInt<1>("h0")), a_ext) @[src/main/scala/empty/DynamicApproxMultiplier.scala 72:40]
    node _io_partial_product_T_1 = tail(_io_partial_product_T, 1) @[src/main/scala/empty/DynamicApproxMultiplier.scala 72:40]
    node _io_partial_product_T_2 = asSInt(_io_partial_product_T_1) @[src/main/scala/empty/DynamicApproxMultiplier.scala 72:40]
    node _io_partial_product_T_3 = mux(io_negate, _io_partial_product_T_2, a_ext) @[src/main/scala/empty/DynamicApproxMultiplier.scala 72:28]
    io_partial_product <= _io_partial_product_T_3 @[src/main/scala/empty/DynamicApproxMultiplier.scala 72:22]

  module ApproxWallaceTree :
    input clock : Clock
    input reset : UInt<1>
    input io_shifted_partial_products_0 : SInt<16> @[src/main/scala/empty/DynamicApproxMultiplier.scala 84:14]
    input io_shifted_partial_products_1 : SInt<16> @[src/main/scala/empty/DynamicApproxMultiplier.scala 84:14]
    input io_shifted_partial_products_2 : SInt<16> @[src/main/scala/empty/DynamicApproxMultiplier.scala 84:14]
    input io_shifted_partial_products_3 : SInt<16> @[src/main/scala/empty/DynamicApproxMultiplier.scala 84:14]
    output io_final_product : SInt<16> @[src/main/scala/empty/DynamicApproxMultiplier.scala 84:14]

    node _io_final_product_T = add(io_shifted_partial_products_0, io_shifted_partial_products_1) @[src/main/scala/empty/DynamicApproxMultiplier.scala 90:64]
    node _io_final_product_T_1 = add(io_shifted_partial_products_2, io_shifted_partial_products_3) @[src/main/scala/empty/DynamicApproxMultiplier.scala 90:64]
    node _io_final_product_T_2 = add(_io_final_product_T, _io_final_product_T_1) @[src/main/scala/empty/DynamicApproxMultiplier.scala 90:64]
    io_final_product <= asSInt(bits(_io_final_product_T_2, 15, 0)) @[src/main/scala/empty/DynamicApproxMultiplier.scala 90:20]

  module DynamicApproxMultiplier :
    input clock : Clock
    input reset : UInt<1>
    input io_multiplicand : SInt<8> @[src/main/scala/empty/DynamicApproxMultiplier.scala 108:14]
    input io_multiplier : SInt<8> @[src/main/scala/empty/DynamicApproxMultiplier.scala 108:14]
    input io_approx_level : UInt<2> @[src/main/scala/empty/DynamicApproxMultiplier.scala 108:14]
    output io_product : SInt<16> @[src/main/scala/empty/DynamicApproxMultiplier.scala 108:14]

    inst encoders_0 of R4ABE2_Dynamic @[src/main/scala/empty/DynamicApproxMultiplier.scala 119:36]
    inst encoders_1 of R4ABE2_Dynamic @[src/main/scala/empty/DynamicApproxMultiplier.scala 119:36]
    inst encoders_2 of R4ABE2_Dynamic @[src/main/scala/empty/DynamicApproxMultiplier.scala 119:36]
    inst encoders_3 of R4ABE2_Dynamic @[src/main/scala/empty/DynamicApproxMultiplier.scala 119:36]
    inst ppgs_0 of PartialProductGenerator @[src/main/scala/empty/DynamicApproxMultiplier.scala 120:36]
    inst ppgs_1 of PartialProductGenerator @[src/main/scala/empty/DynamicApproxMultiplier.scala 120:36]
    inst ppgs_2 of PartialProductGenerator @[src/main/scala/empty/DynamicApproxMultiplier.scala 120:36]
    inst ppgs_3 of PartialProductGenerator @[src/main/scala/empty/DynamicApproxMultiplier.scala 120:36]
    inst wallace_tree of ApproxWallaceTree @[src/main/scala/empty/DynamicApproxMultiplier.scala 182:28]
    node b_extended_hi = asUInt(io_multiplier) @[src/main/scala/empty/DynamicApproxMultiplier.scala 116:23]
    node b_extended = cat(b_extended_hi, UInt<1>("h0")) @[src/main/scala/empty/DynamicApproxMultiplier.scala 116:23]
    node a_is_zero = eq(io_multiplicand, asSInt(UInt<1>("h0"))) @[src/main/scala/empty/DynamicApproxMultiplier.scala 125:36]
    node _row_is_approx_0_T = lt(UInt<1>("h0"), io_approx_level) @[src/main/scala/empty/DynamicApproxMultiplier.scala 137:30]
    node _row_is_approx_1_T = lt(UInt<1>("h1"), io_approx_level) @[src/main/scala/empty/DynamicApproxMultiplier.scala 137:30]
    node _row_is_approx_2_T = lt(UInt<2>("h2"), io_approx_level) @[src/main/scala/empty/DynamicApproxMultiplier.scala 137:30]
    node _row_is_approx_3_T = lt(UInt<2>("h3"), io_approx_level) @[src/main/scala/empty/DynamicApproxMultiplier.scala 137:30]
    node _encoders_0_io_b_bits_T = bits(b_extended, 2, 0) @[src/main/scala/empty/DynamicApproxMultiplier.scala 142:43]
    node row_is_zero = or(encoders_0.io_zero, a_is_zero) @[src/main/scala/empty/DynamicApproxMultiplier.scala 152:43]
    node _pp_signed_T = shl(ppgs_0.io_partial_product, 1) @[src/main/scala/empty/DynamicApproxMultiplier.scala 161:50]
    node _pp_signed_T_1 = mux(encoders_0.io_two, _pp_signed_T, ppgs_0.io_partial_product) @[src/main/scala/empty/DynamicApproxMultiplier.scala 161:21]
    node pp_signed = _pp_signed_T_1 @[src/main/scala/empty/DynamicApproxMultiplier.scala 160:25 161:15]
    node _pp_gated_T = mux(row_is_zero, asSInt(UInt<1>("h0")), pp_signed) @[src/main/scala/empty/DynamicApproxMultiplier.scala 165:20]
    node pp_gated = _pp_gated_T @[src/main/scala/empty/DynamicApproxMultiplier.scala 164:24 165:14]
    node pp_extended = pad(pp_gated, 16) @[src/main/scala/empty/DynamicApproxMultiplier.scala 168:27 169:17]
    node _partial_products_0_T = shl(pp_extended, 0) @[src/main/scala/empty/DynamicApproxMultiplier.scala 178:41]
    node _partial_products_0_T_1 = shl(asSInt(UInt<16>("h0")), 0) @[src/main/scala/empty/DynamicApproxMultiplier.scala 178:78]
    node _partial_products_0_T_2 = add(_partial_products_0_T, _partial_products_0_T_1) @[src/main/scala/empty/DynamicApproxMultiplier.scala 178:60]
    node _partial_products_0_T_3 = tail(_partial_products_0_T_2, 1) @[src/main/scala/empty/DynamicApproxMultiplier.scala 178:60]
    node _partial_products_0_T_4 = asSInt(_partial_products_0_T_3) @[src/main/scala/empty/DynamicApproxMultiplier.scala 178:60]
    node _encoders_1_io_b_bits_T = bits(b_extended, 4, 2) @[src/main/scala/empty/DynamicApproxMultiplier.scala 142:43]
    node row_is_zero_1 = or(encoders_1.io_zero, a_is_zero) @[src/main/scala/empty/DynamicApproxMultiplier.scala 152:43]
    node _pp_signed_T_2 = shl(ppgs_1.io_partial_product, 1) @[src/main/scala/empty/DynamicApproxMultiplier.scala 161:50]
    node _pp_signed_T_3 = mux(encoders_1.io_two, _pp_signed_T_2, ppgs_1.io_partial_product) @[src/main/scala/empty/DynamicApproxMultiplier.scala 161:21]
    node pp_signed_1 = _pp_signed_T_3 @[src/main/scala/empty/DynamicApproxMultiplier.scala 160:25 161:15]
    node _pp_gated_T_1 = mux(row_is_zero_1, asSInt(UInt<1>("h0")), pp_signed_1) @[src/main/scala/empty/DynamicApproxMultiplier.scala 165:20]
    node pp_gated_1 = _pp_gated_T_1 @[src/main/scala/empty/DynamicApproxMultiplier.scala 164:24 165:14]
    node pp_extended_1 = pad(pp_gated_1, 16) @[src/main/scala/empty/DynamicApproxMultiplier.scala 168:27 169:17]
    node _partial_products_1_T = shl(pp_extended_1, 2) @[src/main/scala/empty/DynamicApproxMultiplier.scala 178:41]
    node _partial_products_1_T_1 = shl(asSInt(UInt<16>("h0")), 2) @[src/main/scala/empty/DynamicApproxMultiplier.scala 178:78]
    node _partial_products_1_T_2 = add(_partial_products_1_T, _partial_products_1_T_1) @[src/main/scala/empty/DynamicApproxMultiplier.scala 178:60]
    node _partial_products_1_T_3 = tail(_partial_products_1_T_2, 1) @[src/main/scala/empty/DynamicApproxMultiplier.scala 178:60]
    node _partial_products_1_T_4 = asSInt(_partial_products_1_T_3) @[src/main/scala/empty/DynamicApproxMultiplier.scala 178:60]
    node _encoders_2_io_b_bits_T = bits(b_extended, 6, 4) @[src/main/scala/empty/DynamicApproxMultiplier.scala 142:43]
    node row_is_zero_2 = or(encoders_2.io_zero, a_is_zero) @[src/main/scala/empty/DynamicApproxMultiplier.scala 152:43]
    node _pp_signed_T_4 = shl(ppgs_2.io_partial_product, 1) @[src/main/scala/empty/DynamicApproxMultiplier.scala 161:50]
    node _pp_signed_T_5 = mux(encoders_2.io_two, _pp_signed_T_4, ppgs_2.io_partial_product) @[src/main/scala/empty/DynamicApproxMultiplier.scala 161:21]
    node pp_signed_2 = _pp_signed_T_5 @[src/main/scala/empty/DynamicApproxMultiplier.scala 160:25 161:15]
    node _pp_gated_T_2 = mux(row_is_zero_2, asSInt(UInt<1>("h0")), pp_signed_2) @[src/main/scala/empty/DynamicApproxMultiplier.scala 165:20]
    node pp_gated_2 = _pp_gated_T_2 @[src/main/scala/empty/DynamicApproxMultiplier.scala 164:24 165:14]
    node pp_extended_2 = pad(pp_gated_2, 16) @[src/main/scala/empty/DynamicApproxMultiplier.scala 168:27 169:17]
    node _partial_products_2_T = shl(pp_extended_2, 4) @[src/main/scala/empty/DynamicApproxMultiplier.scala 178:41]
    node _partial_products_2_T_1 = shl(asSInt(UInt<16>("h0")), 4) @[src/main/scala/empty/DynamicApproxMultiplier.scala 178:78]
    node _partial_products_2_T_2 = add(_partial_products_2_T, _partial_products_2_T_1) @[src/main/scala/empty/DynamicApproxMultiplier.scala 178:60]
    node _partial_products_2_T_3 = tail(_partial_products_2_T_2, 1) @[src/main/scala/empty/DynamicApproxMultiplier.scala 178:60]
    node _partial_products_2_T_4 = asSInt(_partial_products_2_T_3) @[src/main/scala/empty/DynamicApproxMultiplier.scala 178:60]
    node _encoders_3_io_b_bits_T = bits(b_extended, 8, 6) @[src/main/scala/empty/DynamicApproxMultiplier.scala 142:43]
    node row_is_zero_3 = or(encoders_3.io_zero, a_is_zero) @[src/main/scala/empty/DynamicApproxMultiplier.scala 152:43]
    node _pp_signed_T_6 = shl(ppgs_3.io_partial_product, 1) @[src/main/scala/empty/DynamicApproxMultiplier.scala 161:50]
    node _pp_signed_T_7 = mux(encoders_3.io_two, _pp_signed_T_6, ppgs_3.io_partial_product) @[src/main/scala/empty/DynamicApproxMultiplier.scala 161:21]
    node pp_signed_3 = _pp_signed_T_7 @[src/main/scala/empty/DynamicApproxMultiplier.scala 160:25 161:15]
    node _pp_gated_T_3 = mux(row_is_zero_3, asSInt(UInt<1>("h0")), pp_signed_3) @[src/main/scala/empty/DynamicApproxMultiplier.scala 165:20]
    node pp_gated_3 = _pp_gated_T_3 @[src/main/scala/empty/DynamicApproxMultiplier.scala 164:24 165:14]
    node pp_extended_3 = pad(pp_gated_3, 16) @[src/main/scala/empty/DynamicApproxMultiplier.scala 168:27 169:17]
    node _partial_products_3_T = shl(pp_extended_3, 6) @[src/main/scala/empty/DynamicApproxMultiplier.scala 178:41]
    node _partial_products_3_T_1 = shl(asSInt(UInt<16>("h0")), 6) @[src/main/scala/empty/DynamicApproxMultiplier.scala 178:78]
    node _partial_products_3_T_2 = add(_partial_products_3_T, _partial_products_3_T_1) @[src/main/scala/empty/DynamicApproxMultiplier.scala 178:60]
    node _partial_products_3_T_3 = tail(_partial_products_3_T_2, 1) @[src/main/scala/empty/DynamicApproxMultiplier.scala 178:60]
    node _partial_products_3_T_4 = asSInt(_partial_products_3_T_3) @[src/main/scala/empty/DynamicApproxMultiplier.scala 178:60]
    node partial_products_0 = _partial_products_0_T_4 @[src/main/scala/empty/DynamicApproxMultiplier.scala 122:30 178:25]
    node partial_products_1 = asSInt(bits(_partial_products_1_T_4, 15, 0)) @[src/main/scala/empty/DynamicApproxMultiplier.scala 122:30 178:25]
    node partial_products_2 = asSInt(bits(_partial_products_2_T_4, 15, 0)) @[src/main/scala/empty/DynamicApproxMultiplier.scala 122:30 178:25]
    node partial_products_3 = asSInt(bits(_partial_products_3_T_4, 15, 0)) @[src/main/scala/empty/DynamicApproxMultiplier.scala 122:30 178:25]
    node row_is_approx_0 = _row_is_approx_0_T @[src/main/scala/empty/DynamicApproxMultiplier.scala 129:27 137:22]
    node row_is_approx_1 = _row_is_approx_1_T @[src/main/scala/empty/DynamicApproxMultiplier.scala 129:27 137:22]
    node row_is_approx_2 = _row_is_approx_2_T @[src/main/scala/empty/DynamicApproxMultiplier.scala 129:27 137:22]
    node row_is_approx_3 = _row_is_approx_3_T @[src/main/scala/empty/DynamicApproxMultiplier.scala 129:27 137:22]
    io_product <= wallace_tree.io_final_product @[src/main/scala/empty/DynamicApproxMultiplier.scala 184:14]
    encoders_0.clock <= clock
    encoders_0.reset <= reset
    encoders_0.io_b_bits <= _encoders_0_io_b_bits_T @[src/main/scala/empty/DynamicApproxMultiplier.scala 142:30]
    encoders_0.io_is_approx <= row_is_approx_0 @[src/main/scala/empty/DynamicApproxMultiplier.scala 143:30]
    encoders_1.clock <= clock
    encoders_1.reset <= reset
    encoders_1.io_b_bits <= _encoders_1_io_b_bits_T @[src/main/scala/empty/DynamicApproxMultiplier.scala 142:30]
    encoders_1.io_is_approx <= row_is_approx_1 @[src/main/scala/empty/DynamicApproxMultiplier.scala 143:30]
    encoders_2.clock <= clock
    encoders_2.reset <= reset
    encoders_2.io_b_bits <= _encoders_2_io_b_bits_T @[src/main/scala/empty/DynamicApproxMultiplier.scala 142:30]
    encoders_2.io_is_approx <= row_is_approx_2 @[src/main/scala/empty/DynamicApproxMultiplier.scala 143:30]
    encoders_3.clock <= clock
    encoders_3.reset <= reset
    encoders_3.io_b_bits <= _encoders_3_io_b_bits_T @[src/main/scala/empty/DynamicApproxMultiplier.scala 142:30]
    encoders_3.io_is_approx <= row_is_approx_3 @[src/main/scala/empty/DynamicApproxMultiplier.scala 143:30]
    ppgs_0.clock <= clock
    ppgs_0.reset <= reset
    ppgs_0.io_a <= io_multiplicand @[src/main/scala/empty/DynamicApproxMultiplier.scala 146:23]
    ppgs_0.io_negate <= encoders_0.io_negate @[src/main/scala/empty/DynamicApproxMultiplier.scala 147:23]
    ppgs_1.clock <= clock
    ppgs_1.reset <= reset
    ppgs_1.io_a <= io_multiplicand @[src/main/scala/empty/DynamicApproxMultiplier.scala 146:23]
    ppgs_1.io_negate <= encoders_1.io_negate @[src/main/scala/empty/DynamicApproxMultiplier.scala 147:23]
    ppgs_2.clock <= clock
    ppgs_2.reset <= reset
    ppgs_2.io_a <= io_multiplicand @[src/main/scala/empty/DynamicApproxMultiplier.scala 146:23]
    ppgs_2.io_negate <= encoders_2.io_negate @[src/main/scala/empty/DynamicApproxMultiplier.scala 147:23]
    ppgs_3.clock <= clock
    ppgs_3.reset <= reset
    ppgs_3.io_a <= io_multiplicand @[src/main/scala/empty/DynamicApproxMultiplier.scala 146:23]
    ppgs_3.io_negate <= encoders_3.io_negate @[src/main/scala/empty/DynamicApproxMultiplier.scala 147:23]
    wallace_tree.clock <= clock
    wallace_tree.reset <= reset
    wallace_tree.io_shifted_partial_products_0 <= partial_products_0 @[src/main/scala/empty/DynamicApproxMultiplier.scala 183:44]
    wallace_tree.io_shifted_partial_products_1 <= partial_products_1 @[src/main/scala/empty/DynamicApproxMultiplier.scala 183:44]
    wallace_tree.io_shifted_partial_products_2 <= partial_products_2 @[src/main/scala/empty/DynamicApproxMultiplier.scala 183:44]
    wallace_tree.io_shifted_partial_products_3 <= partial_products_3 @[src/main/scala/empty/DynamicApproxMultiplier.scala 183:44]
