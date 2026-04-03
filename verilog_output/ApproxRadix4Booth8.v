module R4ABE2(
  input  [2:0] io_b_bits, // @[src/main/scala/empty/R4ABE2.scala 9:14]
  output       io_neg, // @[src/main/scala/empty/R4ABE2.scala 9:14]
  output [1:0] io_factor // @[src/main/scala/empty/R4ABE2.scala 9:14]
);
  wire  is_zero = io_b_bits == 3'h0 | io_b_bits == 3'h7; // @[src/main/scala/empty/R4ABE2.scala 36:37]
  assign io_neg = io_b_bits[2]; // @[src/main/scala/empty/R4ABE2.scala 18:29]
  assign io_factor = is_zero ? 2'h0 : 2'h1; // @[src/main/scala/empty/R4ABE2.scala 39:19]
endmodule
module PartialProductGenerator(
  input  [7:0] io_a, // @[src/main/scala/empty/PartialProductGenerator.scala 8:14]
  input        io_neg, // @[src/main/scala/empty/PartialProductGenerator.scala 8:14]
  input  [1:0] io_factor, // @[src/main/scala/empty/PartialProductGenerator.scala 8:14]
  output [9:0] io_partial_product // @[src/main/scala/empty/PartialProductGenerator.scala 8:14]
);
  wire [7:0] _magnitude_T_1 = io_factor == 2'h0 ? $signed(8'sh0) : $signed(io_a); // @[src/main/scala/empty/PartialProductGenerator.scala 19:19]
  wire [8:0] magnitude = {{1{_magnitude_T_1[7]}},_magnitude_T_1}; // @[src/main/scala/empty/PartialProductGenerator.scala 16:23 19:13]
  wire [8:0] _neg_result_T_1 = ~magnitude; // @[src/main/scala/empty/PartialProductGenerator.scala 23:21]
  wire [8:0] neg_result = $signed(_neg_result_T_1) + 9'sh1; // @[src/main/scala/empty/PartialProductGenerator.scala 23:40]
  wire [8:0] pp_9_bit = io_neg ? $signed(neg_result) : $signed(magnitude); // @[src/main/scala/empty/PartialProductGenerator.scala 27:21]
  wire [8:0] io_partial_product_lo = io_neg ? $signed(neg_result) : $signed(magnitude); // @[src/main/scala/empty/PartialProductGenerator.scala 28:28]
  assign io_partial_product = {pp_9_bit[8],io_partial_product_lo}; // @[src/main/scala/empty/PartialProductGenerator.scala 28:52]
endmodule
module ApproxWallaceTree(
  input  [15:0] io_shifted_partial_products_0, // @[src/main/scala/empty/ApproxWallaceTree.scala 9:14]
  input  [15:0] io_shifted_partial_products_1, // @[src/main/scala/empty/ApproxWallaceTree.scala 9:14]
  input  [15:0] io_shifted_partial_products_2, // @[src/main/scala/empty/ApproxWallaceTree.scala 9:14]
  input  [15:0] io_shifted_partial_products_3, // @[src/main/scala/empty/ApproxWallaceTree.scala 9:14]
  output [15:0] io_final_product // @[src/main/scala/empty/ApproxWallaceTree.scala 9:14]
);
  wire [16:0] _final_sum_T = $signed(io_shifted_partial_products_0) + $signed(io_shifted_partial_products_1); // @[src/main/scala/empty/ApproxWallaceTree.scala 19:60]
  wire [16:0] _final_sum_T_1 = $signed(io_shifted_partial_products_2) + $signed(io_shifted_partial_products_3); // @[src/main/scala/empty/ApproxWallaceTree.scala 19:60]
  wire [17:0] final_sum = $signed(_final_sum_T) + $signed(_final_sum_T_1); // @[src/main/scala/empty/ApproxWallaceTree.scala 19:60]
  assign io_final_product = final_sum[15:0]; // @[src/main/scala/empty/ApproxWallaceTree.scala 47:20]
