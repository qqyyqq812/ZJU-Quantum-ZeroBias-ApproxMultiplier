module RegularEncoder(
  input  [2:0] io_b_bits, // @[src/main/scala/regular/RegularBooth8.scala 14:14]
  output       io_neg, // @[src/main/scala/regular/RegularBooth8.scala 14:14]
  output       io_zero // @[src/main/scala/regular/RegularBooth8.scala 14:14]
);
  assign io_neg = io_b_bits[2]; // @[src/main/scala/regular/RegularBooth8.scala 21:22]
  assign io_zero = io_b_bits == 3'h0 | io_b_bits == 3'h7; // @[src/main/scala/regular/RegularBooth8.scala 22:34]
endmodule
module RegularEncoder_2(
  input  [2:0] io_b_bits, // @[src/main/scala/regular/RegularBooth8.scala 14:14]
  output       io_neg, // @[src/main/scala/regular/RegularBooth8.scala 14:14]
  output       io_zero, // @[src/main/scala/regular/RegularBooth8.scala 14:14]
  output       io_two // @[src/main/scala/regular/RegularBooth8.scala 14:14]
);
  assign io_neg = io_b_bits[2]; // @[src/main/scala/regular/RegularBooth8.scala 21:22]
  assign io_zero = io_b_bits == 3'h0 | io_b_bits == 3'h7; // @[src/main/scala/regular/RegularBooth8.scala 22:34]
  assign io_two = io_b_bits == 3'h3 | io_b_bits == 3'h4; // @[src/main/scala/regular/RegularBooth8.scala 27:35]
