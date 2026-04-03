FIRRTL version 1.2.0
circuit RegularBooth8NoBRC :
  module RegularEncoder :
    input clock : Clock
    input reset : Reset
    output io : { flip b_bits : UInt<3>, neg : UInt<1>, zero : UInt<1>, two : UInt<1>} @[src/main/scala/regular/RegularBooth8.scala 14:14]

    node _io_neg_T = bits(io.b_bits, 2, 2) @[src/main/scala/regular/RegularBooth8.scala 21:22]
    io.neg <= _io_neg_T @[src/main/scala/regular/RegularBooth8.scala 21:10]
    node _io_zero_T = eq(io.b_bits, UInt<1>("h0")) @[src/main/scala/regular/RegularBooth8.scala 22:25]
    node _io_zero_T_1 = eq(io.b_bits, UInt<3>("h7")) @[src/main/scala/regular/RegularBooth8.scala 22:48]
    node _io_zero_T_2 = or(_io_zero_T, _io_zero_T_1) @[src/main/scala/regular/RegularBooth8.scala 22:34]
    io.zero <= _io_zero_T_2 @[src/main/scala/regular/RegularBooth8.scala 22:11]
    io.two <= UInt<1>("h0") @[src/main/scala/regular/RegularBooth8.scala 25:12]

  module RegularEncoder_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip b_bits : UInt<3>, neg : UInt<1>, zero : UInt<1>, two : UInt<1>} @[src/main/scala/regular/RegularBooth8.scala 14:14]

    node _io_neg_T = bits(io.b_bits, 2, 2) @[src/main/scala/regular/RegularBooth8.scala 21:22]
    io.neg <= _io_neg_T @[src/main/scala/regular/RegularBooth8.scala 21:10]
    node _io_zero_T = eq(io.b_bits, UInt<1>("h0")) @[src/main/scala/regular/RegularBooth8.scala 22:25]
    node _io_zero_T_1 = eq(io.b_bits, UInt<3>("h7")) @[src/main/scala/regular/RegularBooth8.scala 22:48]
    node _io_zero_T_2 = or(_io_zero_T, _io_zero_T_1) @[src/main/scala/regular/RegularBooth8.scala 22:34]
    io.zero <= _io_zero_T_2 @[src/main/scala/regular/RegularBooth8.scala 22:11]
    io.two <= UInt<1>("h0") @[src/main/scala/regular/RegularBooth8.scala 25:12]

  module RegularEncoder_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip b_bits : UInt<3>, neg : UInt<1>, zero : UInt<1>, two : UInt<1>} @[src/main/scala/regular/RegularBooth8.scala 14:14]

    node _io_neg_T = bits(io.b_bits, 2, 2) @[src/main/scala/regular/RegularBooth8.scala 21:22]
    io.neg <= _io_neg_T @[src/main/scala/regular/RegularBooth8.scala 21:10]
    node _io_zero_T = eq(io.b_bits, UInt<1>("h0")) @[src/main/scala/regular/RegularBooth8.scala 22:25]
    node _io_zero_T_1 = eq(io.b_bits, UInt<3>("h7")) @[src/main/scala/regular/RegularBooth8.scala 22:48]
    node _io_zero_T_2 = or(_io_zero_T, _io_zero_T_1) @[src/main/scala/regular/RegularBooth8.scala 22:34]
    io.zero <= _io_zero_T_2 @[src/main/scala/regular/RegularBooth8.scala 22:11]
    node _io_two_T = eq(io.b_bits, UInt<2>("h3")) @[src/main/scala/regular/RegularBooth8.scala 27:26]
    node _io_two_T_1 = eq(io.b_bits, UInt<3>("h4")) @[src/main/scala/regular/RegularBooth8.scala 27:49]
    node _io_two_T_2 = or(_io_two_T, _io_two_T_1) @[src/main/scala/regular/RegularBooth8.scala 27:35]
    io.two <= _io_two_T_2 @[src/main/scala/regular/RegularBooth8.scala 27:12]

  module RegularEncoder_3 :
    input clock : Clock
    input reset : Reset
    output io : { flip b_bits : UInt<3>, neg : UInt<1>, zero : UInt<1>, two : UInt<1>} @[src/main/scala/regular/RegularBooth8.scala 14:14]

    node _io_neg_T = bits(io.b_bits, 2, 2) @[src/main/scala/regular/RegularBooth8.scala 21:22]
    io.neg <= _io_neg_T @[src/main/scala/regular/RegularBooth8.scala 21:10]
    node _io_zero_T = eq(io.b_bits, UInt<1>("h0")) @[src/main/scala/regular/RegularBooth8.scala 22:25]
    node _io_zero_T_1 = eq(io.b_bits, UInt<3>("h7")) @[src/main/scala/regular/RegularBooth8.scala 22:48]
    node _io_zero_T_2 = or(_io_zero_T, _io_zero_T_1) @[src/main/scala/regular/RegularBooth8.scala 22:34]
    io.zero <= _io_zero_T_2 @[src/main/scala/regular/RegularBooth8.scala 22:11]
    node _io_two_T = eq(io.b_bits, UInt<2>("h3")) @[src/main/scala/regular/RegularBooth8.scala 27:26]
    node _io_two_T_1 = eq(io.b_bits, UInt<3>("h4")) @[src/main/scala/regular/RegularBooth8.scala 27:49]
    node _io_two_T_2 = or(_io_two_T, _io_two_T_1) @[src/main/scala/regular/RegularBooth8.scala 27:35]
    io.two <= _io_two_T_2 @[src/main/scala/regular/RegularBooth8.scala 27:12]

  module RegularBooth8NoBRC :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip a : UInt<8>, flip b : UInt<8>, product : SInt<16>} @[src/main/scala/regular/RegularBooth8NoBRC.scala 12:14]

    node a_signed = asSInt(io.a) @[src/main/scala/regular/RegularBooth8NoBRC.scala 18:23]
    node b_signed = asSInt(io.b) @[src/main/scala/regular/RegularBooth8NoBRC.scala 19:23]
    node a_is_zero = eq(io.a, UInt<1>("h0")) @[src/main/scala/regular/RegularBooth8NoBRC.scala 20:24]
    node b_extended = cat(io.b, UInt<1>("h0")) @[src/main/scala/regular/RegularBooth8NoBRC.scala 21:23]
    inst encoders_0 of RegularEncoder @[src/main/scala/regular/RegularBooth8NoBRC.scala 23:45]
    encoders_0.clock <= clock
    encoders_0.reset <= reset
    inst encoders_1 of RegularEncoder_1 @[src/main/scala/regular/RegularBooth8NoBRC.scala 23:45]
    encoders_1.clock <= clock
    encoders_1.reset <= reset
    inst encoders_2 of RegularEncoder_2 @[src/main/scala/regular/RegularBooth8NoBRC.scala 23:45]
    encoders_2.clock <= clock
    encoders_2.reset <= reset
    inst encoders_3 of RegularEncoder_3 @[src/main/scala/regular/RegularBooth8NoBRC.scala 23:45]
    encoders_3.clock <= clock
    encoders_3.reset <= reset
    node _encoders_0_io_b_bits_T = bits(b_extended, 2, 0) @[src/main/scala/regular/RegularBooth8NoBRC.scala 25:40]
    encoders_0.io.b_bits <= _encoders_0_io_b_bits_T @[src/main/scala/regular/RegularBooth8NoBRC.scala 25:27]
    node _encoders_1_io_b_bits_T = bits(b_extended, 4, 2) @[src/main/scala/regular/RegularBooth8NoBRC.scala 25:40]
    encoders_1.io.b_bits <= _encoders_1_io_b_bits_T @[src/main/scala/regular/RegularBooth8NoBRC.scala 25:27]
    node _encoders_2_io_b_bits_T = bits(b_extended, 6, 4) @[src/main/scala/regular/RegularBooth8NoBRC.scala 25:40]
    encoders_2.io.b_bits <= _encoders_2_io_b_bits_T @[src/main/scala/regular/RegularBooth8NoBRC.scala 25:27]
    node _encoders_3_io_b_bits_T = bits(b_extended, 8, 6) @[src/main/scala/regular/RegularBooth8NoBRC.scala 25:40]
    encoders_3.io.b_bits <= _encoders_3_io_b_bits_T @[src/main/scala/regular/RegularBooth8NoBRC.scala 25:27]
    wire partial_products : SInt<18>[4] @[src/main/scala/regular/RegularBooth8NoBRC.scala 28:30]
    node row_is_zero = or(encoders_0.io.zero, a_is_zero) @[src/main/scala/regular/RegularBooth8NoBRC.scala 34:28]
    wire a_ext : SInt<18> @[src/main/scala/regular/RegularBooth8NoBRC.scala 35:21]
    a_ext <= a_signed @[src/main/scala/regular/RegularBooth8NoBRC.scala 36:11]
    node _pp_base_T = shl(a_ext, 1) @[src/main/scala/regular/RegularBooth8NoBRC.scala 37:34]
    node pp_base = mux(encoders_0.io.two, _pp_base_T, a_ext) @[src/main/scala/regular/RegularBooth8NoBRC.scala 37:22]
    node _pp_signed_T = sub(asSInt(UInt<1>("h0")), pp_base) @[src/main/scala/regular/RegularBooth8NoBRC.scala 38:30]
    node _pp_signed_T_1 = tail(_pp_signed_T, 1) @[src/main/scala/regular/RegularBooth8NoBRC.scala 38:30]
    node _pp_signed_T_2 = asSInt(_pp_signed_T_1) @[src/main/scala/regular/RegularBooth8NoBRC.scala 38:30]
    node pp_signed = mux(encoders_0.io.neg, _pp_signed_T_2, pp_base) @[src/main/scala/regular/RegularBooth8NoBRC.scala 38:24]
    node pp_gated = mux(row_is_zero, asSInt(UInt<18>("h0")), pp_signed) @[src/main/scala/regular/RegularBooth8NoBRC.scala 39:23]
    node _partial_products_0_T = shl(pp_gated, 0) @[src/main/scala/regular/RegularBooth8NoBRC.scala 40:37]
    partial_products[0] <= _partial_products_0_T @[src/main/scala/regular/RegularBooth8NoBRC.scala 40:25]
    node row_is_zero_1 = or(encoders_1.io.zero, a_is_zero) @[src/main/scala/regular/RegularBooth8NoBRC.scala 34:28]
    wire a_ext_1 : SInt<18> @[src/main/scala/regular/RegularBooth8NoBRC.scala 35:21]
    a_ext_1 <= a_signed @[src/main/scala/regular/RegularBooth8NoBRC.scala 36:11]
    node _pp_base_T_1 = shl(a_ext_1, 1) @[src/main/scala/regular/RegularBooth8NoBRC.scala 37:34]
    node pp_base_1 = mux(encoders_1.io.two, _pp_base_T_1, a_ext_1) @[src/main/scala/regular/RegularBooth8NoBRC.scala 37:22]
    node _pp_signed_T_3 = sub(asSInt(UInt<1>("h0")), pp_base_1) @[src/main/scala/regular/RegularBooth8NoBRC.scala 38:30]
    node _pp_signed_T_4 = tail(_pp_signed_T_3, 1) @[src/main/scala/regular/RegularBooth8NoBRC.scala 38:30]
    node _pp_signed_T_5 = asSInt(_pp_signed_T_4) @[src/main/scala/regular/RegularBooth8NoBRC.scala 38:30]
    node pp_signed_1 = mux(encoders_1.io.neg, _pp_signed_T_5, pp_base_1) @[src/main/scala/regular/RegularBooth8NoBRC.scala 38:24]
    node pp_gated_1 = mux(row_is_zero_1, asSInt(UInt<18>("h0")), pp_signed_1) @[src/main/scala/regular/RegularBooth8NoBRC.scala 39:23]
    node _partial_products_1_T = shl(pp_gated_1, 2) @[src/main/scala/regular/RegularBooth8NoBRC.scala 40:37]
    partial_products[1] <= _partial_products_1_T @[src/main/scala/regular/RegularBooth8NoBRC.scala 40:25]
    node row_is_zero_2 = or(encoders_2.io.zero, a_is_zero) @[src/main/scala/regular/RegularBooth8NoBRC.scala 34:28]
    wire a_ext_2 : SInt<18> @[src/main/scala/regular/RegularBooth8NoBRC.scala 35:21]
    a_ext_2 <= a_signed @[src/main/scala/regular/RegularBooth8NoBRC.scala 36:11]
    node _pp_base_T_2 = shl(a_ext_2, 1) @[src/main/scala/regular/RegularBooth8NoBRC.scala 37:34]
    node pp_base_2 = mux(encoders_2.io.two, _pp_base_T_2, a_ext_2) @[src/main/scala/regular/RegularBooth8NoBRC.scala 37:22]
    node _pp_signed_T_6 = sub(asSInt(UInt<1>("h0")), pp_base_2) @[src/main/scala/regular/RegularBooth8NoBRC.scala 38:30]
    node _pp_signed_T_7 = tail(_pp_signed_T_6, 1) @[src/main/scala/regular/RegularBooth8NoBRC.scala 38:30]
    node _pp_signed_T_8 = asSInt(_pp_signed_T_7) @[src/main/scala/regular/RegularBooth8NoBRC.scala 38:30]
    node pp_signed_2 = mux(encoders_2.io.neg, _pp_signed_T_8, pp_base_2) @[src/main/scala/regular/RegularBooth8NoBRC.scala 38:24]
    node pp_gated_2 = mux(row_is_zero_2, asSInt(UInt<18>("h0")), pp_signed_2) @[src/main/scala/regular/RegularBooth8NoBRC.scala 39:23]
    node _partial_products_2_T = shl(pp_gated_2, 4) @[src/main/scala/regular/RegularBooth8NoBRC.scala 40:37]
    partial_products[2] <= _partial_products_2_T @[src/main/scala/regular/RegularBooth8NoBRC.scala 40:25]
    node row_is_zero_3 = or(encoders_3.io.zero, a_is_zero) @[src/main/scala/regular/RegularBooth8NoBRC.scala 34:28]
    wire a_ext_3 : SInt<18> @[src/main/scala/regular/RegularBooth8NoBRC.scala 35:21]
    a_ext_3 <= a_signed @[src/main/scala/regular/RegularBooth8NoBRC.scala 36:11]
    node _pp_base_T_3 = shl(a_ext_3, 1) @[src/main/scala/regular/RegularBooth8NoBRC.scala 37:34]
    node pp_base_3 = mux(encoders_3.io.two, _pp_base_T_3, a_ext_3) @[src/main/scala/regular/RegularBooth8NoBRC.scala 37:22]
    node _pp_signed_T_9 = sub(asSInt(UInt<1>("h0")), pp_base_3) @[src/main/scala/regular/RegularBooth8NoBRC.scala 38:30]
    node _pp_signed_T_10 = tail(_pp_signed_T_9, 1) @[src/main/scala/regular/RegularBooth8NoBRC.scala 38:30]
    node _pp_signed_T_11 = asSInt(_pp_signed_T_10) @[src/main/scala/regular/RegularBooth8NoBRC.scala 38:30]
    node pp_signed_3 = mux(encoders_3.io.neg, _pp_signed_T_11, pp_base_3) @[src/main/scala/regular/RegularBooth8NoBRC.scala 38:24]
    node pp_gated_3 = mux(row_is_zero_3, asSInt(UInt<18>("h0")), pp_signed_3) @[src/main/scala/regular/RegularBooth8NoBRC.scala 39:23]
    node _partial_products_3_T = shl(pp_gated_3, 6) @[src/main/scala/regular/RegularBooth8NoBRC.scala 40:37]
    partial_products[3] <= _partial_products_3_T @[src/main/scala/regular/RegularBooth8NoBRC.scala 40:25]
    node _sum_T = add(partial_products[0], partial_products[1]) @[src/main/scala/regular/RegularBooth8NoBRC.scala 44:33]
    node _sum_T_1 = tail(_sum_T, 1) @[src/main/scala/regular/RegularBooth8NoBRC.scala 44:33]
    node _sum_T_2 = asSInt(_sum_T_1) @[src/main/scala/regular/RegularBooth8NoBRC.scala 44:33]
    node _sum_T_3 = add(_sum_T_2, partial_products[2]) @[src/main/scala/regular/RegularBooth8NoBRC.scala 44:55]
    node _sum_T_4 = tail(_sum_T_3, 1) @[src/main/scala/regular/RegularBooth8NoBRC.scala 44:55]
    node _sum_T_5 = asSInt(_sum_T_4) @[src/main/scala/regular/RegularBooth8NoBRC.scala 44:55]
    node _sum_T_6 = add(_sum_T_5, partial_products[3]) @[src/main/scala/regular/RegularBooth8NoBRC.scala 45:33]
    node _sum_T_7 = tail(_sum_T_6, 1) @[src/main/scala/regular/RegularBooth8NoBRC.scala 45:33]
    node sum = asSInt(_sum_T_7) @[src/main/scala/regular/RegularBooth8NoBRC.scala 45:33]
    node _io_product_T = bits(sum, 15, 0) @[src/main/scala/regular/RegularBooth8NoBRC.scala 47:20]
    node _io_product_T_1 = asSInt(_io_product_T) @[src/main/scala/regular/RegularBooth8NoBRC.scala 47:28]
    io.product <= _io_product_T_1 @[src/main/scala/regular/RegularBooth8NoBRC.scala 47:14]

