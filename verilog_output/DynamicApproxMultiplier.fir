FIRRTL version 1.2.0
circuit DynamicApproxMultiplier :
  module R4ABE2_Dynamic :
    input clock : Clock
    input reset : Reset
    output io : { flip b_bits : UInt<3>, flip is_approx : UInt<1>, negate : UInt<1>, zero : UInt<1>, two : UInt<1>} @[src/main/scala/empty/DynamicApproxMultiplier.scala 29:14]

    node _io_negate_T = bits(io.b_bits, 2, 2) @[src/main/scala/empty/DynamicApproxMultiplier.scala 39:25]
    io.negate <= _io_negate_T @[src/main/scala/empty/DynamicApproxMultiplier.scala 39:13]
    node _io_zero_T = eq(io.b_bits, UInt<1>("h0")) @[src/main/scala/empty/DynamicApproxMultiplier.scala 43:27]
    node _io_zero_T_1 = eq(io.b_bits, UInt<3>("h7")) @[src/main/scala/empty/DynamicApproxMultiplier.scala 43:50]
    node _io_zero_T_2 = or(_io_zero_T, _io_zero_T_1) @[src/main/scala/empty/DynamicApproxMultiplier.scala 43:36]
    io.zero <= _io_zero_T_2 @[src/main/scala/empty/DynamicApproxMultiplier.scala 43:13]
    node _two_exact_T = eq(io.b_bits, UInt<2>("h3")) @[src/main/scala/empty/DynamicApproxMultiplier.scala 48:30]
    node _two_exact_T_1 = eq(io.b_bits, UInt<3>("h4")) @[src/main/scala/empty/DynamicApproxMultiplier.scala 48:53]
    node two_exact = or(_two_exact_T, _two_exact_T_1) @[src/main/scala/empty/DynamicApproxMultiplier.scala 48:39]
    node _io_two_T = mux(io.is_approx, UInt<1>("h0"), two_exact) @[src/main/scala/empty/DynamicApproxMultiplier.scala 49:16]
    io.two <= _io_two_T @[src/main/scala/empty/DynamicApproxMultiplier.scala 49:10]

  module R4ABE2_Dynamic_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip b_bits : UInt<3>, flip is_approx : UInt<1>, negate : UInt<1>, zero : UInt<1>, two : UInt<1>} @[src/main/scala/empty/DynamicApproxMultiplier.scala 29:14]

    node _io_negate_T = bits(io.b_bits, 2, 2) @[src/main/scala/empty/DynamicApproxMultiplier.scala 39:25]
    io.negate <= _io_negate_T @[src/main/scala/empty/DynamicApproxMultiplier.scala 39:13]
    node _io_zero_T = eq(io.b_bits, UInt<1>("h0")) @[src/main/scala/empty/DynamicApproxMultiplier.scala 43:27]
    node _io_zero_T_1 = eq(io.b_bits, UInt<3>("h7")) @[src/main/scala/empty/DynamicApproxMultiplier.scala 43:50]
    node _io_zero_T_2 = or(_io_zero_T, _io_zero_T_1) @[src/main/scala/empty/DynamicApproxMultiplier.scala 43:36]
    io.zero <= _io_zero_T_2 @[src/main/scala/empty/DynamicApproxMultiplier.scala 43:13]
    node _two_exact_T = eq(io.b_bits, UInt<2>("h3")) @[src/main/scala/empty/DynamicApproxMultiplier.scala 48:30]
    node _two_exact_T_1 = eq(io.b_bits, UInt<3>("h4")) @[src/main/scala/empty/DynamicApproxMultiplier.scala 48:53]
    node two_exact = or(_two_exact_T, _two_exact_T_1) @[src/main/scala/empty/DynamicApproxMultiplier.scala 48:39]
    node _io_two_T = mux(io.is_approx, UInt<1>("h0"), two_exact) @[src/main/scala/empty/DynamicApproxMultiplier.scala 49:16]
    io.two <= _io_two_T @[src/main/scala/empty/DynamicApproxMultiplier.scala 49:10]

  module R4ABE2_Dynamic_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip b_bits : UInt<3>, flip is_approx : UInt<1>, negate : UInt<1>, zero : UInt<1>, two : UInt<1>} @[src/main/scala/empty/DynamicApproxMultiplier.scala 29:14]

    node _io_negate_T = bits(io.b_bits, 2, 2) @[src/main/scala/empty/DynamicApproxMultiplier.scala 39:25]
    io.negate <= _io_negate_T @[src/main/scala/empty/DynamicApproxMultiplier.scala 39:13]
    node _io_zero_T = eq(io.b_bits, UInt<1>("h0")) @[src/main/scala/empty/DynamicApproxMultiplier.scala 43:27]
    node _io_zero_T_1 = eq(io.b_bits, UInt<3>("h7")) @[src/main/scala/empty/DynamicApproxMultiplier.scala 43:50]
    node _io_zero_T_2 = or(_io_zero_T, _io_zero_T_1) @[src/main/scala/empty/DynamicApproxMultiplier.scala 43:36]
    io.zero <= _io_zero_T_2 @[src/main/scala/empty/DynamicApproxMultiplier.scala 43:13]
    node _two_exact_T = eq(io.b_bits, UInt<2>("h3")) @[src/main/scala/empty/DynamicApproxMultiplier.scala 48:30]
    node _two_exact_T_1 = eq(io.b_bits, UInt<3>("h4")) @[src/main/scala/empty/DynamicApproxMultiplier.scala 48:53]
    node two_exact = or(_two_exact_T, _two_exact_T_1) @[src/main/scala/empty/DynamicApproxMultiplier.scala 48:39]
    node _io_two_T = mux(io.is_approx, UInt<1>("h0"), two_exact) @[src/main/scala/empty/DynamicApproxMultiplier.scala 49:16]
    io.two <= _io_two_T @[src/main/scala/empty/DynamicApproxMultiplier.scala 49:10]

  module R4ABE2_Dynamic_3 :
    input clock : Clock
    input reset : Reset
    output io : { flip b_bits : UInt<3>, flip is_approx : UInt<1>, negate : UInt<1>, zero : UInt<1>, two : UInt<1>} @[src/main/scala/empty/DynamicApproxMultiplier.scala 29:14]

    node _io_negate_T = bits(io.b_bits, 2, 2) @[src/main/scala/empty/DynamicApproxMultiplier.scala 39:25]
    io.negate <= _io_negate_T @[src/main/scala/empty/DynamicApproxMultiplier.scala 39:13]
    node _io_zero_T = eq(io.b_bits, UInt<1>("h0")) @[src/main/scala/empty/DynamicApproxMultiplier.scala 43:27]
    node _io_zero_T_1 = eq(io.b_bits, UInt<3>("h7")) @[src/main/scala/empty/DynamicApproxMultiplier.scala 43:50]
    node _io_zero_T_2 = or(_io_zero_T, _io_zero_T_1) @[src/main/scala/empty/DynamicApproxMultiplier.scala 43:36]
    io.zero <= _io_zero_T_2 @[src/main/scala/empty/DynamicApproxMultiplier.scala 43:13]
    node _two_exact_T = eq(io.b_bits, UInt<2>("h3")) @[src/main/scala/empty/DynamicApproxMultiplier.scala 48:30]
    node _two_exact_T_1 = eq(io.b_bits, UInt<3>("h4")) @[src/main/scala/empty/DynamicApproxMultiplier.scala 48:53]
    node two_exact = or(_two_exact_T, _two_exact_T_1) @[src/main/scala/empty/DynamicApproxMultiplier.scala 48:39]
    node _io_two_T = mux(io.is_approx, UInt<1>("h0"), two_exact) @[src/main/scala/empty/DynamicApproxMultiplier.scala 49:16]
    io.two <= _io_two_T @[src/main/scala/empty/DynamicApproxMultiplier.scala 49:10]

  module PartialProductGenerator :
    input clock : Clock
    input reset : Reset
    output io : { flip a : SInt<8>, flip negate : UInt<1>, partial_product : SInt<9>} @[src/main/scala/empty/DynamicApproxMultiplier.scala 61:14]

    node _io_partial_product_T = sub(asSInt(UInt<1>("h0")), io.a) @[src/main/scala/empty/DynamicApproxMultiplier.scala 68:40]
    node _io_partial_product_T_1 = tail(_io_partial_product_T, 1) @[src/main/scala/empty/DynamicApproxMultiplier.scala 68:40]
    node _io_partial_product_T_2 = asSInt(_io_partial_product_T_1) @[src/main/scala/empty/DynamicApproxMultiplier.scala 68:40]
    node _io_partial_product_T_3 = mux(io.negate, _io_partial_product_T_2, io.a) @[src/main/scala/empty/DynamicApproxMultiplier.scala 68:28]
    io.partial_product <= _io_partial_product_T_3 @[src/main/scala/empty/DynamicApproxMultiplier.scala 68:22]

  module PartialProductGenerator_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : SInt<8>, flip negate : UInt<1>, partial_product : SInt<9>} @[src/main/scala/empty/DynamicApproxMultiplier.scala 61:14]

    node _io_partial_product_T = sub(asSInt(UInt<1>("h0")), io.a) @[src/main/scala/empty/DynamicApproxMultiplier.scala 68:40]
    node _io_partial_product_T_1 = tail(_io_partial_product_T, 1) @[src/main/scala/empty/DynamicApproxMultiplier.scala 68:40]
    node _io_partial_product_T_2 = asSInt(_io_partial_product_T_1) @[src/main/scala/empty/DynamicApproxMultiplier.scala 68:40]
    node _io_partial_product_T_3 = mux(io.negate, _io_partial_product_T_2, io.a) @[src/main/scala/empty/DynamicApproxMultiplier.scala 68:28]
    io.partial_product <= _io_partial_product_T_3 @[src/main/scala/empty/DynamicApproxMultiplier.scala 68:22]

  module PartialProductGenerator_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : SInt<8>, flip negate : UInt<1>, partial_product : SInt<9>} @[src/main/scala/empty/DynamicApproxMultiplier.scala 61:14]

    node _io_partial_product_T = sub(asSInt(UInt<1>("h0")), io.a) @[src/main/scala/empty/DynamicApproxMultiplier.scala 68:40]
    node _io_partial_product_T_1 = tail(_io_partial_product_T, 1) @[src/main/scala/empty/DynamicApproxMultiplier.scala 68:40]
    node _io_partial_product_T_2 = asSInt(_io_partial_product_T_1) @[src/main/scala/empty/DynamicApproxMultiplier.scala 68:40]
    node _io_partial_product_T_3 = mux(io.negate, _io_partial_product_T_2, io.a) @[src/main/scala/empty/DynamicApproxMultiplier.scala 68:28]
    io.partial_product <= _io_partial_product_T_3 @[src/main/scala/empty/DynamicApproxMultiplier.scala 68:22]

  module PartialProductGenerator_3 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : SInt<8>, flip negate : UInt<1>, partial_product : SInt<9>} @[src/main/scala/empty/DynamicApproxMultiplier.scala 61:14]

    node _io_partial_product_T = sub(asSInt(UInt<1>("h0")), io.a) @[src/main/scala/empty/DynamicApproxMultiplier.scala 68:40]
    node _io_partial_product_T_1 = tail(_io_partial_product_T, 1) @[src/main/scala/empty/DynamicApproxMultiplier.scala 68:40]
    node _io_partial_product_T_2 = asSInt(_io_partial_product_T_1) @[src/main/scala/empty/DynamicApproxMultiplier.scala 68:40]
    node _io_partial_product_T_3 = mux(io.negate, _io_partial_product_T_2, io.a) @[src/main/scala/empty/DynamicApproxMultiplier.scala 68:28]
    io.partial_product <= _io_partial_product_T_3 @[src/main/scala/empty/DynamicApproxMultiplier.scala 68:22]

  module ApproxWallaceTree :
    input clock : Clock
    input reset : Reset
    output io : { flip shifted_partial_products : SInt<16>[4], final_product : SInt<16>} @[src/main/scala/empty/DynamicApproxMultiplier.scala 80:14]

    node _io_final_product_T = add(io.shifted_partial_products[0], io.shifted_partial_products[1]) @[src/main/scala/empty/DynamicApproxMultiplier.scala 86:64]
    node _io_final_product_T_1 = add(io.shifted_partial_products[2], io.shifted_partial_products[3]) @[src/main/scala/empty/DynamicApproxMultiplier.scala 86:64]
    node _io_final_product_T_2 = add(_io_final_product_T, _io_final_product_T_1) @[src/main/scala/empty/DynamicApproxMultiplier.scala 86:64]
    io.final_product <= _io_final_product_T_2 @[src/main/scala/empty/DynamicApproxMultiplier.scala 86:20]

  module DynamicApproxMultiplier :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip multiplicand : SInt<8>, flip multiplier : SInt<8>, flip approx_level : UInt<2>, product : SInt<16>} @[src/main/scala/empty/DynamicApproxMultiplier.scala 104:14]

    node b_extended_hi = asUInt(io.multiplier) @[src/main/scala/empty/DynamicApproxMultiplier.scala 112:23]
    node b_extended = cat(b_extended_hi, UInt<1>("h0")) @[src/main/scala/empty/DynamicApproxMultiplier.scala 112:23]
    inst encoders_0 of R4ABE2_Dynamic @[src/main/scala/empty/DynamicApproxMultiplier.scala 115:36]
    encoders_0.clock <= clock
    encoders_0.reset <= reset
    inst encoders_1 of R4ABE2_Dynamic_1 @[src/main/scala/empty/DynamicApproxMultiplier.scala 115:36]
    encoders_1.clock <= clock
    encoders_1.reset <= reset
    inst encoders_2 of R4ABE2_Dynamic_2 @[src/main/scala/empty/DynamicApproxMultiplier.scala 115:36]
    encoders_2.clock <= clock
    encoders_2.reset <= reset
    inst encoders_3 of R4ABE2_Dynamic_3 @[src/main/scala/empty/DynamicApproxMultiplier.scala 115:36]
    encoders_3.clock <= clock
    encoders_3.reset <= reset
    inst ppgs_0 of PartialProductGenerator @[src/main/scala/empty/DynamicApproxMultiplier.scala 116:36]
    ppgs_0.clock <= clock
    ppgs_0.reset <= reset
    inst ppgs_1 of PartialProductGenerator_1 @[src/main/scala/empty/DynamicApproxMultiplier.scala 116:36]
    ppgs_1.clock <= clock
    ppgs_1.reset <= reset
    inst ppgs_2 of PartialProductGenerator_2 @[src/main/scala/empty/DynamicApproxMultiplier.scala 116:36]
    ppgs_2.clock <= clock
    ppgs_2.reset <= reset
    inst ppgs_3 of PartialProductGenerator_3 @[src/main/scala/empty/DynamicApproxMultiplier.scala 116:36]
    ppgs_3.clock <= clock
    ppgs_3.reset <= reset
    wire partial_products : SInt<16>[4] @[src/main/scala/empty/DynamicApproxMultiplier.scala 118:30]
    node a_is_zero = eq(io.multiplicand, asSInt(UInt<1>("h0"))) @[src/main/scala/empty/DynamicApproxMultiplier.scala 121:36]
    wire row_is_approx : UInt<1>[4] @[src/main/scala/empty/DynamicApproxMultiplier.scala 125:27]
    node _row_is_approx_0_T = lt(UInt<1>("h0"), io.approx_level) @[src/main/scala/empty/DynamicApproxMultiplier.scala 133:30]
    row_is_approx[0] <= _row_is_approx_0_T @[src/main/scala/empty/DynamicApproxMultiplier.scala 133:22]
    node _row_is_approx_1_T = lt(UInt<1>("h1"), io.approx_level) @[src/main/scala/empty/DynamicApproxMultiplier.scala 133:30]
    row_is_approx[1] <= _row_is_approx_1_T @[src/main/scala/empty/DynamicApproxMultiplier.scala 133:22]
    node _row_is_approx_2_T = lt(UInt<2>("h2"), io.approx_level) @[src/main/scala/empty/DynamicApproxMultiplier.scala 133:30]
    row_is_approx[2] <= _row_is_approx_2_T @[src/main/scala/empty/DynamicApproxMultiplier.scala 133:22]
    node _row_is_approx_3_T = lt(UInt<2>("h3"), io.approx_level) @[src/main/scala/empty/DynamicApproxMultiplier.scala 133:30]
    row_is_approx[3] <= _row_is_approx_3_T @[src/main/scala/empty/DynamicApproxMultiplier.scala 133:22]
    node _encoders_0_io_b_bits_T = bits(b_extended, 2, 0) @[src/main/scala/empty/DynamicApproxMultiplier.scala 138:43]
    encoders_0.io.b_bits <= _encoders_0_io_b_bits_T @[src/main/scala/empty/DynamicApproxMultiplier.scala 138:30]
    encoders_0.io.is_approx <= row_is_approx[0] @[src/main/scala/empty/DynamicApproxMultiplier.scala 139:30]
    ppgs_0.io.a <= io.multiplicand @[src/main/scala/empty/DynamicApproxMultiplier.scala 142:23]
    ppgs_0.io.negate <= encoders_0.io.negate @[src/main/scala/empty/DynamicApproxMultiplier.scala 143:23]
    node row_is_zero = or(encoders_0.io.zero, a_is_zero) @[src/main/scala/empty/DynamicApproxMultiplier.scala 148:43]
    wire pp_signed : SInt<9> @[src/main/scala/empty/DynamicApproxMultiplier.scala 155:25]
    node _pp_signed_T = shl(ppgs_0.io.partial_product, 1) @[src/main/scala/empty/DynamicApproxMultiplier.scala 156:50]
    node _pp_signed_T_1 = mux(encoders_0.io.two, _pp_signed_T, ppgs_0.io.partial_product) @[src/main/scala/empty/DynamicApproxMultiplier.scala 156:21]
    pp_signed <= _pp_signed_T_1 @[src/main/scala/empty/DynamicApproxMultiplier.scala 156:15]
    wire pp_gated : SInt<9> @[src/main/scala/empty/DynamicApproxMultiplier.scala 159:24]
    node _pp_gated_T = mux(row_is_zero, asSInt(UInt<1>("h0")), pp_signed) @[src/main/scala/empty/DynamicApproxMultiplier.scala 160:20]
    pp_gated <= _pp_gated_T @[src/main/scala/empty/DynamicApproxMultiplier.scala 160:14]
    wire pp_extended : SInt<16> @[src/main/scala/empty/DynamicApproxMultiplier.scala 163:27]
    pp_extended <= pp_gated @[src/main/scala/empty/DynamicApproxMultiplier.scala 164:17]
    node _need_correction_T = eq(row_is_approx[0], UInt<1>("h0")) @[src/main/scala/empty/DynamicApproxMultiplier.scala 170:27]
    node need_correction = and(_need_correction_T, encoders_0.io.negate) @[src/main/scala/empty/DynamicApproxMultiplier.scala 170:45]
    wire correction_bit : SInt<16> @[src/main/scala/empty/DynamicApproxMultiplier.scala 171:30]
    node _correction_bit_T = eq(row_is_zero, UInt<1>("h0")) @[src/main/scala/empty/DynamicApproxMultiplier.scala 172:46]
    node _correction_bit_T_1 = and(need_correction, _correction_bit_T) @[src/main/scala/empty/DynamicApproxMultiplier.scala 172:43]
    node _correction_bit_T_2 = mux(_correction_bit_T_1, asSInt(UInt<2>("h1")), asSInt(UInt<1>("h0"))) @[src/main/scala/empty/DynamicApproxMultiplier.scala 172:26]
    correction_bit <= _correction_bit_T_2 @[src/main/scala/empty/DynamicApproxMultiplier.scala 172:20]
    node _partial_products_0_T = shl(pp_extended, 0) @[src/main/scala/empty/DynamicApproxMultiplier.scala 176:41]
    node _partial_products_0_T_1 = shl(correction_bit, 0) @[src/main/scala/empty/DynamicApproxMultiplier.scala 176:78]
    node _partial_products_0_T_2 = add(_partial_products_0_T, _partial_products_0_T_1) @[src/main/scala/empty/DynamicApproxMultiplier.scala 176:60]
    node _partial_products_0_T_3 = tail(_partial_products_0_T_2, 1) @[src/main/scala/empty/DynamicApproxMultiplier.scala 176:60]
    node _partial_products_0_T_4 = asSInt(_partial_products_0_T_3) @[src/main/scala/empty/DynamicApproxMultiplier.scala 176:60]
    partial_products[0] <= _partial_products_0_T_4 @[src/main/scala/empty/DynamicApproxMultiplier.scala 176:25]
    node _encoders_1_io_b_bits_T = bits(b_extended, 4, 2) @[src/main/scala/empty/DynamicApproxMultiplier.scala 138:43]
    encoders_1.io.b_bits <= _encoders_1_io_b_bits_T @[src/main/scala/empty/DynamicApproxMultiplier.scala 138:30]
    encoders_1.io.is_approx <= row_is_approx[1] @[src/main/scala/empty/DynamicApproxMultiplier.scala 139:30]
    ppgs_1.io.a <= io.multiplicand @[src/main/scala/empty/DynamicApproxMultiplier.scala 142:23]
    ppgs_1.io.negate <= encoders_1.io.negate @[src/main/scala/empty/DynamicApproxMultiplier.scala 143:23]
    node row_is_zero_1 = or(encoders_1.io.zero, a_is_zero) @[src/main/scala/empty/DynamicApproxMultiplier.scala 148:43]
    wire pp_signed_1 : SInt<9> @[src/main/scala/empty/DynamicApproxMultiplier.scala 155:25]
    node _pp_signed_T_2 = shl(ppgs_1.io.partial_product, 1) @[src/main/scala/empty/DynamicApproxMultiplier.scala 156:50]
    node _pp_signed_T_3 = mux(encoders_1.io.two, _pp_signed_T_2, ppgs_1.io.partial_product) @[src/main/scala/empty/DynamicApproxMultiplier.scala 156:21]
    pp_signed_1 <= _pp_signed_T_3 @[src/main/scala/empty/DynamicApproxMultiplier.scala 156:15]
    wire pp_gated_1 : SInt<9> @[src/main/scala/empty/DynamicApproxMultiplier.scala 159:24]
    node _pp_gated_T_1 = mux(row_is_zero_1, asSInt(UInt<1>("h0")), pp_signed_1) @[src/main/scala/empty/DynamicApproxMultiplier.scala 160:20]
    pp_gated_1 <= _pp_gated_T_1 @[src/main/scala/empty/DynamicApproxMultiplier.scala 160:14]
    wire pp_extended_1 : SInt<16> @[src/main/scala/empty/DynamicApproxMultiplier.scala 163:27]
    pp_extended_1 <= pp_gated_1 @[src/main/scala/empty/DynamicApproxMultiplier.scala 164:17]
    node _need_correction_T_1 = eq(row_is_approx[1], UInt<1>("h0")) @[src/main/scala/empty/DynamicApproxMultiplier.scala 170:27]
    node need_correction_1 = and(_need_correction_T_1, encoders_1.io.negate) @[src/main/scala/empty/DynamicApproxMultiplier.scala 170:45]
    wire correction_bit_1 : SInt<16> @[src/main/scala/empty/DynamicApproxMultiplier.scala 171:30]
    node _correction_bit_T_3 = eq(row_is_zero_1, UInt<1>("h0")) @[src/main/scala/empty/DynamicApproxMultiplier.scala 172:46]
    node _correction_bit_T_4 = and(need_correction_1, _correction_bit_T_3) @[src/main/scala/empty/DynamicApproxMultiplier.scala 172:43]
    node _correction_bit_T_5 = mux(_correction_bit_T_4, asSInt(UInt<2>("h1")), asSInt(UInt<1>("h0"))) @[src/main/scala/empty/DynamicApproxMultiplier.scala 172:26]
    correction_bit_1 <= _correction_bit_T_5 @[src/main/scala/empty/DynamicApproxMultiplier.scala 172:20]
    node _partial_products_1_T = shl(pp_extended_1, 2) @[src/main/scala/empty/DynamicApproxMultiplier.scala 176:41]
    node _partial_products_1_T_1 = shl(correction_bit_1, 2) @[src/main/scala/empty/DynamicApproxMultiplier.scala 176:78]
    node _partial_products_1_T_2 = add(_partial_products_1_T, _partial_products_1_T_1) @[src/main/scala/empty/DynamicApproxMultiplier.scala 176:60]
    node _partial_products_1_T_3 = tail(_partial_products_1_T_2, 1) @[src/main/scala/empty/DynamicApproxMultiplier.scala 176:60]
    node _partial_products_1_T_4 = asSInt(_partial_products_1_T_3) @[src/main/scala/empty/DynamicApproxMultiplier.scala 176:60]
    partial_products[1] <= _partial_products_1_T_4 @[src/main/scala/empty/DynamicApproxMultiplier.scala 176:25]
    node _encoders_2_io_b_bits_T = bits(b_extended, 6, 4) @[src/main/scala/empty/DynamicApproxMultiplier.scala 138:43]
    encoders_2.io.b_bits <= _encoders_2_io_b_bits_T @[src/main/scala/empty/DynamicApproxMultiplier.scala 138:30]
    encoders_2.io.is_approx <= row_is_approx[2] @[src/main/scala/empty/DynamicApproxMultiplier.scala 139:30]
    ppgs_2.io.a <= io.multiplicand @[src/main/scala/empty/DynamicApproxMultiplier.scala 142:23]
    ppgs_2.io.negate <= encoders_2.io.negate @[src/main/scala/empty/DynamicApproxMultiplier.scala 143:23]
    node row_is_zero_2 = or(encoders_2.io.zero, a_is_zero) @[src/main/scala/empty/DynamicApproxMultiplier.scala 148:43]
    wire pp_signed_2 : SInt<9> @[src/main/scala/empty/DynamicApproxMultiplier.scala 155:25]
    node _pp_signed_T_4 = shl(ppgs_2.io.partial_product, 1) @[src/main/scala/empty/DynamicApproxMultiplier.scala 156:50]
    node _pp_signed_T_5 = mux(encoders_2.io.two, _pp_signed_T_4, ppgs_2.io.partial_product) @[src/main/scala/empty/DynamicApproxMultiplier.scala 156:21]
    pp_signed_2 <= _pp_signed_T_5 @[src/main/scala/empty/DynamicApproxMultiplier.scala 156:15]
    wire pp_gated_2 : SInt<9> @[src/main/scala/empty/DynamicApproxMultiplier.scala 159:24]
    node _pp_gated_T_2 = mux(row_is_zero_2, asSInt(UInt<1>("h0")), pp_signed_2) @[src/main/scala/empty/DynamicApproxMultiplier.scala 160:20]
    pp_gated_2 <= _pp_gated_T_2 @[src/main/scala/empty/DynamicApproxMultiplier.scala 160:14]
    wire pp_extended_2 : SInt<16> @[src/main/scala/empty/DynamicApproxMultiplier.scala 163:27]
    pp_extended_2 <= pp_gated_2 @[src/main/scala/empty/DynamicApproxMultiplier.scala 164:17]
    node _need_correction_T_2 = eq(row_is_approx[2], UInt<1>("h0")) @[src/main/scala/empty/DynamicApproxMultiplier.scala 170:27]
    node need_correction_2 = and(_need_correction_T_2, encoders_2.io.negate) @[src/main/scala/empty/DynamicApproxMultiplier.scala 170:45]
    wire correction_bit_2 : SInt<16> @[src/main/scala/empty/DynamicApproxMultiplier.scala 171:30]
    node _correction_bit_T_6 = eq(row_is_zero_2, UInt<1>("h0")) @[src/main/scala/empty/DynamicApproxMultiplier.scala 172:46]
    node _correction_bit_T_7 = and(need_correction_2, _correction_bit_T_6) @[src/main/scala/empty/DynamicApproxMultiplier.scala 172:43]
    node _correction_bit_T_8 = mux(_correction_bit_T_7, asSInt(UInt<2>("h1")), asSInt(UInt<1>("h0"))) @[src/main/scala/empty/DynamicApproxMultiplier.scala 172:26]
    correction_bit_2 <= _correction_bit_T_8 @[src/main/scala/empty/DynamicApproxMultiplier.scala 172:20]
    node _partial_products_2_T = shl(pp_extended_2, 4) @[src/main/scala/empty/DynamicApproxMultiplier.scala 176:41]
    node _partial_products_2_T_1 = shl(correction_bit_2, 4) @[src/main/scala/empty/DynamicApproxMultiplier.scala 176:78]
    node _partial_products_2_T_2 = add(_partial_products_2_T, _partial_products_2_T_1) @[src/main/scala/empty/DynamicApproxMultiplier.scala 176:60]
    node _partial_products_2_T_3 = tail(_partial_products_2_T_2, 1) @[src/main/scala/empty/DynamicApproxMultiplier.scala 176:60]
    node _partial_products_2_T_4 = asSInt(_partial_products_2_T_3) @[src/main/scala/empty/DynamicApproxMultiplier.scala 176:60]
    partial_products[2] <= _partial_products_2_T_4 @[src/main/scala/empty/DynamicApproxMultiplier.scala 176:25]
    node _encoders_3_io_b_bits_T = bits(b_extended, 8, 6) @[src/main/scala/empty/DynamicApproxMultiplier.scala 138:43]
    encoders_3.io.b_bits <= _encoders_3_io_b_bits_T @[src/main/scala/empty/DynamicApproxMultiplier.scala 138:30]
    encoders_3.io.is_approx <= row_is_approx[3] @[src/main/scala/empty/DynamicApproxMultiplier.scala 139:30]
    ppgs_3.io.a <= io.multiplicand @[src/main/scala/empty/DynamicApproxMultiplier.scala 142:23]
    ppgs_3.io.negate <= encoders_3.io.negate @[src/main/scala/empty/DynamicApproxMultiplier.scala 143:23]
    node row_is_zero_3 = or(encoders_3.io.zero, a_is_zero) @[src/main/scala/empty/DynamicApproxMultiplier.scala 148:43]
    wire pp_signed_3 : SInt<9> @[src/main/scala/empty/DynamicApproxMultiplier.scala 155:25]
    node _pp_signed_T_6 = shl(ppgs_3.io.partial_product, 1) @[src/main/scala/empty/DynamicApproxMultiplier.scala 156:50]
    node _pp_signed_T_7 = mux(encoders_3.io.two, _pp_signed_T_6, ppgs_3.io.partial_product) @[src/main/scala/empty/DynamicApproxMultiplier.scala 156:21]
    pp_signed_3 <= _pp_signed_T_7 @[src/main/scala/empty/DynamicApproxMultiplier.scala 156:15]
    wire pp_gated_3 : SInt<9> @[src/main/scala/empty/DynamicApproxMultiplier.scala 159:24]
    node _pp_gated_T_3 = mux(row_is_zero_3, asSInt(UInt<1>("h0")), pp_signed_3) @[src/main/scala/empty/DynamicApproxMultiplier.scala 160:20]
    pp_gated_3 <= _pp_gated_T_3 @[src/main/scala/empty/DynamicApproxMultiplier.scala 160:14]
    wire pp_extended_3 : SInt<16> @[src/main/scala/empty/DynamicApproxMultiplier.scala 163:27]
    pp_extended_3 <= pp_gated_3 @[src/main/scala/empty/DynamicApproxMultiplier.scala 164:17]
    node _need_correction_T_3 = eq(row_is_approx[3], UInt<1>("h0")) @[src/main/scala/empty/DynamicApproxMultiplier.scala 170:27]
    node need_correction_3 = and(_need_correction_T_3, encoders_3.io.negate) @[src/main/scala/empty/DynamicApproxMultiplier.scala 170:45]
    wire correction_bit_3 : SInt<16> @[src/main/scala/empty/DynamicApproxMultiplier.scala 171:30]
    node _correction_bit_T_9 = eq(row_is_zero_3, UInt<1>("h0")) @[src/main/scala/empty/DynamicApproxMultiplier.scala 172:46]
    node _correction_bit_T_10 = and(need_correction_3, _correction_bit_T_9) @[src/main/scala/empty/DynamicApproxMultiplier.scala 172:43]
    node _correction_bit_T_11 = mux(_correction_bit_T_10, asSInt(UInt<2>("h1")), asSInt(UInt<1>("h0"))) @[src/main/scala/empty/DynamicApproxMultiplier.scala 172:26]
    correction_bit_3 <= _correction_bit_T_11 @[src/main/scala/empty/DynamicApproxMultiplier.scala 172:20]
    node _partial_products_3_T = shl(pp_extended_3, 6) @[src/main/scala/empty/DynamicApproxMultiplier.scala 176:41]
    node _partial_products_3_T_1 = shl(correction_bit_3, 6) @[src/main/scala/empty/DynamicApproxMultiplier.scala 176:78]
    node _partial_products_3_T_2 = add(_partial_products_3_T, _partial_products_3_T_1) @[src/main/scala/empty/DynamicApproxMultiplier.scala 176:60]
    node _partial_products_3_T_3 = tail(_partial_products_3_T_2, 1) @[src/main/scala/empty/DynamicApproxMultiplier.scala 176:60]
    node _partial_products_3_T_4 = asSInt(_partial_products_3_T_3) @[src/main/scala/empty/DynamicApproxMultiplier.scala 176:60]
    partial_products[3] <= _partial_products_3_T_4 @[src/main/scala/empty/DynamicApproxMultiplier.scala 176:25]
    inst wallace_tree of ApproxWallaceTree @[src/main/scala/empty/DynamicApproxMultiplier.scala 180:28]
    wallace_tree.clock <= clock
    wallace_tree.reset <= reset
    wallace_tree.io.shifted_partial_products[0] <= partial_products[0] @[src/main/scala/empty/DynamicApproxMultiplier.scala 181:44]
    wallace_tree.io.shifted_partial_products[1] <= partial_products[1] @[src/main/scala/empty/DynamicApproxMultiplier.scala 181:44]
    wallace_tree.io.shifted_partial_products[2] <= partial_products[2] @[src/main/scala/empty/DynamicApproxMultiplier.scala 181:44]
    wallace_tree.io.shifted_partial_products[3] <= partial_products[3] @[src/main/scala/empty/DynamicApproxMultiplier.scala 181:44]
    io.product <= wallace_tree.io.final_product @[src/main/scala/empty/DynamicApproxMultiplier.scala 182:14]