endmodule
module RegularBooth8(
  input         clock,
  input         reset,
  input  [7:0]  io_a, // @[src/main/scala/regular/RegularBooth8.scala 35:14]
  input  [7:0]  io_b, // @[src/main/scala/regular/RegularBooth8.scala 35:14]
  output [15:0] io_product // @[src/main/scala/regular/RegularBooth8.scala 35:14]
);
  wire [2:0] encoders_0_io_b_bits; // @[src/main/scala/regular/RegularBooth8.scala 54:45]
  wire  encoders_0_io_neg; // @[src/main/scala/regular/RegularBooth8.scala 54:45]
  wire  encoders_0_io_zero; // @[src/main/scala/regular/RegularBooth8.scala 54:45]
  wire [2:0] encoders_1_io_b_bits; // @[src/main/scala/regular/RegularBooth8.scala 54:45]
  wire  encoders_1_io_neg; // @[src/main/scala/regular/RegularBooth8.scala 54:45]
  wire  encoders_1_io_zero; // @[src/main/scala/regular/RegularBooth8.scala 54:45]
  wire [2:0] encoders_2_io_b_bits; // @[src/main/scala/regular/RegularBooth8.scala 54:45]
  wire  encoders_2_io_neg; // @[src/main/scala/regular/RegularBooth8.scala 54:45]
  wire  encoders_2_io_zero; // @[src/main/scala/regular/RegularBooth8.scala 54:45]
  wire  encoders_2_io_two; // @[src/main/scala/regular/RegularBooth8.scala 54:45]
  wire [2:0] encoders_3_io_b_bits; // @[src/main/scala/regular/RegularBooth8.scala 54:45]
  wire  encoders_3_io_neg; // @[src/main/scala/regular/RegularBooth8.scala 54:45]
  wire  encoders_3_io_zero; // @[src/main/scala/regular/RegularBooth8.scala 54:45]
  wire  encoders_3_io_two; // @[src/main/scala/regular/RegularBooth8.scala 54:45]
  wire [7:0] a_signed = io_a; // @[src/main/scala/regular/RegularBooth8.scala 44:23]
  wire  a_is_zero = io_a == 8'h0; // @[src/main/scala/regular/RegularBooth8.scala 48:24]
  wire [8:0] b_extended = {io_b,1'h0}; // @[src/main/scala/regular/RegularBooth8.scala 53:23]
  wire  row_is_zero = encoders_0_io_zero | a_is_zero; // @[src/main/scala/regular/RegularBooth8.scala 74:28]
  wire [17:0] a_ext = {{10{a_signed[7]}},a_signed}; // @[src/main/scala/regular/RegularBooth8.scala 78:21 79:11]
  wire [18:0] _pp_base_T = {$signed(a_ext), 1'h0}; // @[src/main/scala/regular/RegularBooth8.scala 82:34]
  wire [18:0] pp_base = {{1{a_ext[17]}},a_ext}; // @[src/main/scala/regular/RegularBooth8.scala 82:22]
  wire [18:0] _pp_signed_T_2 = 19'sh0 - $signed(pp_base); // @[src/main/scala/regular/RegularBooth8.scala 85:30]
  wire [18:0] pp_signed = encoders_0_io_neg ? $signed(_pp_signed_T_2) : $signed(pp_base); // @[src/main/scala/regular/RegularBooth8.scala 85:24]
  wire [18:0] pp_gated = row_is_zero ? $signed(19'sh0) : $signed(pp_signed); // @[src/main/scala/regular/RegularBooth8.scala 88:23]
  wire  row_is_zero_1 = encoders_1_io_zero | a_is_zero; // @[src/main/scala/regular/RegularBooth8.scala 74:28]
  wire [18:0] pp_signed_1 = encoders_1_io_neg ? $signed(_pp_signed_T_2) : $signed(pp_base); // @[src/main/scala/regular/RegularBooth8.scala 85:24]
  wire [18:0] pp_gated_1 = row_is_zero_1 ? $signed(19'sh0) : $signed(pp_signed_1); // @[src/main/scala/regular/RegularBooth8.scala 88:23]
  wire [20:0] _partial_products_1_T = {$signed(pp_gated_1), 2'h0}; // @[src/main/scala/regular/RegularBooth8.scala 91:37]
  wire  row_is_zero_2 = encoders_2_io_zero | a_is_zero; // @[src/main/scala/regular/RegularBooth8.scala 74:28]
  wire [18:0] pp_base_2 = encoders_2_io_two ? $signed(_pp_base_T) : $signed({{1{a_ext[17]}},a_ext}); // @[src/main/scala/regular/RegularBooth8.scala 82:22]
  wire [18:0] _pp_signed_T_8 = 19'sh0 - $signed(pp_base_2); // @[src/main/scala/regular/RegularBooth8.scala 85:30]
  wire [18:0] pp_signed_2 = encoders_2_io_neg ? $signed(_pp_signed_T_8) : $signed(pp_base_2); // @[src/main/scala/regular/RegularBooth8.scala 85:24]
  wire [18:0] pp_gated_2 = row_is_zero_2 ? $signed(19'sh0) : $signed(pp_signed_2); // @[src/main/scala/regular/RegularBooth8.scala 88:23]
  wire [22:0] _partial_products_2_T = {$signed(pp_gated_2), 4'h0}; // @[src/main/scala/regular/RegularBooth8.scala 91:37]
  wire  row_is_zero_3 = encoders_3_io_zero | a_is_zero; // @[src/main/scala/regular/RegularBooth8.scala 74:28]
  wire [18:0] pp_base_3 = encoders_3_io_two ? $signed(_pp_base_T) : $signed({{1{a_ext[17]}},a_ext}); // @[src/main/scala/regular/RegularBooth8.scala 82:22]
  wire [18:0] _pp_signed_T_11 = 19'sh0 - $signed(pp_base_3); // @[src/main/scala/regular/RegularBooth8.scala 85:30]
  wire [18:0] pp_signed_3 = encoders_3_io_neg ? $signed(_pp_signed_T_11) : $signed(pp_base_3); // @[src/main/scala/regular/RegularBooth8.scala 85:24]
  wire [18:0] pp_gated_3 = row_is_zero_3 ? $signed(19'sh0) : $signed(pp_signed_3); // @[src/main/scala/regular/RegularBooth8.scala 88:23]
  wire [24:0] _partial_products_3_T = {$signed(pp_gated_3), 6'h0}; // @[src/main/scala/regular/RegularBooth8.scala 91:37]
  wire  row0_is_100 = b_extended[2:0] == 3'h4; // @[src/main/scala/regular/RegularBooth8.scala 97:38]
  wire [17:0] _barc_T_5 = 18'sh0 - $signed(a_ext); // @[src/main/scala/regular/RegularBooth8.scala 100:18]
  wire [17:0] barc = row0_is_100 & ~a_is_zero ? $signed(_barc_T_5) : $signed(18'sh0); // @[src/main/scala/regular/RegularBooth8.scala 99:17]
  wire [17:0] partial_products_0 = pp_gated[17:0]; // @[src/main/scala/regular/RegularBooth8.scala 66:30 91:25]
  wire [17:0] partial_products_1 = _partial_products_1_T[17:0]; // @[src/main/scala/regular/RegularBooth8.scala 66:30 91:25]
  wire [17:0] _sum_T_2 = $signed(partial_products_0) + $signed(partial_products_1); // @[src/main/scala/regular/RegularBooth8.scala 106:33]
  wire [17:0] partial_products_2 = _partial_products_2_T[17:0]; // @[src/main/scala/regular/RegularBooth8.scala 66:30 91:25]
  wire [17:0] _sum_T_5 = $signed(_sum_T_2) + $signed(partial_products_2); // @[src/main/scala/regular/RegularBooth8.scala 106:55]
  wire [17:0] partial_products_3 = _partial_products_3_T[17:0]; // @[src/main/scala/regular/RegularBooth8.scala 66:30 91:25]
  wire [17:0] _sum_T_8 = $signed(_sum_T_5) + $signed(partial_products_3); // @[src/main/scala/regular/RegularBooth8.scala 107:33]
  wire [17:0] sum = $signed(_sum_T_8) + $signed(barc); // @[src/main/scala/regular/RegularBooth8.scala 107:55]
  RegularEncoder encoders_0 ( // @[src/main/scala/regular/RegularBooth8.scala 54:45]
    .io_b_bits(encoders_0_io_b_bits),
    .io_neg(encoders_0_io_neg),
    .io_zero(encoders_0_io_zero)
  );
  RegularEncoder encoders_1 ( // @[src/main/scala/regular/RegularBooth8.scala 54:45]
    .io_b_bits(encoders_1_io_b_bits),
    .io_neg(encoders_1_io_neg),
    .io_zero(encoders_1_io_zero)
  );
  RegularEncoder_2 encoders_2 ( // @[src/main/scala/regular/RegularBooth8.scala 54:45]
    .io_b_bits(encoders_2_io_b_bits),
    .io_neg(encoders_2_io_neg),
    .io_zero(encoders_2_io_zero),
    .io_two(encoders_2_io_two)
  );
  RegularEncoder_2 encoders_3 ( // @[src/main/scala/regular/RegularBooth8.scala 54:45]
    .io_b_bits(encoders_3_io_b_bits),
    .io_neg(encoders_3_io_neg),
    .io_zero(encoders_3_io_zero),
    .io_two(encoders_3_io_two)
  );
  assign io_product = sum[15:0]; // @[src/main/scala/regular/RegularBooth8.scala 111:28]
  assign encoders_0_io_b_bits = b_extended[2:0]; // @[src/main/scala/regular/RegularBooth8.scala 57:40]
  assign encoders_1_io_b_bits = b_extended[4:2]; // @[src/main/scala/regular/RegularBooth8.scala 57:40]
  assign encoders_2_io_b_bits = b_extended[6:4]; // @[src/main/scala/regular/RegularBooth8.scala 57:40]
  assign encoders_3_io_b_bits = b_extended[8:6]; // @[src/main/scala/regular/RegularBooth8.scala 57:40]
endmodule