endmodule
module ApproxRadix4Booth8(
  input         clock,
  input         reset,
  input  [7:0]  io_multiplicand, // @[src/main/scala/empty/ApproxRadix4Booth8.scala 8:14]
  input  [7:0]  io_multiplier, // @[src/main/scala/empty/ApproxRadix4Booth8.scala 8:14]
  output [15:0] io_product // @[src/main/scala/empty/ApproxRadix4Booth8.scala 8:14]
);
  wire [2:0] partial_products_list_booth_encoder_io_b_bits; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 28:31]
  wire  partial_products_list_booth_encoder_io_neg; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 28:31]
  wire [1:0] partial_products_list_booth_encoder_io_factor; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 28:31]
  wire [7:0] partial_products_list_ppg_io_a; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 32:21]
  wire  partial_products_list_ppg_io_neg; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 32:21]
  wire [1:0] partial_products_list_ppg_io_factor; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 32:21]
  wire [9:0] partial_products_list_ppg_io_partial_product; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 32:21]
  wire [2:0] partial_products_list_booth_encoder_1_io_b_bits; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 28:31]
  wire  partial_products_list_booth_encoder_1_io_neg; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 28:31]
  wire [1:0] partial_products_list_booth_encoder_1_io_factor; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 28:31]
  wire [7:0] partial_products_list_ppg_1_io_a; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 32:21]
  wire  partial_products_list_ppg_1_io_neg; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 32:21]
  wire [1:0] partial_products_list_ppg_1_io_factor; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 32:21]
  wire [9:0] partial_products_list_ppg_1_io_partial_product; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 32:21]
  wire [2:0] partial_products_list_booth_encoder_2_io_b_bits; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 28:31]
  wire  partial_products_list_booth_encoder_2_io_neg; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 28:31]
  wire [1:0] partial_products_list_booth_encoder_2_io_factor; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 28:31]
  wire [7:0] partial_products_list_ppg_2_io_a; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 32:21]
  wire  partial_products_list_ppg_2_io_neg; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 32:21]
  wire [1:0] partial_products_list_ppg_2_io_factor; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 32:21]
  wire [9:0] partial_products_list_ppg_2_io_partial_product; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 32:21]
  wire [2:0] partial_products_list_booth_encoder_3_io_b_bits; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 28:31]
  wire  partial_products_list_booth_encoder_3_io_neg; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 28:31]
  wire [1:0] partial_products_list_booth_encoder_3_io_factor; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 28:31]
  wire [7:0] partial_products_list_ppg_3_io_a; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 32:21]
  wire  partial_products_list_ppg_3_io_neg; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 32:21]
  wire [1:0] partial_products_list_ppg_3_io_factor; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 32:21]
  wire [9:0] partial_products_list_ppg_3_io_partial_product; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 32:21]
  wire [15:0] accumulator_io_shifted_partial_products_0; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 53:27]
  wire [15:0] accumulator_io_shifted_partial_products_1; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 53:27]
  wire [15:0] accumulator_io_shifted_partial_products_2; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 53:27]
  wire [15:0] accumulator_io_shifted_partial_products_3; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 53:27]
  wire [15:0] accumulator_io_final_product; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 53:27]
  wire [9:0] B_ext = {io_multiplier[7],io_multiplier,1'h0}; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 19:18]
  wire [9:0] _partial_products_list_pp_shifted_T = partial_products_list_ppg_io_partial_product; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 44:33]
  wire [10:0] _partial_products_list_pp_shifted_T_2 = {{1'd0}, _partial_products_list_pp_shifted_T}; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 44:57]
  wire [15:0] partial_products_list_0 = {{5{_partial_products_list_pp_shifted_T_2[10]}},
    _partial_products_list_pp_shifted_T_2}; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 44:67]
  wire [11:0] _GEN_0 = {partial_products_list_ppg_1_io_partial_product, 2'h0}; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 44:40]
  wire [12:0] _partial_products_list_pp_shifted_T_5 = {{1'd0}, _GEN_0}; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 44:57]
  wire [15:0] partial_products_list_1 = {{3{_partial_products_list_pp_shifted_T_5[12]}},
    _partial_products_list_pp_shifted_T_5}; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 44:67]
  wire [13:0] _GEN_1 = {partial_products_list_ppg_2_io_partial_product, 4'h0}; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 44:40]
  wire [16:0] partial_products_list_2 = {{3'd0}, _GEN_1}; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 44:57]
  wire [15:0] _GEN_2 = {partial_products_list_ppg_3_io_partial_product, 6'h0}; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 44:40]
  wire [16:0] partial_products_list_3 = {{1'd0}, _GEN_2}; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 44:57]
  wire [16:0] shifted_products_0 = {{1{partial_products_list_0[15]}},partial_products_list_0}; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 50:{33,33}]
  wire [16:0] shifted_products_1 = {{1{partial_products_list_1[15]}},partial_products_list_1}; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 50:{33,33}]
  R4ABE2 partial_products_list_booth_encoder ( // @[src/main/scala/empty/ApproxRadix4Booth8.scala 28:31]
    .io_b_bits(partial_products_list_booth_encoder_io_b_bits),
    .io_neg(partial_products_list_booth_encoder_io_neg),
    .io_factor(partial_products_list_booth_encoder_io_factor)
  );
  PartialProductGenerator partial_products_list_ppg ( // @[src/main/scala/empty/ApproxRadix4Booth8.scala 32:21]
    .io_a(partial_products_list_ppg_io_a),
    .io_neg(partial_products_list_ppg_io_neg),
    .io_factor(partial_products_list_ppg_io_factor),
    .io_partial_product(partial_products_list_ppg_io_partial_product)
  );
  R4ABE2 partial_products_list_booth_encoder_1 ( // @[src/main/scala/empty/ApproxRadix4Booth8.scala 28:31]
    .io_b_bits(partial_products_list_booth_encoder_1_io_b_bits),
    .io_neg(partial_products_list_booth_encoder_1_io_neg),
    .io_factor(partial_products_list_booth_encoder_1_io_factor)
  );
  PartialProductGenerator partial_products_list_ppg_1 ( // @[src/main/scala/empty/ApproxRadix4Booth8.scala 32:21]
    .io_a(partial_products_list_ppg_1_io_a),
    .io_neg(partial_products_list_ppg_1_io_neg),
    .io_factor(partial_products_list_ppg_1_io_factor),
    .io_partial_product(partial_products_list_ppg_1_io_partial_product)
  );
  R4ABE2 partial_products_list_booth_encoder_2 ( // @[src/main/scala/empty/ApproxRadix4Booth8.scala 28:31]
    .io_b_bits(partial_products_list_booth_encoder_2_io_b_bits),
    .io_neg(partial_products_list_booth_encoder_2_io_neg),
    .io_factor(partial_products_list_booth_encoder_2_io_factor)
  );
  PartialProductGenerator partial_products_list_ppg_2 ( // @[src/main/scala/empty/ApproxRadix4Booth8.scala 32:21]
    .io_a(partial_products_list_ppg_2_io_a),
    .io_neg(partial_products_list_ppg_2_io_neg),
    .io_factor(partial_products_list_ppg_2_io_factor),
    .io_partial_product(partial_products_list_ppg_2_io_partial_product)
  );
  R4ABE2 partial_products_list_booth_encoder_3 ( // @[src/main/scala/empty/ApproxRadix4Booth8.scala 28:31]
    .io_b_bits(partial_products_list_booth_encoder_3_io_b_bits),
    .io_neg(partial_products_list_booth_encoder_3_io_neg),
    .io_factor(partial_products_list_booth_encoder_3_io_factor)
  );
  PartialProductGenerator partial_products_list_ppg_3 ( // @[src/main/scala/empty/ApproxRadix4Booth8.scala 32:21]
    .io_a(partial_products_list_ppg_3_io_a),
    .io_neg(partial_products_list_ppg_3_io_neg),
    .io_factor(partial_products_list_ppg_3_io_factor),
    .io_partial_product(partial_products_list_ppg_3_io_partial_product)
  );
  ApproxWallaceTree accumulator ( // @[src/main/scala/empty/ApproxRadix4Booth8.scala 53:27]
    .io_shifted_partial_products_0(accumulator_io_shifted_partial_products_0),
    .io_shifted_partial_products_1(accumulator_io_shifted_partial_products_1),
    .io_shifted_partial_products_2(accumulator_io_shifted_partial_products_2),
    .io_shifted_partial_products_3(accumulator_io_shifted_partial_products_3),
    .io_final_product(accumulator_io_final_product)
  );
  assign io_product = accumulator_io_final_product; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 56:14]
  assign partial_products_list_booth_encoder_io_b_bits = B_ext[2:0]; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 25:23]
  assign partial_products_list_ppg_io_a = io_multiplicand; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 33:14]
  assign partial_products_list_ppg_io_neg = partial_products_list_booth_encoder_io_neg; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 34:16]
  assign partial_products_list_ppg_io_factor = partial_products_list_booth_encoder_io_factor; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 35:19]
  assign partial_products_list_booth_encoder_1_io_b_bits = B_ext[4:2]; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 25:23]
  assign partial_products_list_ppg_1_io_a = io_multiplicand; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 33:14]
  assign partial_products_list_ppg_1_io_neg = partial_products_list_booth_encoder_1_io_neg; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 34:16]
  assign partial_products_list_ppg_1_io_factor = partial_products_list_booth_encoder_1_io_factor; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 35:19]
  assign partial_products_list_booth_encoder_2_io_b_bits = B_ext[6:4]; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 25:23]
  assign partial_products_list_ppg_2_io_a = io_multiplicand; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 33:14]
  assign partial_products_list_ppg_2_io_neg = partial_products_list_booth_encoder_2_io_neg; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 34:16]
  assign partial_products_list_ppg_2_io_factor = partial_products_list_booth_encoder_2_io_factor; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 35:19]
  assign partial_products_list_booth_encoder_3_io_b_bits = B_ext[8:6]; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 25:23]
  assign partial_products_list_ppg_3_io_a = io_multiplicand; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 33:14]
  assign partial_products_list_ppg_3_io_neg = partial_products_list_booth_encoder_3_io_neg; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 34:16]
  assign partial_products_list_ppg_3_io_factor = partial_products_list_booth_encoder_3_io_factor; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 35:19]
  assign accumulator_io_shifted_partial_products_0 = shifted_products_0[15:0]; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 54:43]
  assign accumulator_io_shifted_partial_products_1 = shifted_products_1[15:0]; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 54:43]
  assign accumulator_io_shifted_partial_products_2 = partial_products_list_2[15:0]; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 54:43]
  assign accumulator_io_shifted_partial_products_3 = partial_products_list_3[15:0]; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 54:43]
endmodule
