FIRRTL version 1.2.0
circuit RegularBooth8Full :
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

  module RegularBooth8Full :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip a : UInt<8>, flip b : UInt<8>, product : SInt<16>} @[src/main/scala/regular/RegularBooth8Full.scala 17:14]

    node a_signed = asSInt(io.a) @[src/main/scala/regular/RegularBooth8Full.scala 23:23]
    node a_is_zero = eq(io.a, UInt<1>("h0")) @[src/main/scala/regular/RegularBooth8Full.scala 24:24]
    node b_extended = cat(io.b, UInt<1>("h0")) @[src/main/scala/regular/RegularBooth8Full.scala 25:23]
    inst encoders_0 of RegularEncoder @[src/main/scala/regular/RegularBooth8Full.scala 28:45]
    encoders_0.clock <= clock
    encoders_0.reset <= reset
    inst encoders_1 of RegularEncoder_1 @[src/main/scala/regular/RegularBooth8Full.scala 28:45]
    encoders_1.clock <= clock
    encoders_1.reset <= reset
    inst encoders_2 of RegularEncoder_2 @[src/main/scala/regular/RegularBooth8Full.scala 28:45]
    encoders_2.clock <= clock
    encoders_2.reset <= reset
    inst encoders_3 of RegularEncoder_3 @[src/main/scala/regular/RegularBooth8Full.scala 28:45]
    encoders_3.clock <= clock
    encoders_3.reset <= reset
    node _encoders_0_io_b_bits_T = bits(b_extended, 2, 0) @[src/main/scala/regular/RegularBooth8Full.scala 30:40]
    encoders_0.io.b_bits <= _encoders_0_io_b_bits_T @[src/main/scala/regular/RegularBooth8Full.scala 30:27]
    node _encoders_1_io_b_bits_T = bits(b_extended, 4, 2) @[src/main/scala/regular/RegularBooth8Full.scala 30:40]
    encoders_1.io.b_bits <= _encoders_1_io_b_bits_T @[src/main/scala/regular/RegularBooth8Full.scala 30:27]
    node _encoders_2_io_b_bits_T = bits(b_extended, 6, 4) @[src/main/scala/regular/RegularBooth8Full.scala 30:40]
    encoders_2.io.b_bits <= _encoders_2_io_b_bits_T @[src/main/scala/regular/RegularBooth8Full.scala 30:27]
    node _encoders_3_io_b_bits_T = bits(b_extended, 8, 6) @[src/main/scala/regular/RegularBooth8Full.scala 30:40]
    encoders_3.io.b_bits <= _encoders_3_io_b_bits_T @[src/main/scala/regular/RegularBooth8Full.scala 30:27]
    wire rows : UInt<18>[4] @[src/main/scala/regular/RegularBooth8Full.scala 37:18]
    wire neg_bits : UInt<1>[4] @[src/main/scala/regular/RegularBooth8Full.scala 38:22]
    node a_ext9 = pad(a_signed, 9) @[src/main/scala/regular/RegularBooth8Full.scala 40:28]
    node row_is_zero = or(encoders_0.io.zero, a_is_zero) @[src/main/scala/regular/RegularBooth8Full.scala 46:28]
    node _neg_bits_0_T = mux(row_is_zero, UInt<1>("h0"), encoders_0.io.neg) @[src/main/scala/regular/RegularBooth8Full.scala 48:23]
    neg_bits[0] <= _neg_bits_0_T @[src/main/scala/regular/RegularBooth8Full.scala 48:17]
    node _pp_base_T = shl(a_ext9, 1) @[src/main/scala/regular/RegularBooth8Full.scala 51:35]
    node pp_base = mux(encoders_0.io.two, _pp_base_T, a_ext9) @[src/main/scala/regular/RegularBooth8Full.scala 51:22]
    node _pp_inv_T = not(pp_base) @[src/main/scala/regular/RegularBooth8Full.scala 54:27]
    node _pp_inv_T_1 = asSInt(_pp_inv_T) @[src/main/scala/regular/RegularBooth8Full.scala 54:27]
    node pp_inv = mux(encoders_0.io.neg, _pp_inv_T_1, pp_base) @[src/main/scala/regular/RegularBooth8Full.scala 54:21]
    node _pp_val_T = pad(pp_inv, 18) @[src/main/scala/regular/RegularBooth8Full.scala 57:56]
    node pp_val = mux(row_is_zero, asSInt(UInt<18>("h0")), _pp_val_T) @[src/main/scala/regular/RegularBooth8Full.scala 57:21]
    node _rows_0_T = shl(pp_val, 0) @[src/main/scala/regular/RegularBooth8Full.scala 60:24]
    node _rows_0_T_1 = asUInt(_rows_0_T) @[src/main/scala/regular/RegularBooth8Full.scala 60:36]
    rows[0] <= _rows_0_T_1 @[src/main/scala/regular/RegularBooth8Full.scala 60:13]
    node row_is_zero_1 = or(encoders_1.io.zero, a_is_zero) @[src/main/scala/regular/RegularBooth8Full.scala 46:28]
    node _neg_bits_1_T = mux(row_is_zero_1, UInt<1>("h0"), encoders_1.io.neg) @[src/main/scala/regular/RegularBooth8Full.scala 48:23]
    neg_bits[1] <= _neg_bits_1_T @[src/main/scala/regular/RegularBooth8Full.scala 48:17]
    node _pp_base_T_1 = shl(a_ext9, 1) @[src/main/scala/regular/RegularBooth8Full.scala 51:35]
    node pp_base_1 = mux(encoders_1.io.two, _pp_base_T_1, a_ext9) @[src/main/scala/regular/RegularBooth8Full.scala 51:22]
    node _pp_inv_T_2 = not(pp_base_1) @[src/main/scala/regular/RegularBooth8Full.scala 54:27]
    node _pp_inv_T_3 = asSInt(_pp_inv_T_2) @[src/main/scala/regular/RegularBooth8Full.scala 54:27]
    node pp_inv_1 = mux(encoders_1.io.neg, _pp_inv_T_3, pp_base_1) @[src/main/scala/regular/RegularBooth8Full.scala 54:21]
    node _pp_val_T_1 = pad(pp_inv_1, 18) @[src/main/scala/regular/RegularBooth8Full.scala 57:56]
    node pp_val_1 = mux(row_is_zero_1, asSInt(UInt<18>("h0")), _pp_val_T_1) @[src/main/scala/regular/RegularBooth8Full.scala 57:21]
    node _rows_1_T = shl(pp_val_1, 2) @[src/main/scala/regular/RegularBooth8Full.scala 60:24]
    node _rows_1_T_1 = asUInt(_rows_1_T) @[src/main/scala/regular/RegularBooth8Full.scala 60:36]
    rows[1] <= _rows_1_T_1 @[src/main/scala/regular/RegularBooth8Full.scala 60:13]
    node row_is_zero_2 = or(encoders_2.io.zero, a_is_zero) @[src/main/scala/regular/RegularBooth8Full.scala 46:28]
    node _neg_bits_2_T = mux(row_is_zero_2, UInt<1>("h0"), encoders_2.io.neg) @[src/main/scala/regular/RegularBooth8Full.scala 48:23]
    neg_bits[2] <= _neg_bits_2_T @[src/main/scala/regular/RegularBooth8Full.scala 48:17]
    node _pp_base_T_2 = shl(a_ext9, 1) @[src/main/scala/regular/RegularBooth8Full.scala 51:35]
    node pp_base_2 = mux(encoders_2.io.two, _pp_base_T_2, a_ext9) @[src/main/scala/regular/RegularBooth8Full.scala 51:22]
    node _pp_inv_T_4 = not(pp_base_2) @[src/main/scala/regular/RegularBooth8Full.scala 54:27]
    node _pp_inv_T_5 = asSInt(_pp_inv_T_4) @[src/main/scala/regular/RegularBooth8Full.scala 54:27]
    node pp_inv_2 = mux(encoders_2.io.neg, _pp_inv_T_5, pp_base_2) @[src/main/scala/regular/RegularBooth8Full.scala 54:21]
    node _pp_val_T_2 = pad(pp_inv_2, 18) @[src/main/scala/regular/RegularBooth8Full.scala 57:56]
    node pp_val_2 = mux(row_is_zero_2, asSInt(UInt<18>("h0")), _pp_val_T_2) @[src/main/scala/regular/RegularBooth8Full.scala 57:21]
    node _rows_2_T = shl(pp_val_2, 4) @[src/main/scala/regular/RegularBooth8Full.scala 60:24]
    node _rows_2_T_1 = asUInt(_rows_2_T) @[src/main/scala/regular/RegularBooth8Full.scala 60:36]
    rows[2] <= _rows_2_T_1 @[src/main/scala/regular/RegularBooth8Full.scala 60:13]
    node row_is_zero_3 = or(encoders_3.io.zero, a_is_zero) @[src/main/scala/regular/RegularBooth8Full.scala 46:28]
    node _neg_bits_3_T = mux(row_is_zero_3, UInt<1>("h0"), encoders_3.io.neg) @[src/main/scala/regular/RegularBooth8Full.scala 48:23]
    neg_bits[3] <= _neg_bits_3_T @[src/main/scala/regular/RegularBooth8Full.scala 48:17]
    node _pp_base_T_3 = shl(a_ext9, 1) @[src/main/scala/regular/RegularBooth8Full.scala 51:35]
    node pp_base_3 = mux(encoders_3.io.two, _pp_base_T_3, a_ext9) @[src/main/scala/regular/RegularBooth8Full.scala 51:22]
    node _pp_inv_T_6 = not(pp_base_3) @[src/main/scala/regular/RegularBooth8Full.scala 54:27]
    node _pp_inv_T_7 = asSInt(_pp_inv_T_6) @[src/main/scala/regular/RegularBooth8Full.scala 54:27]
    node pp_inv_3 = mux(encoders_3.io.neg, _pp_inv_T_7, pp_base_3) @[src/main/scala/regular/RegularBooth8Full.scala 54:21]
    node _pp_val_T_3 = pad(pp_inv_3, 18) @[src/main/scala/regular/RegularBooth8Full.scala 57:56]
    node pp_val_3 = mux(row_is_zero_3, asSInt(UInt<18>("h0")), _pp_val_T_3) @[src/main/scala/regular/RegularBooth8Full.scala 57:21]
    node _rows_3_T = shl(pp_val_3, 6) @[src/main/scala/regular/RegularBooth8Full.scala 60:24]
    node _rows_3_T_1 = asUInt(_rows_3_T) @[src/main/scala/regular/RegularBooth8Full.scala 60:36]
    rows[3] <= _rows_3_T_1 @[src/main/scala/regular/RegularBooth8Full.scala 60:13]
    node r1 = or(rows[1], neg_bits[0]) @[src/main/scala/regular/RegularBooth8Full.scala 69:20]
    node _r2_T = shl(neg_bits[1], 2) @[src/main/scala/regular/RegularBooth8Full.scala 70:42]
    node r2 = or(rows[2], _r2_T) @[src/main/scala/regular/RegularBooth8Full.scala 70:20]
    node _r3_T = shl(neg_bits[2], 4) @[src/main/scala/regular/RegularBooth8Full.scala 71:42]
    node r3 = or(rows[3], _r3_T) @[src/main/scala/regular/RegularBooth8Full.scala 71:20]
    node n3 = shl(neg_bits[3], 6) @[src/main/scala/regular/RegularBooth8Full.scala 72:31]
    node _row0_is_100_T = bits(b_extended, 2, 0) @[src/main/scala/regular/RegularBooth8Full.scala 77:31]
    node row0_is_100 = eq(_row0_is_100_T, UInt<3>("h4")) @[src/main/scala/regular/RegularBooth8Full.scala 77:38]
    node _barc_T = eq(a_is_zero, UInt<1>("h0")) @[src/main/scala/regular/RegularBooth8Full.scala 78:33]
    node _barc_T_1 = and(row0_is_100, _barc_T) @[src/main/scala/regular/RegularBooth8Full.scala 78:30]
    node _barc_T_2 = pad(a_signed, 18) @[src/main/scala/regular/RegularBooth8Full.scala 78:59]
    node _barc_T_3 = sub(asSInt(UInt<1>("h0")), _barc_T_2) @[src/main/scala/regular/RegularBooth8Full.scala 78:46]
    node _barc_T_4 = tail(_barc_T_3, 1) @[src/main/scala/regular/RegularBooth8Full.scala 78:46]
    node _barc_T_5 = asSInt(_barc_T_4) @[src/main/scala/regular/RegularBooth8Full.scala 78:46]
    node _barc_T_6 = asUInt(_barc_T_5) @[src/main/scala/regular/RegularBooth8Full.scala 78:65]
    node barc = mux(_barc_T_1, _barc_T_6, UInt<18>("h0")) @[src/main/scala/regular/RegularBooth8Full.scala 78:17]
    node _sum_T = add(rows[0], r1) @[src/main/scala/regular/RegularBooth8Full.scala 83:16]
    node _sum_T_1 = tail(_sum_T, 1) @[src/main/scala/regular/RegularBooth8Full.scala 83:16]
    node _sum_T_2 = add(_sum_T_1, r2) @[src/main/scala/regular/RegularBooth8Full.scala 83:21]
    node _sum_T_3 = tail(_sum_T_2, 1) @[src/main/scala/regular/RegularBooth8Full.scala 83:21]
    node _sum_T_4 = add(_sum_T_3, r3) @[src/main/scala/regular/RegularBooth8Full.scala 83:26]
    node _sum_T_5 = tail(_sum_T_4, 1) @[src/main/scala/regular/RegularBooth8Full.scala 83:26]
    node _sum_T_6 = add(_sum_T_5, n3) @[src/main/scala/regular/RegularBooth8Full.scala 83:31]
    node _sum_T_7 = tail(_sum_T_6, 1) @[src/main/scala/regular/RegularBooth8Full.scala 83:31]
    node _sum_T_8 = add(_sum_T_7, barc) @[src/main/scala/regular/RegularBooth8Full.scala 83:36]
    node sum = tail(_sum_T_8, 1) @[src/main/scala/regular/RegularBooth8Full.scala 83:36]
    node _io_product_T = bits(sum, 15, 0) @[src/main/scala/regular/RegularBooth8Full.scala 85:20]
    node _io_product_T_1 = asSInt(_io_product_T) @[src/main/scala/regular/RegularBooth8Full.scala 85:28]
    io.product <= _io_product_T_1 @[src/main/scala/regular/RegularBooth8Full.scala 85:14]

