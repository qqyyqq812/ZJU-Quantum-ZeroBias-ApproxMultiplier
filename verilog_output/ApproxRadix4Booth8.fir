FIRRTL version 1.2.0
circuit ApproxRadix4Booth8 :
  module R4ABE2 :
    input clock : Clock
    input reset : Reset
    output io : { flip b_bits : UInt<3>, neg : UInt<1>, factor : UInt<2>} @[src/main/scala/empty/R4ABE2.scala 9:14]

    node b_i_plus_1 = bits(io.b_bits, 2, 2) @[src/main/scala/empty/R4ABE2.scala 18:29]
    node b_i = bits(io.b_bits, 1, 1) @[src/main/scala/empty/R4ABE2.scala 19:29]
    node b_i_minus_1 = bits(io.b_bits, 0, 0) @[src/main/scala/empty/R4ABE2.scala 20:30]
    io.neg <= b_i_plus_1 @[src/main/scala/empty/R4ABE2.scala 28:10]
    node _is_zero_T = eq(io.b_bits, UInt<1>("h0")) @[src/main/scala/empty/R4ABE2.scala 36:28]
    node _is_zero_T_1 = eq(io.b_bits, UInt<3>("h7")) @[src/main/scala/empty/R4ABE2.scala 36:51]
    node is_zero = or(_is_zero_T, _is_zero_T_1) @[src/main/scala/empty/R4ABE2.scala 36:37]
    node _io_factor_T = mux(is_zero, UInt<2>("h0"), UInt<2>("h1")) @[src/main/scala/empty/R4ABE2.scala 39:19]
    io.factor <= _io_factor_T @[src/main/scala/empty/R4ABE2.scala 39:13]

  module PartialProductGenerator :
    input clock : Clock
    input reset : Reset
    output io : { flip a : SInt<8>, flip neg : UInt<1>, flip factor : UInt<2>, partial_product : SInt<10>} @[src/main/scala/empty/PartialProductGenerator.scala 8:14]

    wire magnitude : SInt<9> @[src/main/scala/empty/PartialProductGenerator.scala 16:23]
    node _magnitude_T = eq(io.factor, UInt<1>("h0")) @[src/main/scala/empty/PartialProductGenerator.scala 19:30]
    node _magnitude_T_1 = mux(_magnitude_T, asSInt(UInt<1>("h0")), io.a) @[src/main/scala/empty/PartialProductGenerator.scala 19:19]
    magnitude <= _magnitude_T_1 @[src/main/scala/empty/PartialProductGenerator.scala 19:13]
    node _neg_result_T = not(magnitude) @[src/main/scala/empty/PartialProductGenerator.scala 23:21]
    node _neg_result_T_1 = asSInt(_neg_result_T) @[src/main/scala/empty/PartialProductGenerator.scala 23:21]
    node _neg_result_T_2 = add(_neg_result_T_1, asSInt(UInt<9>("h1"))) @[src/main/scala/empty/PartialProductGenerator.scala 23:40]
    node _neg_result_T_3 = tail(_neg_result_T_2, 1) @[src/main/scala/empty/PartialProductGenerator.scala 23:40]
    node neg_result = asSInt(_neg_result_T_3) @[src/main/scala/empty/PartialProductGenerator.scala 23:40]
    node pp_9_bit = mux(io.neg, neg_result, magnitude) @[src/main/scala/empty/PartialProductGenerator.scala 27:21]
    node _io_partial_product_T = bits(pp_9_bit, 8, 8) @[src/main/scala/empty/PartialProductGenerator.scala 28:37]
    node io_partial_product_lo = asUInt(pp_9_bit) @[src/main/scala/empty/PartialProductGenerator.scala 28:28]
    node _io_partial_product_T_1 = cat(_io_partial_product_T, io_partial_product_lo) @[src/main/scala/empty/PartialProductGenerator.scala 28:28]
    node _io_partial_product_T_2 = asSInt(_io_partial_product_T_1) @[src/main/scala/empty/PartialProductGenerator.scala 28:52]
    io.partial_product <= _io_partial_product_T_2 @[src/main/scala/empty/PartialProductGenerator.scala 28:22]

  module R4ABE2_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip b_bits : UInt<3>, neg : UInt<1>, factor : UInt<2>} @[src/main/scala/empty/R4ABE2.scala 9:14]

    node b_i_plus_1 = bits(io.b_bits, 2, 2) @[src/main/scala/empty/R4ABE2.scala 18:29]
    node b_i = bits(io.b_bits, 1, 1) @[src/main/scala/empty/R4ABE2.scala 19:29]
    node b_i_minus_1 = bits(io.b_bits, 0, 0) @[src/main/scala/empty/R4ABE2.scala 20:30]
    io.neg <= b_i_plus_1 @[src/main/scala/empty/R4ABE2.scala 28:10]
    node _is_zero_T = eq(io.b_bits, UInt<1>("h0")) @[src/main/scala/empty/R4ABE2.scala 36:28]
    node _is_zero_T_1 = eq(io.b_bits, UInt<3>("h7")) @[src/main/scala/empty/R4ABE2.scala 36:51]
    node is_zero = or(_is_zero_T, _is_zero_T_1) @[src/main/scala/empty/R4ABE2.scala 36:37]
    node _io_factor_T = mux(is_zero, UInt<2>("h0"), UInt<2>("h1")) @[src/main/scala/empty/R4ABE2.scala 39:19]
    io.factor <= _io_factor_T @[src/main/scala/empty/R4ABE2.scala 39:13]

  module PartialProductGenerator_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : SInt<8>, flip neg : UInt<1>, flip factor : UInt<2>, partial_product : SInt<10>} @[src/main/scala/empty/PartialProductGenerator.scala 8:14]

    wire magnitude : SInt<9> @[src/main/scala/empty/PartialProductGenerator.scala 16:23]
    node _magnitude_T = eq(io.factor, UInt<1>("h0")) @[src/main/scala/empty/PartialProductGenerator.scala 19:30]
    node _magnitude_T_1 = mux(_magnitude_T, asSInt(UInt<1>("h0")), io.a) @[src/main/scala/empty/PartialProductGenerator.scala 19:19]
    magnitude <= _magnitude_T_1 @[src/main/scala/empty/PartialProductGenerator.scala 19:13]
    node _neg_result_T = not(magnitude) @[src/main/scala/empty/PartialProductGenerator.scala 23:21]
    node _neg_result_T_1 = asSInt(_neg_result_T) @[src/main/scala/empty/PartialProductGenerator.scala 23:21]
    node _neg_result_T_2 = add(_neg_result_T_1, asSInt(UInt<9>("h1"))) @[src/main/scala/empty/PartialProductGenerator.scala 23:40]
    node _neg_result_T_3 = tail(_neg_result_T_2, 1) @[src/main/scala/empty/PartialProductGenerator.scala 23:40]
    node neg_result = asSInt(_neg_result_T_3) @[src/main/scala/empty/PartialProductGenerator.scala 23:40]
    node pp_9_bit = mux(io.neg, neg_result, magnitude) @[src/main/scala/empty/PartialProductGenerator.scala 27:21]
    node _io_partial_product_T = bits(pp_9_bit, 8, 8) @[src/main/scala/empty/PartialProductGenerator.scala 28:37]
    node io_partial_product_lo = asUInt(pp_9_bit) @[src/main/scala/empty/PartialProductGenerator.scala 28:28]
    node _io_partial_product_T_1 = cat(_io_partial_product_T, io_partial_product_lo) @[src/main/scala/empty/PartialProductGenerator.scala 28:28]
    node _io_partial_product_T_2 = asSInt(_io_partial_product_T_1) @[src/main/scala/empty/PartialProductGenerator.scala 28:52]
    io.partial_product <= _io_partial_product_T_2 @[src/main/scala/empty/PartialProductGenerator.scala 28:22]

  module R4ABE2_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip b_bits : UInt<3>, neg : UInt<1>, factor : UInt<2>} @[src/main/scala/empty/R4ABE2.scala 9:14]

    node b_i_plus_1 = bits(io.b_bits, 2, 2) @[src/main/scala/empty/R4ABE2.scala 18:29]
    node b_i = bits(io.b_bits, 1, 1) @[src/main/scala/empty/R4ABE2.scala 19:29]
    node b_i_minus_1 = bits(io.b_bits, 0, 0) @[src/main/scala/empty/R4ABE2.scala 20:30]
    io.neg <= b_i_plus_1 @[src/main/scala/empty/R4ABE2.scala 28:10]
    node _is_zero_T = eq(io.b_bits, UInt<1>("h0")) @[src/main/scala/empty/R4ABE2.scala 36:28]
    node _is_zero_T_1 = eq(io.b_bits, UInt<3>("h7")) @[src/main/scala/empty/R4ABE2.scala 36:51]
    node is_zero = or(_is_zero_T, _is_zero_T_1) @[src/main/scala/empty/R4ABE2.scala 36:37]
    node _io_factor_T = mux(is_zero, UInt<2>("h0"), UInt<2>("h1")) @[src/main/scala/empty/R4ABE2.scala 39:19]
    io.factor <= _io_factor_T @[src/main/scala/empty/R4ABE2.scala 39:13]

  module PartialProductGenerator_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : SInt<8>, flip neg : UInt<1>, flip factor : UInt<2>, partial_product : SInt<10>} @[src/main/scala/empty/PartialProductGenerator.scala 8:14]

    wire magnitude : SInt<9> @[src/main/scala/empty/PartialProductGenerator.scala 16:23]
    node _magnitude_T = eq(io.factor, UInt<1>("h0")) @[src/main/scala/empty/PartialProductGenerator.scala 19:30]
    node _magnitude_T_1 = mux(_magnitude_T, asSInt(UInt<1>("h0")), io.a) @[src/main/scala/empty/PartialProductGenerator.scala 19:19]
    magnitude <= _magnitude_T_1 @[src/main/scala/empty/PartialProductGenerator.scala 19:13]
    node _neg_result_T = not(magnitude) @[src/main/scala/empty/PartialProductGenerator.scala 23:21]
    node _neg_result_T_1 = asSInt(_neg_result_T) @[src/main/scala/empty/PartialProductGenerator.scala 23:21]
    node _neg_result_T_2 = add(_neg_result_T_1, asSInt(UInt<9>("h1"))) @[src/main/scala/empty/PartialProductGenerator.scala 23:40]
    node _neg_result_T_3 = tail(_neg_result_T_2, 1) @[src/main/scala/empty/PartialProductGenerator.scala 23:40]
    node neg_result = asSInt(_neg_result_T_3) @[src/main/scala/empty/PartialProductGenerator.scala 23:40]
    node pp_9_bit = mux(io.neg, neg_result, magnitude) @[src/main/scala/empty/PartialProductGenerator.scala 27:21]
    node _io_partial_product_T = bits(pp_9_bit, 8, 8) @[src/main/scala/empty/PartialProductGenerator.scala 28:37]
    node io_partial_product_lo = asUInt(pp_9_bit) @[src/main/scala/empty/PartialProductGenerator.scala 28:28]
    node _io_partial_product_T_1 = cat(_io_partial_product_T, io_partial_product_lo) @[src/main/scala/empty/PartialProductGenerator.scala 28:28]
    node _io_partial_product_T_2 = asSInt(_io_partial_product_T_1) @[src/main/scala/empty/PartialProductGenerator.scala 28:52]
    io.partial_product <= _io_partial_product_T_2 @[src/main/scala/empty/PartialProductGenerator.scala 28:22]

  module R4ABE2_3 :
    input clock : Clock
    input reset : Reset
    output io : { flip b_bits : UInt<3>, neg : UInt<1>, factor : UInt<2>} @[src/main/scala/empty/R4ABE2.scala 9:14]

    node b_i_plus_1 = bits(io.b_bits, 2, 2) @[src/main/scala/empty/R4ABE2.scala 18:29]
    node b_i = bits(io.b_bits, 1, 1) @[src/main/scala/empty/R4ABE2.scala 19:29]
    node b_i_minus_1 = bits(io.b_bits, 0, 0) @[src/main/scala/empty/R4ABE2.scala 20:30]
    io.neg <= b_i_plus_1 @[src/main/scala/empty/R4ABE2.scala 28:10]
    node _is_zero_T = eq(io.b_bits, UInt<1>("h0")) @[src/main/scala/empty/R4ABE2.scala 36:28]
    node _is_zero_T_1 = eq(io.b_bits, UInt<3>("h7")) @[src/main/scala/empty/R4ABE2.scala 36:51]
    node is_zero = or(_is_zero_T, _is_zero_T_1) @[src/main/scala/empty/R4ABE2.scala 36:37]
    node _io_factor_T = mux(is_zero, UInt<2>("h0"), UInt<2>("h1")) @[src/main/scala/empty/R4ABE2.scala 39:19]
    io.factor <= _io_factor_T @[src/main/scala/empty/R4ABE2.scala 39:13]

  module PartialProductGenerator_3 :
    input clock : Clock
    input reset : Reset
    output io : { flip a : SInt<8>, flip neg : UInt<1>, flip factor : UInt<2>, partial_product : SInt<10>} @[src/main/scala/empty/PartialProductGenerator.scala 8:14]

    wire magnitude : SInt<9> @[src/main/scala/empty/PartialProductGenerator.scala 16:23]
    node _magnitude_T = eq(io.factor, UInt<1>("h0")) @[src/main/scala/empty/PartialProductGenerator.scala 19:30]
    node _magnitude_T_1 = mux(_magnitude_T, asSInt(UInt<1>("h0")), io.a) @[src/main/scala/empty/PartialProductGenerator.scala 19:19]
    magnitude <= _magnitude_T_1 @[src/main/scala/empty/PartialProductGenerator.scala 19:13]
    node _neg_result_T = not(magnitude) @[src/main/scala/empty/PartialProductGenerator.scala 23:21]
    node _neg_result_T_1 = asSInt(_neg_result_T) @[src/main/scala/empty/PartialProductGenerator.scala 23:21]
    node _neg_result_T_2 = add(_neg_result_T_1, asSInt(UInt<9>("h1"))) @[src/main/scala/empty/PartialProductGenerator.scala 23:40]
    node _neg_result_T_3 = tail(_neg_result_T_2, 1) @[src/main/scala/empty/PartialProductGenerator.scala 23:40]
    node neg_result = asSInt(_neg_result_T_3) @[src/main/scala/empty/PartialProductGenerator.scala 23:40]
    node pp_9_bit = mux(io.neg, neg_result, magnitude) @[src/main/scala/empty/PartialProductGenerator.scala 27:21]
    node _io_partial_product_T = bits(pp_9_bit, 8, 8) @[src/main/scala/empty/PartialProductGenerator.scala 28:37]
    node io_partial_product_lo = asUInt(pp_9_bit) @[src/main/scala/empty/PartialProductGenerator.scala 28:28]
    node _io_partial_product_T_1 = cat(_io_partial_product_T, io_partial_product_lo) @[src/main/scala/empty/PartialProductGenerator.scala 28:28]
    node _io_partial_product_T_2 = asSInt(_io_partial_product_T_1) @[src/main/scala/empty/PartialProductGenerator.scala 28:52]
    io.partial_product <= _io_partial_product_T_2 @[src/main/scala/empty/PartialProductGenerator.scala 28:22]

  module ApproxWallaceTree :
    input clock : Clock
    input reset : Reset
    output io : { flip shifted_partial_products : SInt<16>[4], final_product : SInt<16>} @[src/main/scala/empty/ApproxWallaceTree.scala 9:14]

    node _final_sum_T = add(io.shifted_partial_products[0], io.shifted_partial_products[1]) @[src/main/scala/empty/ApproxWallaceTree.scala 19:60]
    node _final_sum_T_1 = add(io.shifted_partial_products[2], io.shifted_partial_products[3]) @[src/main/scala/empty/ApproxWallaceTree.scala 19:60]
    node final_sum = add(_final_sum_T, _final_sum_T_1) @[src/main/scala/empty/ApproxWallaceTree.scala 19:60]
    node _io_final_product_T = head(final_sum, 16) @[src/main/scala/empty/ApproxWallaceTree.scala 24:37]
    node _io_final_product_T_1 = asSInt(_io_final_product_T) @[src/main/scala/empty/ApproxWallaceTree.scala 24:42]
    io.final_product <= _io_final_product_T_1 @[src/main/scala/empty/ApproxWallaceTree.scala 24:20]
    node _final_result_T = add(io.shifted_partial_products[0], io.shifted_partial_products[1]) @[src/main/scala/empty/ApproxWallaceTree.scala 44:46]
    node _final_result_T_1 = add(io.shifted_partial_products[2], io.shifted_partial_products[3]) @[src/main/scala/empty/ApproxWallaceTree.scala 44:46]
    node final_result = add(_final_result_T, _final_result_T_1) @[src/main/scala/empty/ApproxWallaceTree.scala 44:46]
    io.final_product <= final_result @[src/main/scala/empty/ApproxWallaceTree.scala 47:20]

  module ApproxRadix4Booth8 :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip multiplicand : SInt<8>, flip multiplier : SInt<8>, product : SInt<16>} @[src/main/scala/empty/ApproxRadix4Booth8.scala 8:14]

    node _B_ext_T = bits(io.multiplier, 7, 7) @[src/main/scala/empty/ApproxRadix4Booth8.scala 19:32]
    node B_ext_hi_lo = asUInt(io.multiplier) @[src/main/scala/empty/ApproxRadix4Booth8.scala 19:18]
    node B_ext_hi = cat(_B_ext_T, B_ext_hi_lo) @[src/main/scala/empty/ApproxRadix4Booth8.scala 19:18]
    node B_ext = cat(B_ext_hi, UInt<1>("h0")) @[src/main/scala/empty/ApproxRadix4Booth8.scala 19:18]
    node partial_products_list_b_bits = bits(B_ext, 2, 0) @[src/main/scala/empty/ApproxRadix4Booth8.scala 25:23]
    inst partial_products_list_booth_encoder of R4ABE2 @[src/main/scala/empty/ApproxRadix4Booth8.scala 28:31]
    partial_products_list_booth_encoder.clock <= clock
    partial_products_list_booth_encoder.reset <= reset
    partial_products_list_booth_encoder.io.b_bits <= partial_products_list_b_bits @[src/main/scala/empty/ApproxRadix4Booth8.scala 29:29]
    inst partial_products_list_ppg of PartialProductGenerator @[src/main/scala/empty/ApproxRadix4Booth8.scala 32:21]
    partial_products_list_ppg.clock <= clock
    partial_products_list_ppg.reset <= reset
    partial_products_list_ppg.io.a <= io.multiplicand @[src/main/scala/empty/ApproxRadix4Booth8.scala 33:14]
    partial_products_list_ppg.io.neg <= partial_products_list_booth_encoder.io.neg @[src/main/scala/empty/ApproxRadix4Booth8.scala 34:16]
    partial_products_list_ppg.io.factor <= partial_products_list_booth_encoder.io.factor @[src/main/scala/empty/ApproxRadix4Booth8.scala 35:19]
    node _partial_products_list_pp_shifted_T = asUInt(partial_products_list_ppg.io.partial_product) @[src/main/scala/empty/ApproxRadix4Booth8.scala 44:33]
    node _partial_products_list_pp_shifted_T_1 = dshl(_partial_products_list_pp_shifted_T, UInt<1>("h0")) @[src/main/scala/empty/ApproxRadix4Booth8.scala 44:40]
    node _partial_products_list_pp_shifted_T_2 = asSInt(_partial_products_list_pp_shifted_T_1) @[src/main/scala/empty/ApproxRadix4Booth8.scala 44:57]
    node partial_products_list_0 = pad(_partial_products_list_pp_shifted_T_2, 16) @[src/main/scala/empty/ApproxRadix4Booth8.scala 44:67]
    node partial_products_list_b_bits_1 = bits(B_ext, 4, 2) @[src/main/scala/empty/ApproxRadix4Booth8.scala 25:23]
    inst partial_products_list_booth_encoder_1 of R4ABE2_1 @[src/main/scala/empty/ApproxRadix4Booth8.scala 28:31]
    partial_products_list_booth_encoder_1.clock <= clock
    partial_products_list_booth_encoder_1.reset <= reset
    partial_products_list_booth_encoder_1.io.b_bits <= partial_products_list_b_bits_1 @[src/main/scala/empty/ApproxRadix4Booth8.scala 29:29]
    inst partial_products_list_ppg_1 of PartialProductGenerator_1 @[src/main/scala/empty/ApproxRadix4Booth8.scala 32:21]
    partial_products_list_ppg_1.clock <= clock
    partial_products_list_ppg_1.reset <= reset
    partial_products_list_ppg_1.io.a <= io.multiplicand @[src/main/scala/empty/ApproxRadix4Booth8.scala 33:14]
    partial_products_list_ppg_1.io.neg <= partial_products_list_booth_encoder_1.io.neg @[src/main/scala/empty/ApproxRadix4Booth8.scala 34:16]
    partial_products_list_ppg_1.io.factor <= partial_products_list_booth_encoder_1.io.factor @[src/main/scala/empty/ApproxRadix4Booth8.scala 35:19]
    node _partial_products_list_pp_shifted_T_3 = asUInt(partial_products_list_ppg_1.io.partial_product) @[src/main/scala/empty/ApproxRadix4Booth8.scala 44:33]
    node _partial_products_list_pp_shifted_T_4 = dshl(_partial_products_list_pp_shifted_T_3, UInt<2>("h2")) @[src/main/scala/empty/ApproxRadix4Booth8.scala 44:40]
    node _partial_products_list_pp_shifted_T_5 = asSInt(_partial_products_list_pp_shifted_T_4) @[src/main/scala/empty/ApproxRadix4Booth8.scala 44:57]
    node partial_products_list_1 = pad(_partial_products_list_pp_shifted_T_5, 16) @[src/main/scala/empty/ApproxRadix4Booth8.scala 44:67]
    node partial_products_list_b_bits_2 = bits(B_ext, 6, 4) @[src/main/scala/empty/ApproxRadix4Booth8.scala 25:23]
    inst partial_products_list_booth_encoder_2 of R4ABE2_2 @[src/main/scala/empty/ApproxRadix4Booth8.scala 28:31]
    partial_products_list_booth_encoder_2.clock <= clock
    partial_products_list_booth_encoder_2.reset <= reset
    partial_products_list_booth_encoder_2.io.b_bits <= partial_products_list_b_bits_2 @[src/main/scala/empty/ApproxRadix4Booth8.scala 29:29]
    inst partial_products_list_ppg_2 of PartialProductGenerator_2 @[src/main/scala/empty/ApproxRadix4Booth8.scala 32:21]
    partial_products_list_ppg_2.clock <= clock
    partial_products_list_ppg_2.reset <= reset
    partial_products_list_ppg_2.io.a <= io.multiplicand @[src/main/scala/empty/ApproxRadix4Booth8.scala 33:14]
    partial_products_list_ppg_2.io.neg <= partial_products_list_booth_encoder_2.io.neg @[src/main/scala/empty/ApproxRadix4Booth8.scala 34:16]
    partial_products_list_ppg_2.io.factor <= partial_products_list_booth_encoder_2.io.factor @[src/main/scala/empty/ApproxRadix4Booth8.scala 35:19]
    node _partial_products_list_pp_shifted_T_6 = asUInt(partial_products_list_ppg_2.io.partial_product) @[src/main/scala/empty/ApproxRadix4Booth8.scala 44:33]
    node _partial_products_list_pp_shifted_T_7 = dshl(_partial_products_list_pp_shifted_T_6, UInt<3>("h4")) @[src/main/scala/empty/ApproxRadix4Booth8.scala 44:40]
    node partial_products_list_2 = asSInt(_partial_products_list_pp_shifted_T_7) @[src/main/scala/empty/ApproxRadix4Booth8.scala 44:57]
    node partial_products_list_b_bits_3 = bits(B_ext, 8, 6) @[src/main/scala/empty/ApproxRadix4Booth8.scala 25:23]
    inst partial_products_list_booth_encoder_3 of R4ABE2_3 @[src/main/scala/empty/ApproxRadix4Booth8.scala 28:31]
    partial_products_list_booth_encoder_3.clock <= clock
    partial_products_list_booth_encoder_3.reset <= reset
    partial_products_list_booth_encoder_3.io.b_bits <= partial_products_list_b_bits_3 @[src/main/scala/empty/ApproxRadix4Booth8.scala 29:29]
    inst partial_products_list_ppg_3 of PartialProductGenerator_3 @[src/main/scala/empty/ApproxRadix4Booth8.scala 32:21]
    partial_products_list_ppg_3.clock <= clock
    partial_products_list_ppg_3.reset <= reset
    partial_products_list_ppg_3.io.a <= io.multiplicand @[src/main/scala/empty/ApproxRadix4Booth8.scala 33:14]
    partial_products_list_ppg_3.io.neg <= partial_products_list_booth_encoder_3.io.neg @[src/main/scala/empty/ApproxRadix4Booth8.scala 34:16]
    partial_products_list_ppg_3.io.factor <= partial_products_list_booth_encoder_3.io.factor @[src/main/scala/empty/ApproxRadix4Booth8.scala 35:19]
    node _partial_products_list_pp_shifted_T_8 = asUInt(partial_products_list_ppg_3.io.partial_product) @[src/main/scala/empty/ApproxRadix4Booth8.scala 44:33]
    node _partial_products_list_pp_shifted_T_9 = dshl(_partial_products_list_pp_shifted_T_8, UInt<3>("h6")) @[src/main/scala/empty/ApproxRadix4Booth8.scala 44:40]
    node partial_products_list_3 = asSInt(_partial_products_list_pp_shifted_T_9) @[src/main/scala/empty/ApproxRadix4Booth8.scala 44:57]
    wire shifted_products : SInt<17>[4] @[src/main/scala/empty/ApproxRadix4Booth8.scala 50:33]
    shifted_products[0] <= partial_products_list_0 @[src/main/scala/empty/ApproxRadix4Booth8.scala 50:33]
    shifted_products[1] <= partial_products_list_1 @[src/main/scala/empty/ApproxRadix4Booth8.scala 50:33]
    shifted_products[2] <= partial_products_list_2 @[src/main/scala/empty/ApproxRadix4Booth8.scala 50:33]
    shifted_products[3] <= partial_products_list_3 @[src/main/scala/empty/ApproxRadix4Booth8.scala 50:33]
    inst accumulator of ApproxWallaceTree @[src/main/scala/empty/ApproxRadix4Booth8.scala 53:27]
    accumulator.clock <= clock
    accumulator.reset <= reset
    accumulator.io.shifted_partial_products[0] <= shifted_products[0] @[src/main/scala/empty/ApproxRadix4Booth8.scala 54:43]
    accumulator.io.shifted_partial_products[1] <= shifted_products[1] @[src/main/scala/empty/ApproxRadix4Booth8.scala 54:43]
    accumulator.io.shifted_partial_products[2] <= shifted_products[2] @[src/main/scala/empty/ApproxRadix4Booth8.scala 54:43]
    accumulator.io.shifted_partial_products[3] <= shifted_products[3] @[src/main/scala/empty/ApproxRadix4Booth8.scala 54:43]
    io.product <= accumulator.io.final_product @[src/main/scala/empty/ApproxRadix4Booth8.scala 56:14]

