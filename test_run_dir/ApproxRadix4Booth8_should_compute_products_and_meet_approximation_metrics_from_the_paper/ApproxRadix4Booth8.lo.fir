FIRRTL version 1.2.0
circuit ApproxRadix4Booth8 :
  module R4ABE2 :
    input clock : Clock
    input reset : UInt<1>
    input io_b_bits : UInt<3> @[src/main/scala/empty/R4ABE2.scala 16:14]
    output io_neg : UInt<1> @[src/main/scala/empty/R4ABE2.scala 16:14]
    output io_factor : UInt<2> @[src/main/scala/empty/R4ABE2.scala 16:14]

    node b2i_plus_1 = bits(io_b_bits, 2, 2) @[src/main/scala/empty/R4ABE2.scala 26:29]
    node b2i = bits(io_b_bits, 1, 1) @[src/main/scala/empty/R4ABE2.scala 27:29]
    node b2i_minus_1 = bits(io_b_bits, 0, 0) @[src/main/scala/empty/R4ABE2.scala 28:30]
    node _isFactor0_T = eq(b2i, b2i_minus_1) @[src/main/scala/empty/R4ABE2.scala 55:24]
    node _isFactor0_T_1 = eq(b2i, b2i_plus_1) @[src/main/scala/empty/R4ABE2.scala 55:49]
    node isFactor0 = and(_isFactor0_T, _isFactor0_T_1) @[src/main/scala/empty/R4ABE2.scala 55:41]
    node isFactor1 = neq(b2i, b2i_minus_1) @[src/main/scala/empty/R4ABE2.scala 56:23]
    node _isFactor2_T = eq(b2i, b2i_minus_1) @[src/main/scala/empty/R4ABE2.scala 57:24]
    node _isFactor2_T_1 = neq(b2i, b2i_plus_1) @[src/main/scala/empty/R4ABE2.scala 57:49]
    node isFactor2 = and(_isFactor2_T, _isFactor2_T_1) @[src/main/scala/empty/R4ABE2.scala 57:41]
    node _io_factor_T = mux(isFactor1, UInt<2>("h1"), UInt<2>("h0")) @[src/main/scala/empty/R4ABE2.scala 60:19]
    node _io_factor_T_1 = mux(isFactor2, UInt<2>("h2"), _io_factor_T) @[src/main/scala/empty/R4ABE2.scala 59:19]
    io_neg <= b2i_plus_1 @[src/main/scala/empty/R4ABE2.scala 48:10]
    io_factor <= _io_factor_T_1 @[src/main/scala/empty/R4ABE2.scala 59:13]

  module PartialProductGenerator :
    input clock : Clock
    input reset : UInt<1>
    input io_a : SInt<8> @[src/main/scala/empty/PartialProductGenerator.scala 13:14]
    input io_neg : UInt<1> @[src/main/scala/empty/PartialProductGenerator.scala 13:14]
    input io_factor : UInt<2> @[src/main/scala/empty/PartialProductGenerator.scala 13:14]
    output io_partial_product : SInt<10> @[src/main/scala/empty/PartialProductGenerator.scala 13:14]

    node a_x2 = shl(io_a, 1) @[src/main/scala/empty/PartialProductGenerator.scala 29:20]
    node _selected_a_multiple_T = eq(io_factor, UInt<1>("h1")) @[src/main/scala/empty/PartialProductGenerator.scala 33:16]
    node _selected_a_multiple_T_1 = eq(io_factor, UInt<2>("h2")) @[src/main/scala/empty/PartialProductGenerator.scala 34:16]
    node _selected_a_multiple_T_2 = mux(_selected_a_multiple_T_1, a_x2, asSInt(UInt<9>("h0"))) @[src/main/scala/chisel3/util/Mux.scala 141:16]
    node selected_a_multiple = mux(_selected_a_multiple_T, io_a, _selected_a_multiple_T_2) @[src/main/scala/chisel3/util/Mux.scala 141:16]
    node _final_pp_T = not(selected_a_multiple) @[src/main/scala/empty/PartialProductGenerator.scala 40:6]
    node _final_pp_T_1 = asSInt(_final_pp_T) @[src/main/scala/empty/PartialProductGenerator.scala 40:6]
    node _final_pp_T_2 = add(_final_pp_T_1, asSInt(UInt<2>("h1"))) @[src/main/scala/empty/PartialProductGenerator.scala 40:35]
    node _final_pp_T_3 = tail(_final_pp_T_2, 1) @[src/main/scala/empty/PartialProductGenerator.scala 40:35]
    node _final_pp_T_4 = asSInt(_final_pp_T_3) @[src/main/scala/empty/PartialProductGenerator.scala 40:35]
    node final_pp = mux(io_neg, _final_pp_T_4, selected_a_multiple) @[src/main/scala/empty/PartialProductGenerator.scala 39:21]
    io_partial_product <= pad(final_pp, 10) @[src/main/scala/empty/PartialProductGenerator.scala 46:22]

  module ApproxWallaceTree :
    input clock : Clock
    input reset : UInt<1>
    input io_shifted_partial_products_0 : SInt<16> @[src/main/scala/empty/ApproxWallaceTree.scala 16:14]
    input io_shifted_partial_products_1 : SInt<16> @[src/main/scala/empty/ApproxWallaceTree.scala 16:14]
    input io_shifted_partial_products_2 : SInt<16> @[src/main/scala/empty/ApproxWallaceTree.scala 16:14]
    input io_shifted_partial_products_3 : SInt<16> @[src/main/scala/empty/ApproxWallaceTree.scala 16:14]
    output io_final_product : SInt<16> @[src/main/scala/empty/ApproxWallaceTree.scala 16:14]

    node _io_final_product_T = add(io_shifted_partial_products_0, io_shifted_partial_products_1) @[src/main/scala/empty/ApproxWallaceTree.scala 36:64]
    node _io_final_product_T_1 = add(io_shifted_partial_products_2, io_shifted_partial_products_3) @[src/main/scala/empty/ApproxWallaceTree.scala 36:64]
    node _io_final_product_T_2 = add(_io_final_product_T, _io_final_product_T_1) @[src/main/scala/empty/ApproxWallaceTree.scala 36:64]
    io_final_product <= asSInt(bits(_io_final_product_T_2, 15, 0)) @[src/main/scala/empty/ApproxWallaceTree.scala 36:20]

  module ApproxRadix4Booth8 :
    input clock : Clock
    input reset : UInt<1>
    input io_multiplicand : SInt<8> @[src/main/scala/empty/ApproxRadix4Booth8.scala 14:14]
    input io_multiplier : SInt<8> @[src/main/scala/empty/ApproxRadix4Booth8.scala 14:14]
    output io_product : SInt<16> @[src/main/scala/empty/ApproxRadix4Booth8.scala 14:14]

    inst encoders_0 of R4ABE2 @[src/main/scala/empty/ApproxRadix4Booth8.scala 29:36]
    inst encoders_1 of R4ABE2 @[src/main/scala/empty/ApproxRadix4Booth8.scala 29:36]
    inst encoders_2 of R4ABE2 @[src/main/scala/empty/ApproxRadix4Booth8.scala 29:36]
    inst encoders_3 of R4ABE2 @[src/main/scala/empty/ApproxRadix4Booth8.scala 29:36]
    inst ppgs_0 of PartialProductGenerator @[src/main/scala/empty/ApproxRadix4Booth8.scala 30:32]
    inst ppgs_1 of PartialProductGenerator @[src/main/scala/empty/ApproxRadix4Booth8.scala 30:32]
    inst ppgs_2 of PartialProductGenerator @[src/main/scala/empty/ApproxRadix4Booth8.scala 30:32]
    inst ppgs_3 of PartialProductGenerator @[src/main/scala/empty/ApproxRadix4Booth8.scala 30:32]
    inst wallaceTree of ApproxWallaceTree @[src/main/scala/empty/ApproxRadix4Booth8.scala 48:27]
    node b_ext_hi = asUInt(io_multiplier) @[src/main/scala/empty/ApproxRadix4Booth8.scala 21:18]
    node b_ext = cat(b_ext_hi, UInt<1>("h0")) @[src/main/scala/empty/ApproxRadix4Booth8.scala 21:18]
    node _b_groups_T = bits(b_ext, 2, 0) @[src/main/scala/empty/ApproxRadix4Booth8.scala 25:10]
    node _b_groups_T_1 = bits(b_ext, 4, 2) @[src/main/scala/empty/ApproxRadix4Booth8.scala 25:10]
    node _b_groups_T_2 = bits(b_ext, 6, 4) @[src/main/scala/empty/ApproxRadix4Booth8.scala 25:10]
    node _b_groups_T_3 = bits(b_ext, 8, 6) @[src/main/scala/empty/ApproxRadix4Booth8.scala 25:10]
    node partial_products_0 = ppgs_0.io_partial_product @[src/main/scala/empty/ApproxRadix4Booth8.scala 31:30 38:25]
    node _shifted_pps_0_T = shl(partial_products_0, 0) @[src/main/scala/empty/ApproxRadix4Booth8.scala 44:44]
    node partial_products_1 = ppgs_1.io_partial_product @[src/main/scala/empty/ApproxRadix4Booth8.scala 31:30 38:25]
    node _shifted_pps_1_T = shl(partial_products_1, 2) @[src/main/scala/empty/ApproxRadix4Booth8.scala 44:44]
    node partial_products_2 = ppgs_2.io_partial_product @[src/main/scala/empty/ApproxRadix4Booth8.scala 31:30 38:25]
    node _shifted_pps_2_T = shl(partial_products_2, 4) @[src/main/scala/empty/ApproxRadix4Booth8.scala 44:44]
    node partial_products_3 = ppgs_3.io_partial_product @[src/main/scala/empty/ApproxRadix4Booth8.scala 31:30 38:25]
    node _shifted_pps_3_T = shl(partial_products_3, 6) @[src/main/scala/empty/ApproxRadix4Booth8.scala 44:44]
    node b_groups_0 = _b_groups_T @[src/main/scala/empty/ApproxRadix4Booth8.scala 24:{38,38}]
    node b_groups_1 = _b_groups_T_1 @[src/main/scala/empty/ApproxRadix4Booth8.scala 24:{38,38}]
    node b_groups_2 = _b_groups_T_2 @[src/main/scala/empty/ApproxRadix4Booth8.scala 24:{38,38}]
    node b_groups_3 = _b_groups_T_3 @[src/main/scala/empty/ApproxRadix4Booth8.scala 24:{38,38}]
    node shifted_pps_0 = pad(_shifted_pps_0_T, 16) @[src/main/scala/empty/ApproxRadix4Booth8.scala 42:25 44:20]
    node shifted_pps_1 = pad(_shifted_pps_1_T, 16) @[src/main/scala/empty/ApproxRadix4Booth8.scala 42:25 44:20]
    node shifted_pps_2 = pad(_shifted_pps_2_T, 16) @[src/main/scala/empty/ApproxRadix4Booth8.scala 42:25 44:20]
    node shifted_pps_3 = _shifted_pps_3_T @[src/main/scala/empty/ApproxRadix4Booth8.scala 42:25 44:20]
    io_product <= wallaceTree.io_final_product @[src/main/scala/empty/ApproxRadix4Booth8.scala 52:14]
    encoders_0.clock <= clock
    encoders_0.reset <= reset
    encoders_0.io_b_bits <= b_groups_0 @[src/main/scala/empty/ApproxRadix4Booth8.scala 34:27]
    encoders_1.clock <= clock
    encoders_1.reset <= reset
    encoders_1.io_b_bits <= b_groups_1 @[src/main/scala/empty/ApproxRadix4Booth8.scala 34:27]
    encoders_2.clock <= clock
    encoders_2.reset <= reset
    encoders_2.io_b_bits <= b_groups_2 @[src/main/scala/empty/ApproxRadix4Booth8.scala 34:27]
    encoders_3.clock <= clock
    encoders_3.reset <= reset
    encoders_3.io_b_bits <= b_groups_3 @[src/main/scala/empty/ApproxRadix4Booth8.scala 34:27]
    ppgs_0.clock <= clock
    ppgs_0.reset <= reset
    ppgs_0.io_a <= io_multiplicand @[src/main/scala/empty/ApproxRadix4Booth8.scala 35:18]
    ppgs_0.io_neg <= encoders_0.io_neg @[src/main/scala/empty/ApproxRadix4Booth8.scala 36:20]
    ppgs_0.io_factor <= encoders_0.io_factor @[src/main/scala/empty/ApproxRadix4Booth8.scala 37:23]
    ppgs_1.clock <= clock
    ppgs_1.reset <= reset
    ppgs_1.io_a <= io_multiplicand @[src/main/scala/empty/ApproxRadix4Booth8.scala 35:18]
    ppgs_1.io_neg <= encoders_1.io_neg @[src/main/scala/empty/ApproxRadix4Booth8.scala 36:20]
    ppgs_1.io_factor <= encoders_1.io_factor @[src/main/scala/empty/ApproxRadix4Booth8.scala 37:23]
    ppgs_2.clock <= clock
    ppgs_2.reset <= reset
    ppgs_2.io_a <= io_multiplicand @[src/main/scala/empty/ApproxRadix4Booth8.scala 35:18]
    ppgs_2.io_neg <= encoders_2.io_neg @[src/main/scala/empty/ApproxRadix4Booth8.scala 36:20]
    ppgs_2.io_factor <= encoders_2.io_factor @[src/main/scala/empty/ApproxRadix4Booth8.scala 37:23]
    ppgs_3.clock <= clock
    ppgs_3.reset <= reset
    ppgs_3.io_a <= io_multiplicand @[src/main/scala/empty/ApproxRadix4Booth8.scala 35:18]
    ppgs_3.io_neg <= encoders_3.io_neg @[src/main/scala/empty/ApproxRadix4Booth8.scala 36:20]
    ppgs_3.io_factor <= encoders_3.io_factor @[src/main/scala/empty/ApproxRadix4Booth8.scala 37:23]
    wallaceTree.clock <= clock
    wallaceTree.reset <= reset
    wallaceTree.io_shifted_partial_products_0 <= shifted_pps_0 @[src/main/scala/empty/ApproxRadix4Booth8.scala 49:43]
    wallaceTree.io_shifted_partial_products_1 <= shifted_pps_1 @[src/main/scala/empty/ApproxRadix4Booth8.scala 49:43]
    wallaceTree.io_shifted_partial_products_2 <= shifted_pps_2 @[src/main/scala/empty/ApproxRadix4Booth8.scala 49:43]
    wallaceTree.io_shifted_partial_products_3 <= shifted_pps_3 @[src/main/scala/empty/ApproxRadix4Booth8.scala 49:43]
