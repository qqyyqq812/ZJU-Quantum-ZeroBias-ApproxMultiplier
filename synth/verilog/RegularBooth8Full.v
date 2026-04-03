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
module RegularBooth8Full(
  input         clock,
  input         reset,
  input  [7:0]  io_a, // @[src/main/scala/regular/RegularBooth8Full.scala 17:14]
  input  [7:0]  io_b, // @[src/main/scala/regular/RegularBooth8Full.scala 17:14]
  output [15:0] io_product // @[src/main/scala/regular/RegularBooth8Full.scala 17:14]
);
  wire [2:0] encoders_0_io_b_bits; // @[src/main/scala/regular/RegularBooth8Full.scala 28:45]
  wire  encoders_0_io_neg; // @[src/main/scala/regular/RegularBooth8Full.scala 28:45]
  wire  encoders_0_io_zero; // @[src/main/scala/regular/RegularBooth8Full.scala 28:45]
  wire [2:0] encoders_1_io_b_bits; // @[src/main/scala/regular/RegularBooth8Full.scala 28:45]
  wire  encoders_1_io_neg; // @[src/main/scala/regular/RegularBooth8Full.scala 28:45]
  wire  encoders_1_io_zero; // @[src/main/scala/regular/RegularBooth8Full.scala 28:45]
  wire [2:0] encoders_2_io_b_bits; // @[src/main/scala/regular/RegularBooth8Full.scala 28:45]
  wire  encoders_2_io_neg; // @[src/main/scala/regular/RegularBooth8Full.scala 28:45]
  wire  encoders_2_io_zero; // @[src/main/scala/regular/RegularBooth8Full.scala 28:45]
  wire  encoders_2_io_two; // @[src/main/scala/regular/RegularBooth8Full.scala 28:45]
  wire [2:0] encoders_3_io_b_bits; // @[src/main/scala/regular/RegularBooth8Full.scala 28:45]
  wire  encoders_3_io_neg; // @[src/main/scala/regular/RegularBooth8Full.scala 28:45]
  wire  encoders_3_io_zero; // @[src/main/scala/regular/RegularBooth8Full.scala 28:45]
  wire  encoders_3_io_two; // @[src/main/scala/regular/RegularBooth8Full.scala 28:45]
  wire [7:0] a_signed = io_a; // @[src/main/scala/regular/RegularBooth8Full.scala 23:23]
  wire  a_is_zero = io_a == 8'h0; // @[src/main/scala/regular/RegularBooth8Full.scala 24:24]
  wire [8:0] b_extended = {io_b,1'h0}; // @[src/main/scala/regular/RegularBooth8Full.scala 25:23]
  wire [8:0] a_ext9 = {{1{a_signed[7]}},a_signed}; // @[src/main/scala/regular/RegularBooth8Full.scala 40:28]
  wire  row_is_zero = encoders_0_io_zero | a_is_zero; // @[src/main/scala/regular/RegularBooth8Full.scala 46:28]
  wire  neg_bits_0 = row_is_zero ? 1'h0 : encoders_0_io_neg; // @[src/main/scala/regular/RegularBooth8Full.scala 48:23]
  wire [9:0] _pp_base_T = {$signed(a_ext9), 1'h0}; // @[src/main/scala/regular/RegularBooth8Full.scala 51:35]
  wire [9:0] pp_base = {{1{a_ext9[8]}},a_ext9}; // @[src/main/scala/regular/RegularBooth8Full.scala 51:22]
  wire [9:0] _pp_inv_T_1 = ~pp_base; // @[src/main/scala/regular/RegularBooth8Full.scala 54:27]
  wire [9:0] pp_inv = encoders_0_io_neg ? $signed(_pp_inv_T_1) : $signed(pp_base); // @[src/main/scala/regular/RegularBooth8Full.scala 54:21]
  wire [17:0] _pp_val_T = {{8{pp_inv[9]}},pp_inv}; // @[src/main/scala/regular/RegularBooth8Full.scala 57:56]
  wire [17:0] rows_0 = row_is_zero ? $signed(18'sh0) : $signed(_pp_val_T); // @[src/main/scala/regular/RegularBooth8Full.scala 60:36]
  wire  row_is_zero_1 = encoders_1_io_zero | a_is_zero; // @[src/main/scala/regular/RegularBooth8Full.scala 46:28]
  wire  neg_bits_1 = row_is_zero_1 ? 1'h0 : encoders_1_io_neg; // @[src/main/scala/regular/RegularBooth8Full.scala 48:23]
  wire [9:0] pp_inv_1 = encoders_1_io_neg ? $signed(_pp_inv_T_1) : $signed(pp_base); // @[src/main/scala/regular/RegularBooth8Full.scala 54:21]
  wire [17:0] _pp_val_T_1 = {{8{pp_inv_1[9]}},pp_inv_1}; // @[src/main/scala/regular/RegularBooth8Full.scala 57:56]
  wire [17:0] pp_val_1 = row_is_zero_1 ? $signed(18'sh0) : $signed(_pp_val_T_1); // @[src/main/scala/regular/RegularBooth8Full.scala 57:21]
  wire [19:0] _rows_1_T_1 = {$signed(pp_val_1), 2'h0}; // @[src/main/scala/regular/RegularBooth8Full.scala 60:36]
  wire  row_is_zero_2 = encoders_2_io_zero | a_is_zero; // @[src/main/scala/regular/RegularBooth8Full.scala 46:28]
  wire  neg_bits_2 = row_is_zero_2 ? 1'h0 : encoders_2_io_neg; // @[src/main/scala/regular/RegularBooth8Full.scala 48:23]
  wire [9:0] pp_base_2 = encoders_2_io_two ? $signed(_pp_base_T) : $signed({{1{a_ext9[8]}},a_ext9}); // @[src/main/scala/regular/RegularBooth8Full.scala 51:22]
  wire [9:0] _pp_inv_T_5 = ~pp_base_2; // @[src/main/scala/regular/RegularBooth8Full.scala 54:27]
  wire [9:0] pp_inv_2 = encoders_2_io_neg ? $signed(_pp_inv_T_5) : $signed(pp_base_2); // @[src/main/scala/regular/RegularBooth8Full.scala 54:21]
  wire [17:0] _pp_val_T_2 = {{8{pp_inv_2[9]}},pp_inv_2}; // @[src/main/scala/regular/RegularBooth8Full.scala 57:56]
  wire [17:0] pp_val_2 = row_is_zero_2 ? $signed(18'sh0) : $signed(_pp_val_T_2); // @[src/main/scala/regular/RegularBooth8Full.scala 57:21]
  wire [21:0] _rows_2_T_1 = {$signed(pp_val_2), 4'h0}; // @[src/main/scala/regular/RegularBooth8Full.scala 60:36]
  wire  row_is_zero_3 = encoders_3_io_zero | a_is_zero; // @[src/main/scala/regular/RegularBooth8Full.scala 46:28]
  wire  neg_bits_3 = row_is_zero_3 ? 1'h0 : encoders_3_io_neg; // @[src/main/scala/regular/RegularBooth8Full.scala 48:23]
  wire [9:0] pp_base_3 = encoders_3_io_two ? $signed(_pp_base_T) : $signed({{1{a_ext9[8]}},a_ext9}); // @[src/main/scala/regular/RegularBooth8Full.scala 51:22]
  wire [9:0] _pp_inv_T_7 = ~pp_base_3; // @[src/main/scala/regular/RegularBooth8Full.scala 54:27]
  wire [9:0] pp_inv_3 = encoders_3_io_neg ? $signed(_pp_inv_T_7) : $signed(pp_base_3); // @[src/main/scala/regular/RegularBooth8Full.scala 54:21]
  wire [17:0] _pp_val_T_3 = {{8{pp_inv_3[9]}},pp_inv_3}; // @[src/main/scala/regular/RegularBooth8Full.scala 57:56]
  wire [17:0] pp_val_3 = row_is_zero_3 ? $signed(18'sh0) : $signed(_pp_val_T_3); // @[src/main/scala/regular/RegularBooth8Full.scala 57:21]
  wire [23:0] _rows_3_T_1 = {$signed(pp_val_3), 6'h0}; // @[src/main/scala/regular/RegularBooth8Full.scala 60:36]
  wire [17:0] rows_1 = _rows_1_T_1[17:0]; // @[src/main/scala/regular/RegularBooth8Full.scala 37:18 60:13]
  wire [17:0] _GEN_0 = {{17'd0}, neg_bits_0}; // @[src/main/scala/regular/RegularBooth8Full.scala 69:20]
  wire [17:0] r1 = rows_1 | _GEN_0; // @[src/main/scala/regular/RegularBooth8Full.scala 69:20]
  wire [2:0] _r2_T = {neg_bits_1, 2'h0}; // @[src/main/scala/regular/RegularBooth8Full.scala 70:42]
  wire [17:0] rows_2 = _rows_2_T_1[17:0]; // @[src/main/scala/regular/RegularBooth8Full.scala 37:18 60:13]
  wire [17:0] _GEN_1 = {{15'd0}, _r2_T}; // @[src/main/scala/regular/RegularBooth8Full.scala 70:20]
  wire [17:0] r2 = rows_2 | _GEN_1; // @[src/main/scala/regular/RegularBooth8Full.scala 70:20]
  wire [4:0] _r3_T = {neg_bits_2, 4'h0}; // @[src/main/scala/regular/RegularBooth8Full.scala 71:42]
  wire [17:0] rows_3 = _rows_3_T_1[17:0]; // @[src/main/scala/regular/RegularBooth8Full.scala 37:18 60:13]
  wire [17:0] _GEN_2 = {{13'd0}, _r3_T}; // @[src/main/scala/regular/RegularBooth8Full.scala 71:20]
  wire [17:0] r3 = rows_3 | _GEN_2; // @[src/main/scala/regular/RegularBooth8Full.scala 71:20]
  wire [6:0] n3 = {neg_bits_3, 6'h0}; // @[src/main/scala/regular/RegularBooth8Full.scala 72:31]
  wire  row0_is_100 = b_extended[2:0] == 3'h4; // @[src/main/scala/regular/RegularBooth8Full.scala 77:38]
  wire [17:0] _barc_T_2 = {{10{a_signed[7]}},a_signed}; // @[src/main/scala/regular/RegularBooth8Full.scala 78:59]
  wire [17:0] _barc_T_6 = 18'sh0 - $signed(_barc_T_2); // @[src/main/scala/regular/RegularBooth8Full.scala 78:65]
  wire [17:0] barc = row0_is_100 & ~a_is_zero ? _barc_T_6 : 18'h0; // @[src/main/scala/regular/RegularBooth8Full.scala 78:17]
  wire [17:0] _sum_T_1 = rows_0 + r1; // @[src/main/scala/regular/RegularBooth8Full.scala 83:16]
  wire [17:0] _sum_T_3 = _sum_T_1 + r2; // @[src/main/scala/regular/RegularBooth8Full.scala 83:21]
  wire [17:0] _sum_T_5 = _sum_T_3 + r3; // @[src/main/scala/regular/RegularBooth8Full.scala 83:26]
  wire [17:0] _GEN_3 = {{11'd0}, n3}; // @[src/main/scala/regular/RegularBooth8Full.scala 83:31]
  wire [17:0] _sum_T_7 = _sum_T_5 + _GEN_3; // @[src/main/scala/regular/RegularBooth8Full.scala 83:31]
  wire [17:0] sum = _sum_T_7 + barc; // @[src/main/scala/regular/RegularBooth8Full.scala 83:36]
  RegularEncoder encoders_0 ( // @[src/main/scala/regular/RegularBooth8Full.scala 28:45]
    .io_b_bits(encoders_0_io_b_bits),
    .io_neg(encoders_0_io_neg),
    .io_zero(encoders_0_io_zero)
  );
  RegularEncoder encoders_1 ( // @[src/main/scala/regular/RegularBooth8Full.scala 28:45]
    .io_b_bits(encoders_1_io_b_bits),
    .io_neg(encoders_1_io_neg),
    .io_zero(encoders_1_io_zero)
  );
  RegularEncoder_2 encoders_2 ( // @[src/main/scala/regular/RegularBooth8Full.scala 28:45]
    .io_b_bits(encoders_2_io_b_bits),
    .io_neg(encoders_2_io_neg),
    .io_zero(encoders_2_io_zero),
    .io_two(encoders_2_io_two)
  );
  RegularEncoder_2 encoders_3 ( // @[src/main/scala/regular/RegularBooth8Full.scala 28:45]
    .io_b_bits(encoders_3_io_b_bits),
    .io_neg(encoders_3_io_neg),
    .io_zero(encoders_3_io_zero),
    .io_two(encoders_3_io_two)
  );
  assign io_product = sum[15:0]; // @[src/main/scala/regular/RegularBooth8Full.scala 85:28]
  assign encoders_0_io_b_bits = b_extended[2:0]; // @[src/main/scala/regular/RegularBooth8Full.scala 30:40]
  assign encoders_1_io_b_bits = b_extended[4:2]; // @[src/main/scala/regular/RegularBooth8Full.scala 30:40]
  assign encoders_2_io_b_bits = b_extended[6:4]; // @[src/main/scala/regular/RegularBooth8Full.scala 30:40]
  assign encoders_3_io_b_bits = b_extended[8:6]; // @[src/main/scala/regular/RegularBooth8Full.scala 30:40]
endmodule
