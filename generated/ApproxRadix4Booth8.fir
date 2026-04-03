FIRRTL version 1.2.0
circuit ApproxRadix4Booth8 :
  module R4ABE2 :
    input clock : Clock
    input reset : Reset
    output io : { flip b_bits : UInt<3>, negate : UInt<1>} @[src/main/scala/empty/R4ABE2.scala 7:14]

    node _io_negate_T = bits(io.b_bits, 2, 2) @[src/main/scala/empty/R4ABE2.scala 12:25]
    io.negate <= _io_negate_T @[src/main/scala/empty/R4ABE2.scala 12:13]

  module R4ABE2_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip b_bits : UInt<3>, negate : UInt<1>} @[src/main/scala/empty/R4ABE2.scala 7:14]

    node _io_negate_T = bits(io.b_bits, 2, 2) @[src/main/scala/empty/R4ABE2.scala 12:25]
    io.negate <= _io_negate_T @[src/main/scala/empty/R4ABE2.scala 12:13]

  module R4ABE2_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip b_bits : UInt<3>, negate : UInt<1>} @[src/main/scala/empty/R4ABE2.scala 7:14]

    node _io_negate_T = bits(io.b_bits, 2, 2) @[src/main/scala/empty/R4ABE2.scala 12:25]
    io.negate <= _io_negate_T @[src/main/scala/empty/R4ABE2.scala 12:13]

  module R4ABE2_3 :
    input clock : Clock
    input reset : Reset
    output io : { flip b_bits : UInt<3>, negate : UInt<1>} @[src/main/scala/empty/R4ABE2.scala 7:14]

    node _io_negate_T = bits(io.b_bits, 2, 2) @[src/main/scala/empty/R4ABE2.scala 12:25]
    io.negate <= _io_negate_T @[src/main/scala/empty/R4ABE2.scala 12:13]

  module PartialProductGenerator :
    input clock : Clock
    input reset : Reset
    output io : { flip a : SInt<8>, flip negate : UInt<1>, partial_product : SInt<9>} @[src/main/scala/empty/PartialProductGenerator.scala 15:14]

    node _a_inv_T = asUInt(io.a) @[src/main/scala/empty/PartialProductGenerator.scala 23:22]
    node _a_inv_T_1 = not(_a_inv_T) @[src/main/scala/empty/PartialProductGenerator.scala 23:16]
    node a_inv = asSInt(_a_inv_T_1) @[src/main/scala/empty/PartialProductGenerator.scala 23:30]
    node _io_partial_product_T = mux(io.negate, a_inv, io.a) @[src/main/scala/empty/PartialProductGenerator.scala 26:28]
    io.partial_product <= _io_partial_product_T @[src/main/scala/empty/PartialProductGenerator.scala 26:22]

  module PartialProductGenerator_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : SInt<8>, flip negate : UInt<1>, partial_product : SInt<9>} @[src/main/scala/empty/PartialProductGenerator.scala 15:14]

    node _a_inv_T = asUInt(io.a) @[src/main/scala/empty/PartialProductGenerator.scala 23:22]
    node _a_inv_T_1 = not(_a_inv_T) @[src/main/scala/empty/PartialProductGenerator.scala 23:16]
    node a_inv = asSInt(_a_inv_T_1) @[src/main/scala/empty/PartialProductGenerator.scala 23:30]
    node _io_partial_product_T = mux(io.negate, a_inv, io.a) @[src/main/scala/empty/PartialProductGenerator.scala 26:28]
    io.partial_product <= _io_partial_product_T @[src/main/scala/empty/PartialProductGenerator.scala 26:22]

  module PartialProductGenerator_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : SInt<8>, flip negate : UInt<1>, partial_product : SInt<9>} @[src/main/scala/empty/PartialProductGenerator.scala 15:14]

    node _a_inv_T = asUInt(io.a) @[src/main/scala/empty/PartialProductGenerator.scala 23:22]
    node _a_inv_T_1 = not(_a_inv_T) @[src/main/scala/empty/PartialProductGenerator.scala 23:16]
    node a_inv = asSInt(_a_inv_T_1) @[src/main/scala/empty/PartialProductGenerator.scala 23:30]
    node _io_partial_product_T = mux(io.negate, a_inv, io.a) @[src/main/scala/empty/PartialProductGenerator.scala 26:28]
    io.partial_product <= _io_partial_product_T @[src/main/scala/empty/PartialProductGenerator.scala 26:22]

  module PartialProductGenerator_3 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : SInt<8>, flip negate : UInt<1>, partial_product : SInt<9>} @[src/main/scala/empty/PartialProductGenerator.scala 15:14]

    node _a_inv_T = asUInt(io.a) @[src/main/scala/empty/PartialProductGenerator.scala 23:22]
    node _a_inv_T_1 = not(_a_inv_T) @[src/main/scala/empty/PartialProductGenerator.scala 23:16]
    node a_inv = asSInt(_a_inv_T_1) @[src/main/scala/empty/PartialProductGenerator.scala 23:30]
    node _io_partial_product_T = mux(io.negate, a_inv, io.a) @[src/main/scala/empty/PartialProductGenerator.scala 26:28]
    io.partial_product <= _io_partial_product_T @[src/main/scala/empty/PartialProductGenerator.scala 26:22]

  module ApproxWallaceTree :
    input clock : Clock
    input reset : Reset
    output io : { flip shifted_partial_products : SInt<16>[4], final_product : SInt<16>} @[src/main/scala/empty/ApproxWallaceTree.scala 23:14]

    node _io_final_product_T = add(io.shifted_partial_products[0], io.shifted_partial_products[1]) @[src/main/scala/empty/ApproxWallaceTree.scala 31:64]
    node _io_final_product_T_1 = add(io.shifted_partial_products[2], io.shifted_partial_products[3]) @[src/main/scala/empty/ApproxWallaceTree.scala 31:64]
    node _io_final_product_T_2 = add(_io_final_product_T, _io_final_product_T_1) @[src/main/scala/empty/ApproxWallaceTree.scala 31:64]
    io.final_product <= _io_final_product_T_2 @[src/main/scala/empty/ApproxWallaceTree.scala 31:20]

  module ApproxRadix4Booth8 :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip multiplicand : SInt<8>, flip multiplier : SInt<8>, product : SInt<16>} @[src/main/scala/empty/ApproxRadix4Booth8.scala 6:14]

    node b_extended_hi = asUInt(io.multiplier) @[src/main/scala/empty/ApproxRadix4Booth8.scala 13:23]
    node b_extended = cat(b_extended_hi, UInt<1>("h0")) @[src/main/scala/empty/ApproxRadix4Booth8.scala 13:23]
    inst encoders_0 of R4ABE2 @[src/main/scala/empty/ApproxRadix4Booth8.scala 15:36]
    encoders_0.clock <= clock
    encoders_0.reset <= reset
    inst encoders_1 of R4ABE2_1 @[src/main/scala/empty/ApproxRadix4Booth8.scala 15:36]
    encoders_1.clock <= clock
    encoders_1.reset <= reset
    inst encoders_2 of R4ABE2_2 @[src/main/scala/empty/ApproxRadix4Booth8.scala 15:36]
    encoders_2.clock <= clock
    encoders_2.reset <= reset
    inst encoders_3 of R4ABE2_3 @[src/main/scala/empty/ApproxRadix4Booth8.scala 15:36]
    encoders_3.clock <= clock
    encoders_3.reset <= reset
    inst ppgs_0 of PartialProductGenerator @[src/main/scala/empty/ApproxRadix4Booth8.scala 16:32]
    ppgs_0.clock <= clock
    ppgs_0.reset <= reset
    inst ppgs_1 of PartialProductGenerator_1 @[src/main/scala/empty/ApproxRadix4Booth8.scala 16:32]
    ppgs_1.clock <= clock
    ppgs_1.reset <= reset
    inst ppgs_2 of PartialProductGenerator_2 @[src/main/scala/empty/ApproxRadix4Booth8.scala 16:32]
    ppgs_2.clock <= clock
    ppgs_2.reset <= reset
    inst ppgs_3 of PartialProductGenerator_3 @[src/main/scala/empty/ApproxRadix4Booth8.scala 16:32]
    ppgs_3.clock <= clock
    ppgs_3.reset <= reset
    wire partial_products : SInt<16>[4] @[src/main/scala/empty/ApproxRadix4Booth8.scala 17:30]
    node _encoders_0_io_b_bits_T = bits(b_extended, 2, 0) @[src/main/scala/empty/ApproxRadix4Booth8.scala 21:40]
    encoders_0.io.b_bits <= _encoders_0_io_b_bits_T @[src/main/scala/empty/ApproxRadix4Booth8.scala 21:27]
    ppgs_0.io.a <= io.multiplicand @[src/main/scala/empty/ApproxRadix4Booth8.scala 24:18]
    ppgs_0.io.negate <= encoders_0.io.negate @[src/main/scala/empty/ApproxRadix4Booth8.scala 25:23]
    node comp_bit = not(encoders_0.io.negate) @[src/main/scala/empty/ApproxRadix4Booth8.scala 30:21]
    node _pp_candidate_T = asUInt(ppgs_0.io.partial_product) @[src/main/scala/empty/ApproxRadix4Booth8.scala 34:65]
    node _pp_candidate_T_1 = cat(comp_bit, _pp_candidate_T) @[src/main/scala/empty/ApproxRadix4Booth8.scala 34:27]
    node pp_candidate = asSInt(_pp_candidate_T_1) @[src/main/scala/empty/ApproxRadix4Booth8.scala 34:73]
    node _is_zero_T = eq(encoders_0.io.b_bits, UInt<1>("h0")) @[src/main/scala/empty/ApproxRadix4Booth8.scala 38:42]
    node _is_zero_T_1 = eq(encoders_0.io.b_bits, UInt<3>("h7")) @[src/main/scala/empty/ApproxRadix4Booth8.scala 38:82]
    node is_zero = or(_is_zero_T, _is_zero_T_1) @[src/main/scala/empty/ApproxRadix4Booth8.scala 38:56]
    node pp_final = mux(is_zero, asSInt(UInt<10>("h0")), pp_candidate) @[src/main/scala/empty/ApproxRadix4Booth8.scala 42:23]
    node _partial_products_0_T = shl(pp_final, 0) @[src/main/scala/empty/ApproxRadix4Booth8.scala 45:37]
    partial_products[0] <= _partial_products_0_T @[src/main/scala/empty/ApproxRadix4Booth8.scala 45:25]
    node _encoders_1_io_b_bits_T = bits(b_extended, 4, 2) @[src/main/scala/empty/ApproxRadix4Booth8.scala 21:40]
    encoders_1.io.b_bits <= _encoders_1_io_b_bits_T @[src/main/scala/empty/ApproxRadix4Booth8.scala 21:27]
    ppgs_1.io.a <= io.multiplicand @[src/main/scala/empty/ApproxRadix4Booth8.scala 24:18]
    ppgs_1.io.negate <= encoders_1.io.negate @[src/main/scala/empty/ApproxRadix4Booth8.scala 25:23]
    node comp_bit_1 = not(encoders_1.io.negate) @[src/main/scala/empty/ApproxRadix4Booth8.scala 30:21]
    node _pp_candidate_T_2 = asUInt(ppgs_1.io.partial_product) @[src/main/scala/empty/ApproxRadix4Booth8.scala 34:65]
    node _pp_candidate_T_3 = cat(comp_bit_1, _pp_candidate_T_2) @[src/main/scala/empty/ApproxRadix4Booth8.scala 34:27]
    node pp_candidate_1 = asSInt(_pp_candidate_T_3) @[src/main/scala/empty/ApproxRadix4Booth8.scala 34:73]
    node _is_zero_T_2 = eq(encoders_1.io.b_bits, UInt<1>("h0")) @[src/main/scala/empty/ApproxRadix4Booth8.scala 38:42]
    node _is_zero_T_3 = eq(encoders_1.io.b_bits, UInt<3>("h7")) @[src/main/scala/empty/ApproxRadix4Booth8.scala 38:82]
    node is_zero_1 = or(_is_zero_T_2, _is_zero_T_3) @[src/main/scala/empty/ApproxRadix4Booth8.scala 38:56]
    node pp_final_1 = mux(is_zero_1, asSInt(UInt<10>("h0")), pp_candidate_1) @[src/main/scala/empty/ApproxRadix4Booth8.scala 42:23]
    node _partial_products_1_T = shl(pp_final_1, 2) @[src/main/scala/empty/ApproxRadix4Booth8.scala 45:37]
    partial_products[1] <= _partial_products_1_T @[src/main/scala/empty/ApproxRadix4Booth8.scala 45:25]
    node _encoders_2_io_b_bits_T = bits(b_extended, 6, 4) @[src/main/scala/empty/ApproxRadix4Booth8.scala 21:40]
    encoders_2.io.b_bits <= _encoders_2_io_b_bits_T @[src/main/scala/empty/ApproxRadix4Booth8.scala 21:27]
    ppgs_2.io.a <= io.multiplicand @[src/main/scala/empty/ApproxRadix4Booth8.scala 24:18]
    ppgs_2.io.negate <= encoders_2.io.negate @[src/main/scala/empty/ApproxRadix4Booth8.scala 25:23]
    node comp_bit_2 = not(encoders_2.io.negate) @[src/main/scala/empty/ApproxRadix4Booth8.scala 30:21]
    node _pp_candidate_T_4 = asUInt(ppgs_2.io.partial_product) @[src/main/scala/empty/ApproxRadix4Booth8.scala 34:65]
    node _pp_candidate_T_5 = cat(comp_bit_2, _pp_candidate_T_4) @[src/main/scala/empty/ApproxRadix4Booth8.scala 34:27]
    node pp_candidate_2 = asSInt(_pp_candidate_T_5) @[src/main/scala/empty/ApproxRadix4Booth8.scala 34:73]
    node _is_zero_T_4 = eq(encoders_2.io.b_bits, UInt<1>("h0")) @[src/main/scala/empty/ApproxRadix4Booth8.scala 38:42]
    node _is_zero_T_5 = eq(encoders_2.io.b_bits, UInt<3>("h7")) @[src/main/scala/empty/ApproxRadix4Booth8.scala 38:82]
    node is_zero_2 = or(_is_zero_T_4, _is_zero_T_5) @[src/main/scala/empty/ApproxRadix4Booth8.scala 38:56]
    node pp_final_2 = mux(is_zero_2, asSInt(UInt<10>("h0")), pp_candidate_2) @[src/main/scala/empty/ApproxRadix4Booth8.scala 42:23]
    node _partial_products_2_T = shl(pp_final_2, 4) @[src/main/scala/empty/ApproxRadix4Booth8.scala 45:37]
    partial_products[2] <= _partial_products_2_T @[src/main/scala/empty/ApproxRadix4Booth8.scala 45:25]
    node _encoders_3_io_b_bits_T = bits(b_extended, 8, 6) @[src/main/scala/empty/ApproxRadix4Booth8.scala 21:40]
    encoders_3.io.b_bits <= _encoders_3_io_b_bits_T @[src/main/scala/empty/ApproxRadix4Booth8.scala 21:27]
    ppgs_3.io.a <= io.multiplicand @[src/main/scala/empty/ApproxRadix4Booth8.scala 24:18]
    ppgs_3.io.negate <= encoders_3.io.negate @[src/main/scala/empty/ApproxRadix4Booth8.scala 25:23]
    node comp_bit_3 = not(encoders_3.io.negate) @[src/main/scala/empty/ApproxRadix4Booth8.scala 30:21]
    node _pp_candidate_T_6 = asUInt(ppgs_3.io.partial_product) @[src/main/scala/empty/ApproxRadix4Booth8.scala 34:65]
    node _pp_candidate_T_7 = cat(comp_bit_3, _pp_candidate_T_6) @[src/main/scala/empty/ApproxRadix4Booth8.scala 34:27]
    node pp_candidate_3 = asSInt(_pp_candidate_T_7) @[src/main/scala/empty/ApproxRadix4Booth8.scala 34:73]
    node _is_zero_T_6 = eq(encoders_3.io.b_bits, UInt<1>("h0")) @[src/main/scala/empty/ApproxRadix4Booth8.scala 38:42]
    node _is_zero_T_7 = eq(encoders_3.io.b_bits, UInt<3>("h7")) @[src/main/scala/empty/ApproxRadix4Booth8.scala 38:82]
    node is_zero_3 = or(_is_zero_T_6, _is_zero_T_7) @[src/main/scala/empty/ApproxRadix4Booth8.scala 38:56]
    node pp_final_3 = mux(is_zero_3, asSInt(UInt<10>("h0")), pp_candidate_3) @[src/main/scala/empty/ApproxRadix4Booth8.scala 42:23]
    node _partial_products_3_T = shl(pp_final_3, 6) @[src/main/scala/empty/ApproxRadix4Booth8.scala 45:37]
    partial_products[3] <= _partial_products_3_T @[src/main/scala/empty/ApproxRadix4Booth8.scala 45:25]
    inst wallace_tree of ApproxWallaceTree @[src/main/scala/empty/ApproxRadix4Booth8.scala 49:28]
    wallace_tree.clock <= clock
    wallace_tree.reset <= reset
    wallace_tree.io.shifted_partial_products[0] <= partial_products[0] @[src/main/scala/empty/ApproxRadix4Booth8.scala 50:44]
    wallace_tree.io.shifted_partial_products[1] <= partial_products[1] @[src/main/scala/empty/ApproxRadix4Booth8.scala 50:44]
    wallace_tree.io.shifted_partial_products[2] <= partial_products[2] @[src/main/scala/empty/ApproxRadix4Booth8.scala 50:44]
    wallace_tree.io.shifted_partial_products[3] <= partial_products[3] @[src/main/scala/empty/ApproxRadix4Booth8.scala 50:44]
    io.product <= wallace_tree.io.final_product @[src/main/scala/empty/ApproxRadix4Booth8.scala 51:14]

