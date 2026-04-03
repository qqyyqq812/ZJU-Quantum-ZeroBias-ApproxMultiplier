FIRRTL version 1.2.0
circuit ApproxRadix4Booth8 :
  module R4ABE2 :
    input clock : Clock
    input reset : Reset
    output io : { flip b_bits : UInt<3>, negate : UInt<1>, zero : UInt<1>, two : UInt<1>} @[src/main/scala/empty/R4ABE2.scala 14:14]

    node _io_negate_T = bits(io.b_bits, 2, 2) @[src/main/scala/empty/R4ABE2.scala 26:27]
    io.negate <= _io_negate_T @[src/main/scala/empty/R4ABE2.scala 26:15]
    io.zero <= UInt<1>("h0") @[src/main/scala/empty/R4ABE2.scala 27:15]
    io.two <= UInt<1>("h0") @[src/main/scala/empty/R4ABE2.scala 28:15]

  module R4ABE2_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip b_bits : UInt<3>, negate : UInt<1>, zero : UInt<1>, two : UInt<1>} @[src/main/scala/empty/R4ABE2.scala 14:14]

    node _io_negate_T = bits(io.b_bits, 2, 2) @[src/main/scala/empty/R4ABE2.scala 26:27]
    io.negate <= _io_negate_T @[src/main/scala/empty/R4ABE2.scala 26:15]
    io.zero <= UInt<1>("h0") @[src/main/scala/empty/R4ABE2.scala 27:15]
    io.two <= UInt<1>("h0") @[src/main/scala/empty/R4ABE2.scala 28:15]

  module R4ABE2_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip b_bits : UInt<3>, negate : UInt<1>, zero : UInt<1>, two : UInt<1>} @[src/main/scala/empty/R4ABE2.scala 14:14]

    node _io_zero_T = eq(io.b_bits, UInt<1>("h0")) @[src/main/scala/empty/R4ABE2.scala 36:24]
    node _io_zero_T_1 = eq(io.b_bits, UInt<3>("h7")) @[src/main/scala/empty/R4ABE2.scala 36:47]
    node _io_zero_T_2 = or(_io_zero_T, _io_zero_T_1) @[src/main/scala/empty/R4ABE2.scala 36:38]
    io.zero <= _io_zero_T_2 @[src/main/scala/empty/R4ABE2.scala 36:15]
    node _io_two_T = eq(io.b_bits, UInt<2>("h3")) @[src/main/scala/empty/R4ABE2.scala 37:24]
    node _io_two_T_1 = eq(io.b_bits, UInt<3>("h4")) @[src/main/scala/empty/R4ABE2.scala 37:47]
    node _io_two_T_2 = or(_io_two_T, _io_two_T_1) @[src/main/scala/empty/R4ABE2.scala 37:38]
    io.two <= _io_two_T_2 @[src/main/scala/empty/R4ABE2.scala 37:15]
    node _io_negate_T = bits(io.b_bits, 2, 2) @[src/main/scala/empty/R4ABE2.scala 38:22]
    io.negate <= _io_negate_T @[src/main/scala/empty/R4ABE2.scala 38:15]

  module R4ABE2_3 :
    input clock : Clock
    input reset : Reset
    output io : { flip b_bits : UInt<3>, negate : UInt<1>, zero : UInt<1>, two : UInt<1>} @[src/main/scala/empty/R4ABE2.scala 14:14]

    node _io_zero_T = eq(io.b_bits, UInt<1>("h0")) @[src/main/scala/empty/R4ABE2.scala 36:24]
    node _io_zero_T_1 = eq(io.b_bits, UInt<3>("h7")) @[src/main/scala/empty/R4ABE2.scala 36:47]
    node _io_zero_T_2 = or(_io_zero_T, _io_zero_T_1) @[src/main/scala/empty/R4ABE2.scala 36:38]
    io.zero <= _io_zero_T_2 @[src/main/scala/empty/R4ABE2.scala 36:15]
    node _io_two_T = eq(io.b_bits, UInt<2>("h3")) @[src/main/scala/empty/R4ABE2.scala 37:24]
    node _io_two_T_1 = eq(io.b_bits, UInt<3>("h4")) @[src/main/scala/empty/R4ABE2.scala 37:47]
    node _io_two_T_2 = or(_io_two_T, _io_two_T_1) @[src/main/scala/empty/R4ABE2.scala 37:38]
    io.two <= _io_two_T_2 @[src/main/scala/empty/R4ABE2.scala 37:15]
    node _io_negate_T = bits(io.b_bits, 2, 2) @[src/main/scala/empty/R4ABE2.scala 38:22]
    io.negate <= _io_negate_T @[src/main/scala/empty/R4ABE2.scala 38:15]

  module PartialProductGenerator :
    input clock : Clock
    input reset : Reset
    output io : { flip a : SInt<8>, flip negate : UInt<1>, flip zero : UInt<1>, flip two : UInt<1>, partial_product : SInt<10>} @[src/main/scala/empty/PartialProductGenerator.scala 14:14]

    node _a_shifted_T = shl(io.a, 1) @[src/main/scala/empty/PartialProductGenerator.scala 28:36]
    node a_shifted = mux(io.two, _a_shifted_T, io.a) @[src/main/scala/empty/PartialProductGenerator.scala 28:22]
    node _a_candidate_T = not(a_shifted) @[src/main/scala/empty/PartialProductGenerator.scala 36:37]
    node _a_candidate_T_1 = asSInt(_a_candidate_T) @[src/main/scala/empty/PartialProductGenerator.scala 36:37]
    node a_candidate = mux(io.negate, _a_candidate_T_1, a_shifted) @[src/main/scala/empty/PartialProductGenerator.scala 36:24]
    node _io_partial_product_T = mux(io.zero, asSInt(UInt<1>("h0")), a_candidate) @[src/main/scala/empty/PartialProductGenerator.scala 40:28]
    io.partial_product <= _io_partial_product_T @[src/main/scala/empty/PartialProductGenerator.scala 40:22]

  module PartialProductGenerator_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : SInt<8>, flip negate : UInt<1>, flip zero : UInt<1>, flip two : UInt<1>, partial_product : SInt<10>} @[src/main/scala/empty/PartialProductGenerator.scala 14:14]

    node _a_shifted_T = shl(io.a, 1) @[src/main/scala/empty/PartialProductGenerator.scala 28:36]
    node a_shifted = mux(io.two, _a_shifted_T, io.a) @[src/main/scala/empty/PartialProductGenerator.scala 28:22]
    node _a_candidate_T = not(a_shifted) @[src/main/scala/empty/PartialProductGenerator.scala 36:37]
    node _a_candidate_T_1 = asSInt(_a_candidate_T) @[src/main/scala/empty/PartialProductGenerator.scala 36:37]
    node a_candidate = mux(io.negate, _a_candidate_T_1, a_shifted) @[src/main/scala/empty/PartialProductGenerator.scala 36:24]
    node _io_partial_product_T = mux(io.zero, asSInt(UInt<1>("h0")), a_candidate) @[src/main/scala/empty/PartialProductGenerator.scala 40:28]
    io.partial_product <= _io_partial_product_T @[src/main/scala/empty/PartialProductGenerator.scala 40:22]

  module PartialProductGenerator_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : SInt<8>, flip negate : UInt<1>, flip zero : UInt<1>, flip two : UInt<1>, partial_product : SInt<10>} @[src/main/scala/empty/PartialProductGenerator.scala 14:14]

    node _a_shifted_T = shl(io.a, 1) @[src/main/scala/empty/PartialProductGenerator.scala 28:36]
    node a_shifted = mux(io.two, _a_shifted_T, io.a) @[src/main/scala/empty/PartialProductGenerator.scala 28:22]
    node _a_candidate_T = not(a_shifted) @[src/main/scala/empty/PartialProductGenerator.scala 36:37]
    node _a_candidate_T_1 = asSInt(_a_candidate_T) @[src/main/scala/empty/PartialProductGenerator.scala 36:37]
    node a_candidate = mux(io.negate, _a_candidate_T_1, a_shifted) @[src/main/scala/empty/PartialProductGenerator.scala 36:24]
    node _io_partial_product_T = mux(io.zero, asSInt(UInt<1>("h0")), a_candidate) @[src/main/scala/empty/PartialProductGenerator.scala 40:28]
    io.partial_product <= _io_partial_product_T @[src/main/scala/empty/PartialProductGenerator.scala 40:22]

  module PartialProductGenerator_3 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : SInt<8>, flip negate : UInt<1>, flip zero : UInt<1>, flip two : UInt<1>, partial_product : SInt<10>} @[src/main/scala/empty/PartialProductGenerator.scala 14:14]

    node _a_shifted_T = shl(io.a, 1) @[src/main/scala/empty/PartialProductGenerator.scala 28:36]
    node a_shifted = mux(io.two, _a_shifted_T, io.a) @[src/main/scala/empty/PartialProductGenerator.scala 28:22]
    node _a_candidate_T = not(a_shifted) @[src/main/scala/empty/PartialProductGenerator.scala 36:37]
    node _a_candidate_T_1 = asSInt(_a_candidate_T) @[src/main/scala/empty/PartialProductGenerator.scala 36:37]
    node a_candidate = mux(io.negate, _a_candidate_T_1, a_shifted) @[src/main/scala/empty/PartialProductGenerator.scala 36:24]
    node _io_partial_product_T = mux(io.zero, asSInt(UInt<1>("h0")), a_candidate) @[src/main/scala/empty/PartialProductGenerator.scala 40:28]
    io.partial_product <= _io_partial_product_T @[src/main/scala/empty/PartialProductGenerator.scala 40:22]

  module ApproxWallaceTree :
    input clock : Clock
    input reset : Reset
    output io : { flip shifted_partial_products : SInt<16>[4], final_product : SInt<16>} @[src/main/scala/empty/ApproxWallaceTree.scala 10:14]

    node _io_final_product_T = add(io.shifted_partial_products[0], io.shifted_partial_products[1]) @[src/main/scala/empty/ApproxWallaceTree.scala 16:64]
    node _io_final_product_T_1 = add(io.shifted_partial_products[2], io.shifted_partial_products[3]) @[src/main/scala/empty/ApproxWallaceTree.scala 16:64]
    node _io_final_product_T_2 = add(_io_final_product_T, _io_final_product_T_1) @[src/main/scala/empty/ApproxWallaceTree.scala 16:64]
    io.final_product <= _io_final_product_T_2 @[src/main/scala/empty/ApproxWallaceTree.scala 16:20]

  module ApproxRadix4Booth8 :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip multiplicand : SInt<8>, flip multiplier : SInt<8>, product : SInt<16>} @[src/main/scala/empty/ApproxRadix4Booth8.scala 19:14]

    node b_extended_hi = asUInt(io.multiplier) @[src/main/scala/empty/ApproxRadix4Booth8.scala 26:23]
    node b_extended = cat(b_extended_hi, UInt<1>("h0")) @[src/main/scala/empty/ApproxRadix4Booth8.scala 26:23]
    inst encoders_0 of R4ABE2 @[src/main/scala/empty/ApproxRadix4Booth8.scala 30:45]
    encoders_0.clock <= clock
    encoders_0.reset <= reset
    inst encoders_1 of R4ABE2_1 @[src/main/scala/empty/ApproxRadix4Booth8.scala 30:45]
    encoders_1.clock <= clock
    encoders_1.reset <= reset
    inst encoders_2 of R4ABE2_2 @[src/main/scala/empty/ApproxRadix4Booth8.scala 30:45]
    encoders_2.clock <= clock
    encoders_2.reset <= reset
    inst encoders_3 of R4ABE2_3 @[src/main/scala/empty/ApproxRadix4Booth8.scala 30:45]
    encoders_3.clock <= clock
    encoders_3.reset <= reset
    inst ppgs_0 of PartialProductGenerator @[src/main/scala/empty/ApproxRadix4Booth8.scala 31:32]
    ppgs_0.clock <= clock
    ppgs_0.reset <= reset
    inst ppgs_1 of PartialProductGenerator_1 @[src/main/scala/empty/ApproxRadix4Booth8.scala 31:32]
    ppgs_1.clock <= clock
    ppgs_1.reset <= reset
    inst ppgs_2 of PartialProductGenerator_2 @[src/main/scala/empty/ApproxRadix4Booth8.scala 31:32]
    ppgs_2.clock <= clock
    ppgs_2.reset <= reset
    inst ppgs_3 of PartialProductGenerator_3 @[src/main/scala/empty/ApproxRadix4Booth8.scala 31:32]
    ppgs_3.clock <= clock
    ppgs_3.reset <= reset
    wire partial_products : SInt<16>[4] @[src/main/scala/empty/ApproxRadix4Booth8.scala 33:30]
    node _encoders_0_io_b_bits_T = bits(b_extended, 2, 0) @[src/main/scala/empty/ApproxRadix4Booth8.scala 37:40]
    encoders_0.io.b_bits <= _encoders_0_io_b_bits_T @[src/main/scala/empty/ApproxRadix4Booth8.scala 37:27]
    ppgs_0.io.a <= io.multiplicand @[src/main/scala/empty/ApproxRadix4Booth8.scala 40:18]
    ppgs_0.io.negate <= encoders_0.io.negate @[src/main/scala/empty/ApproxRadix4Booth8.scala 41:23]
    ppgs_0.io.zero <= encoders_0.io.zero @[src/main/scala/empty/ApproxRadix4Booth8.scala 42:23]
    ppgs_0.io.two <= encoders_0.io.two @[src/main/scala/empty/ApproxRadix4Booth8.scala 43:23]
    wire pp_extended : SInt<16> @[src/main/scala/empty/ApproxRadix4Booth8.scala 50:27]
    pp_extended <= ppgs_0.io.partial_product @[src/main/scala/empty/ApproxRadix4Booth8.scala 51:17]
    node _partial_products_0_T = add(pp_extended, asSInt(UInt<1>("h0"))) @[src/main/scala/empty/ApproxRadix4Booth8.scala 70:41]
    node _partial_products_0_T_1 = tail(_partial_products_0_T, 1) @[src/main/scala/empty/ApproxRadix4Booth8.scala 70:41]
    node _partial_products_0_T_2 = asSInt(_partial_products_0_T_1) @[src/main/scala/empty/ApproxRadix4Booth8.scala 70:41]
    node _partial_products_0_T_3 = shl(_partial_products_0_T_2, 0) @[src/main/scala/empty/ApproxRadix4Booth8.scala 70:55]
    partial_products[0] <= _partial_products_0_T_3 @[src/main/scala/empty/ApproxRadix4Booth8.scala 70:25]
    node _encoders_1_io_b_bits_T = bits(b_extended, 4, 2) @[src/main/scala/empty/ApproxRadix4Booth8.scala 37:40]
    encoders_1.io.b_bits <= _encoders_1_io_b_bits_T @[src/main/scala/empty/ApproxRadix4Booth8.scala 37:27]
    ppgs_1.io.a <= io.multiplicand @[src/main/scala/empty/ApproxRadix4Booth8.scala 40:18]
    ppgs_1.io.negate <= encoders_1.io.negate @[src/main/scala/empty/ApproxRadix4Booth8.scala 41:23]
    ppgs_1.io.zero <= encoders_1.io.zero @[src/main/scala/empty/ApproxRadix4Booth8.scala 42:23]
    ppgs_1.io.two <= encoders_1.io.two @[src/main/scala/empty/ApproxRadix4Booth8.scala 43:23]
    wire pp_extended_1 : SInt<16> @[src/main/scala/empty/ApproxRadix4Booth8.scala 50:27]
    pp_extended_1 <= ppgs_1.io.partial_product @[src/main/scala/empty/ApproxRadix4Booth8.scala 51:17]
    node _partial_products_1_T = add(pp_extended_1, asSInt(UInt<1>("h0"))) @[src/main/scala/empty/ApproxRadix4Booth8.scala 70:41]
    node _partial_products_1_T_1 = tail(_partial_products_1_T, 1) @[src/main/scala/empty/ApproxRadix4Booth8.scala 70:41]
    node _partial_products_1_T_2 = asSInt(_partial_products_1_T_1) @[src/main/scala/empty/ApproxRadix4Booth8.scala 70:41]
    node _partial_products_1_T_3 = shl(_partial_products_1_T_2, 2) @[src/main/scala/empty/ApproxRadix4Booth8.scala 70:55]
    partial_products[1] <= _partial_products_1_T_3 @[src/main/scala/empty/ApproxRadix4Booth8.scala 70:25]
    node _encoders_2_io_b_bits_T = bits(b_extended, 6, 4) @[src/main/scala/empty/ApproxRadix4Booth8.scala 37:40]
    encoders_2.io.b_bits <= _encoders_2_io_b_bits_T @[src/main/scala/empty/ApproxRadix4Booth8.scala 37:27]
    ppgs_2.io.a <= io.multiplicand @[src/main/scala/empty/ApproxRadix4Booth8.scala 40:18]
    ppgs_2.io.negate <= encoders_2.io.negate @[src/main/scala/empty/ApproxRadix4Booth8.scala 41:23]
    ppgs_2.io.zero <= encoders_2.io.zero @[src/main/scala/empty/ApproxRadix4Booth8.scala 42:23]
    ppgs_2.io.two <= encoders_2.io.two @[src/main/scala/empty/ApproxRadix4Booth8.scala 43:23]
    wire pp_extended_2 : SInt<16> @[src/main/scala/empty/ApproxRadix4Booth8.scala 50:27]
    pp_extended_2 <= ppgs_2.io.partial_product @[src/main/scala/empty/ApproxRadix4Booth8.scala 51:17]
    node _correction_T = eq(encoders_2.io.zero, UInt<1>("h0")) @[src/main/scala/empty/ApproxRadix4Booth8.scala 65:36]
    node _correction_T_1 = and(encoders_2.io.negate, _correction_T) @[src/main/scala/empty/ApproxRadix4Booth8.scala 65:33]
    node correction = mux(_correction_T_1, asSInt(UInt<2>("h1")), asSInt(UInt<1>("h0"))) @[src/main/scala/empty/ApproxRadix4Booth8.scala 65:10]
    node _partial_products_2_T = add(pp_extended_2, correction) @[src/main/scala/empty/ApproxRadix4Booth8.scala 70:41]
    node _partial_products_2_T_1 = tail(_partial_products_2_T, 1) @[src/main/scala/empty/ApproxRadix4Booth8.scala 70:41]
    node _partial_products_2_T_2 = asSInt(_partial_products_2_T_1) @[src/main/scala/empty/ApproxRadix4Booth8.scala 70:41]
    node _partial_products_2_T_3 = shl(_partial_products_2_T_2, 4) @[src/main/scala/empty/ApproxRadix4Booth8.scala 70:55]
    partial_products[2] <= _partial_products_2_T_3 @[src/main/scala/empty/ApproxRadix4Booth8.scala 70:25]
    node _encoders_3_io_b_bits_T = bits(b_extended, 8, 6) @[src/main/scala/empty/ApproxRadix4Booth8.scala 37:40]
    encoders_3.io.b_bits <= _encoders_3_io_b_bits_T @[src/main/scala/empty/ApproxRadix4Booth8.scala 37:27]
    ppgs_3.io.a <= io.multiplicand @[src/main/scala/empty/ApproxRadix4Booth8.scala 40:18]
    ppgs_3.io.negate <= encoders_3.io.negate @[src/main/scala/empty/ApproxRadix4Booth8.scala 41:23]
    ppgs_3.io.zero <= encoders_3.io.zero @[src/main/scala/empty/ApproxRadix4Booth8.scala 42:23]
    ppgs_3.io.two <= encoders_3.io.two @[src/main/scala/empty/ApproxRadix4Booth8.scala 43:23]
    wire pp_extended_3 : SInt<16> @[src/main/scala/empty/ApproxRadix4Booth8.scala 50:27]
    pp_extended_3 <= ppgs_3.io.partial_product @[src/main/scala/empty/ApproxRadix4Booth8.scala 51:17]
    node _correction_T_2 = eq(encoders_3.io.zero, UInt<1>("h0")) @[src/main/scala/empty/ApproxRadix4Booth8.scala 65:36]
    node _correction_T_3 = and(encoders_3.io.negate, _correction_T_2) @[src/main/scala/empty/ApproxRadix4Booth8.scala 65:33]
    node correction_1 = mux(_correction_T_3, asSInt(UInt<2>("h1")), asSInt(UInt<1>("h0"))) @[src/main/scala/empty/ApproxRadix4Booth8.scala 65:10]
    node _partial_products_3_T = add(pp_extended_3, correction_1) @[src/main/scala/empty/ApproxRadix4Booth8.scala 70:41]
    node _partial_products_3_T_1 = tail(_partial_products_3_T, 1) @[src/main/scala/empty/ApproxRadix4Booth8.scala 70:41]
    node _partial_products_3_T_2 = asSInt(_partial_products_3_T_1) @[src/main/scala/empty/ApproxRadix4Booth8.scala 70:41]
    node _partial_products_3_T_3 = shl(_partial_products_3_T_2, 6) @[src/main/scala/empty/ApproxRadix4Booth8.scala 70:55]
    partial_products[3] <= _partial_products_3_T_3 @[src/main/scala/empty/ApproxRadix4Booth8.scala 70:25]
    inst wallace_tree of ApproxWallaceTree @[src/main/scala/empty/ApproxRadix4Booth8.scala 74:28]
    wallace_tree.clock <= clock
    wallace_tree.reset <= reset
    wallace_tree.io.shifted_partial_products[0] <= partial_products[0] @[src/main/scala/empty/ApproxRadix4Booth8.scala 75:44]
    wallace_tree.io.shifted_partial_products[1] <= partial_products[1] @[src/main/scala/empty/ApproxRadix4Booth8.scala 75:44]
    wallace_tree.io.shifted_partial_products[2] <= partial_products[2] @[src/main/scala/empty/ApproxRadix4Booth8.scala 75:44]
    wallace_tree.io.shifted_partial_products[3] <= partial_products[3] @[src/main/scala/empty/ApproxRadix4Booth8.scala 75:44]
    io.product <= wallace_tree.io.final_product @[src/main/scala/empty/ApproxRadix4Booth8.scala 76:14]

