module R4ABE2_Dynamic(
  input  [2:0] io_b_bits, // @[src/main/scala/empty/DynamicApproxMultiplier.scala 29:14]
  input        io_is_approx, // @[src/main/scala/empty/DynamicApproxMultiplier.scala 29:14]
  output       io_negate, // @[src/main/scala/empty/DynamicApproxMultiplier.scala 29:14]
  output       io_zero, // @[src/main/scala/empty/DynamicApproxMultiplier.scala 29:14]
  output       io_two // @[src/main/scala/empty/DynamicApproxMultiplier.scala 29:14]
);
  wire  two_exact = io_b_bits == 3'h3 | io_b_bits == 3'h4; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 48:39]
  assign io_negate = io_b_bits[2]; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 39:25]
  assign io_zero = io_b_bits == 3'h0 | io_b_bits == 3'h7; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 43:36]
  assign io_two = io_is_approx ? 1'h0 : two_exact; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 49:16]
endmodule
module PartialProductGenerator(
  input  [7:0] io_a, // @[src/main/scala/empty/DynamicApproxMultiplier.scala 61:14]
  input        io_negate, // @[src/main/scala/empty/DynamicApproxMultiplier.scala 61:14]
  output [8:0] io_partial_product // @[src/main/scala/empty/DynamicApproxMultiplier.scala 61:14]
);
  wire [7:0] _io_partial_product_T_2 = 8'sh0 - $signed(io_a); // @[src/main/scala/empty/DynamicApproxMultiplier.scala 68:40]
  wire [7:0] _io_partial_product_T_3 = io_negate ? $signed(_io_partial_product_T_2) : $signed(io_a); // @[src/main/scala/empty/DynamicApproxMultiplier.scala 68:28]
  assign io_partial_product = {{1{_io_partial_product_T_3[7]}},_io_partial_product_T_3}; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 68:22]
endmodule
module ApproxWallaceTree(
  input  [15:0] io_shifted_partial_products_0, // @[src/main/scala/empty/DynamicApproxMultiplier.scala 80:14]
  input  [15:0] io_shifted_partial_products_1, // @[src/main/scala/empty/DynamicApproxMultiplier.scala 80:14]
  input  [15:0] io_shifted_partial_products_2, // @[src/main/scala/empty/DynamicApproxMultiplier.scala 80:14]
  input  [15:0] io_shifted_partial_products_3, // @[src/main/scala/empty/DynamicApproxMultiplier.scala 80:14]
  output [15:0] io_final_product // @[src/main/scala/empty/DynamicApproxMultiplier.scala 80:14]
);
  wire [16:0] _io_final_product_T = $signed(io_shifted_partial_products_0) + $signed(io_shifted_partial_products_1); // @[src/main/scala/empty/DynamicApproxMultiplier.scala 86:64]
  wire [16:0] _io_final_product_T_1 = $signed(io_shifted_partial_products_2) + $signed(io_shifted_partial_products_3); // @[src/main/scala/empty/DynamicApproxMultiplier.scala 86:64]
  wire [17:0] _io_final_product_T_2 = $signed(_io_final_product_T) + $signed(_io_final_product_T_1); // @[src/main/scala/empty/DynamicApproxMultiplier.scala 86:64]
  assign io_final_product = _io_final_product_T_2[15:0]; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 86:20]
endmodule
module DynamicApproxMultiplier(
  input         clock,
  input         reset,
  input  [7:0]  io_multiplicand, // @[src/main/scala/empty/DynamicApproxMultiplier.scala 104:14]
  input  [7:0]  io_multiplier, // @[src/main/scala/empty/DynamicApproxMultiplier.scala 104:14]
  input  [1:0]  io_approx_level, // @[src/main/scala/empty/DynamicApproxMultiplier.scala 104:14]
  output [15:0] io_product // @[src/main/scala/empty/DynamicApproxMultiplier.scala 104:14]
);
  wire [2:0] encoders_0_io_b_bits; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 115:36]
  wire  encoders_0_io_is_approx; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 115:36]
  wire  encoders_0_io_negate; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 115:36]
  wire  encoders_0_io_zero; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 115:36]
  wire  encoders_0_io_two; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 115:36]
  wire [2:0] encoders_1_io_b_bits; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 115:36]
  wire  encoders_1_io_is_approx; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 115:36]
  wire  encoders_1_io_negate; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 115:36]
  wire  encoders_1_io_zero; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 115:36]
  wire  encoders_1_io_two; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 115:36]
  wire [2:0] encoders_2_io_b_bits; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 115:36]
  wire  encoders_2_io_is_approx; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 115:36]
  wire  encoders_2_io_negate; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 115:36]
  wire  encoders_2_io_zero; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 115:36]
  wire  encoders_2_io_two; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 115:36]
  wire [2:0] encoders_3_io_b_bits; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 115:36]
  wire  encoders_3_io_is_approx; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 115:36]
  wire  encoders_3_io_negate; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 115:36]
  wire  encoders_3_io_zero; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 115:36]
  wire  encoders_3_io_two; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 115:36]
  wire [7:0] ppgs_0_io_a; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 116:36]
  wire  ppgs_0_io_negate; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 116:36]
  wire [8:0] ppgs_0_io_partial_product; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 116:36]
  wire [7:0] ppgs_1_io_a; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 116:36]
  wire  ppgs_1_io_negate; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 116:36]
  wire [8:0] ppgs_1_io_partial_product; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 116:36]
  wire [7:0] ppgs_2_io_a; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 116:36]
  wire  ppgs_2_io_negate; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 116:36]
  wire [8:0] ppgs_2_io_partial_product; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 116:36]
  wire [7:0] ppgs_3_io_a; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 116:36]
  wire  ppgs_3_io_negate; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 116:36]
  wire [8:0] ppgs_3_io_partial_product; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 116:36]
  wire [15:0] wallace_tree_io_shifted_partial_products_0; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 180:28]
  wire [15:0] wallace_tree_io_shifted_partial_products_1; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 180:28]
  wire [15:0] wallace_tree_io_shifted_partial_products_2; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 180:28]
  wire [15:0] wallace_tree_io_shifted_partial_products_3; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 180:28]
  wire [15:0] wallace_tree_io_final_product; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 180:28]
  wire [8:0] b_extended = {io_multiplier,1'h0}; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 112:23]
  wire  a_is_zero = $signed(io_multiplicand) == 8'sh0; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 121:36]
  wire  row_is_approx_0 = 2'h0 < io_approx_level; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 133:30]
  wire  row_is_approx_1 = 2'h1 < io_approx_level; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 133:30]
  wire  row_is_approx_2 = 2'h2 < io_approx_level; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 133:30]
  wire  row_is_zero = encoders_0_io_zero | a_is_zero; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 148:43]
  wire [9:0] _pp_signed_T = {$signed(ppgs_0_io_partial_product), 1'h0}; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 156:50]
  wire [9:0] _pp_signed_T_1 = encoders_0_io_two ? $signed(_pp_signed_T) : $signed({{1{ppgs_0_io_partial_product[8]}},
    ppgs_0_io_partial_product}); // @[src/main/scala/empty/DynamicApproxMultiplier.scala 156:21]
  wire [8:0] pp_signed = _pp_signed_T_1[8:0]; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 155:25 156:15]
  wire [8:0] pp_gated = row_is_zero ? $signed(9'sh0) : $signed(pp_signed); // @[src/main/scala/empty/DynamicApproxMultiplier.scala 160:20]
  wire  need_correction = ~row_is_approx_0 & encoders_0_io_negate; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 170:45]
  wire [1:0] _correction_bit_T_2 = need_correction & ~row_is_zero ? $signed(2'sh1) : $signed(2'sh0); // @[src/main/scala/empty/DynamicApproxMultiplier.scala 172:26]
  wire [15:0] pp_extended = {{7{pp_gated[8]}},pp_gated}; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 163:27 164:17]
  wire [15:0] correction_bit = {{14{_correction_bit_T_2[1]}},_correction_bit_T_2}; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 171:30 172:20]
  wire  row_is_zero_1 = encoders_1_io_zero | a_is_zero; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 148:43]
  wire [9:0] _pp_signed_T_2 = {$signed(ppgs_1_io_partial_product), 1'h0}; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 156:50]
  wire [9:0] _pp_signed_T_3 = encoders_1_io_two ? $signed(_pp_signed_T_2) : $signed({{1{ppgs_1_io_partial_product[8]}},
    ppgs_1_io_partial_product}); // @[src/main/scala/empty/DynamicApproxMultiplier.scala 156:21]
  wire [8:0] pp_signed_1 = _pp_signed_T_3[8:0]; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 155:25 156:15]
  wire [8:0] pp_gated_1 = row_is_zero_1 ? $signed(9'sh0) : $signed(pp_signed_1); // @[src/main/scala/empty/DynamicApproxMultiplier.scala 160:20]
  wire  need_correction_1 = ~row_is_approx_1 & encoders_1_io_negate; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 170:45]
  wire [1:0] _correction_bit_T_5 = need_correction_1 & ~row_is_zero_1 ? $signed(2'sh1) : $signed(2'sh0); // @[src/main/scala/empty/DynamicApproxMultiplier.scala 172:26]
  wire [15:0] pp_extended_1 = {{7{pp_gated_1[8]}},pp_gated_1}; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 163:27 164:17]
  wire [17:0] _partial_products_1_T = {$signed(pp_extended_1), 2'h0}; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 176:41]
  wire [15:0] correction_bit_1 = {{14{_correction_bit_T_5[1]}},_correction_bit_T_5}; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 171:30 172:20]
  wire [17:0] _partial_products_1_T_1 = {$signed(correction_bit_1), 2'h0}; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 176:78]
  wire [17:0] _partial_products_1_T_4 = $signed(_partial_products_1_T) + $signed(_partial_products_1_T_1); // @[src/main/scala/empty/DynamicApproxMultiplier.scala 176:60]
  wire  row_is_zero_2 = encoders_2_io_zero | a_is_zero; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 148:43]
  wire [9:0] _pp_signed_T_4 = {$signed(ppgs_2_io_partial_product), 1'h0}; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 156:50]
  wire [9:0] _pp_signed_T_5 = encoders_2_io_two ? $signed(_pp_signed_T_4) : $signed({{1{ppgs_2_io_partial_product[8]}},
    ppgs_2_io_partial_product}); // @[src/main/scala/empty/DynamicApproxMultiplier.scala 156:21]
  wire [8:0] pp_signed_2 = _pp_signed_T_5[8:0]; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 155:25 156:15]
  wire [8:0] pp_gated_2 = row_is_zero_2 ? $signed(9'sh0) : $signed(pp_signed_2); // @[src/main/scala/empty/DynamicApproxMultiplier.scala 160:20]
  wire  need_correction_2 = ~row_is_approx_2 & encoders_2_io_negate; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 170:45]
  wire [1:0] _correction_bit_T_8 = need_correction_2 & ~row_is_zero_2 ? $signed(2'sh1) : $signed(2'sh0); // @[src/main/scala/empty/DynamicApproxMultiplier.scala 172:26]
  wire [15:0] pp_extended_2 = {{7{pp_gated_2[8]}},pp_gated_2}; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 163:27 164:17]
  wire [19:0] _partial_products_2_T = {$signed(pp_extended_2), 4'h0}; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 176:41]
  wire [15:0] correction_bit_2 = {{14{_correction_bit_T_8[1]}},_correction_bit_T_8}; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 171:30 172:20]
  wire [19:0] _partial_products_2_T_1 = {$signed(correction_bit_2), 4'h0}; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 176:78]
  wire [19:0] _partial_products_2_T_4 = $signed(_partial_products_2_T) + $signed(_partial_products_2_T_1); // @[src/main/scala/empty/DynamicApproxMultiplier.scala 176:60]
  wire  row_is_zero_3 = encoders_3_io_zero | a_is_zero; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 148:43]
  wire [9:0] _pp_signed_T_6 = {$signed(ppgs_3_io_partial_product), 1'h0}; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 156:50]
  wire [9:0] _pp_signed_T_7 = encoders_3_io_two ? $signed(_pp_signed_T_6) : $signed({{1{ppgs_3_io_partial_product[8]}},
    ppgs_3_io_partial_product}); // @[src/main/scala/empty/DynamicApproxMultiplier.scala 156:21]
  wire [8:0] pp_signed_3 = _pp_signed_T_7[8:0]; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 155:25 156:15]
  wire [8:0] pp_gated_3 = row_is_zero_3 ? $signed(9'sh0) : $signed(pp_signed_3); // @[src/main/scala/empty/DynamicApproxMultiplier.scala 160:20]
  wire  need_correction_3 = encoders_3_io_negate; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 170:45]
  wire [1:0] _correction_bit_T_11 = need_correction_3 & ~row_is_zero_3 ? $signed(2'sh1) : $signed(2'sh0); // @[src/main/scala/empty/DynamicApproxMultiplier.scala 172:26]
  wire [15:0] pp_extended_3 = {{7{pp_gated_3[8]}},pp_gated_3}; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 163:27 164:17]
  wire [21:0] _partial_products_3_T = {$signed(pp_extended_3), 6'h0}; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 176:41]
  wire [15:0] correction_bit_3 = {{14{_correction_bit_T_11[1]}},_correction_bit_T_11}; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 171:30 172:20]
  wire [21:0] _partial_products_3_T_1 = {$signed(correction_bit_3), 6'h0}; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 176:78]
  wire [21:0] _partial_products_3_T_4 = $signed(_partial_products_3_T) + $signed(_partial_products_3_T_1); // @[src/main/scala/empty/DynamicApproxMultiplier.scala 176:60]
  R4ABE2_Dynamic encoders_0 ( // @[src/main/scala/empty/DynamicApproxMultiplier.scala 115:36]
    .io_b_bits(encoders_0_io_b_bits),
    .io_is_approx(encoders_0_io_is_approx),
    .io_negate(encoders_0_io_negate),
    .io_zero(encoders_0_io_zero),
    .io_two(encoders_0_io_two)
  );
  R4ABE2_Dynamic encoders_1 ( // @[src/main/scala/empty/DynamicApproxMultiplier.scala 115:36]
    .io_b_bits(encoders_1_io_b_bits),
    .io_is_approx(encoders_1_io_is_approx),
    .io_negate(encoders_1_io_negate),
    .io_zero(encoders_1_io_zero),
    .io_two(encoders_1_io_two)
  );
  R4ABE2_Dynamic encoders_2 ( // @[src/main/scala/empty/DynamicApproxMultiplier.scala 115:36]
    .io_b_bits(encoders_2_io_b_bits),
    .io_is_approx(encoders_2_io_is_approx),
    .io_negate(encoders_2_io_negate),
    .io_zero(encoders_2_io_zero),
    .io_two(encoders_2_io_two)
  );
  R4ABE2_Dynamic encoders_3 ( // @[src/main/scala/empty/DynamicApproxMultiplier.scala 115:36]
    .io_b_bits(encoders_3_io_b_bits),
    .io_is_approx(encoders_3_io_is_approx),
    .io_negate(encoders_3_io_negate),
    .io_zero(encoders_3_io_zero),
    .io_two(encoders_3_io_two)
  );
  PartialProductGenerator ppgs_0 ( // @[src/main/scala/empty/DynamicApproxMultiplier.scala 116:36]
    .io_a(ppgs_0_io_a),
    .io_negate(ppgs_0_io_negate),
    .io_partial_product(ppgs_0_io_partial_product)
  );
  PartialProductGenerator ppgs_1 ( // @[src/main/scala/empty/DynamicApproxMultiplier.scala 116:36]
    .io_a(ppgs_1_io_a),
    .io_negate(ppgs_1_io_negate),
    .io_partial_product(ppgs_1_io_partial_product)
  );
  PartialProductGenerator ppgs_2 ( // @[src/main/scala/empty/DynamicApproxMultiplier.scala 116:36]
    .io_a(ppgs_2_io_a),
    .io_negate(ppgs_2_io_negate),
    .io_partial_product(ppgs_2_io_partial_product)
  );
  PartialProductGenerator ppgs_3 ( // @[src/main/scala/empty/DynamicApproxMultiplier.scala 116:36]
    .io_a(ppgs_3_io_a),
    .io_negate(ppgs_3_io_negate),
    .io_partial_product(ppgs_3_io_partial_product)
  );
  ApproxWallaceTree wallace_tree ( // @[src/main/scala/empty/DynamicApproxMultiplier.scala 180:28]
    .io_shifted_partial_products_0(wallace_tree_io_shifted_partial_products_0),
    .io_shifted_partial_products_1(wallace_tree_io_shifted_partial_products_1),
    .io_shifted_partial_products_2(wallace_tree_io_shifted_partial_products_2),
    .io_shifted_partial_products_3(wallace_tree_io_shifted_partial_products_3),
    .io_final_product(wallace_tree_io_final_product)
  );
  assign io_product = wallace_tree_io_final_product; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 182:14]
  assign encoders_0_io_b_bits = b_extended[2:0]; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 138:43]
  assign encoders_0_io_is_approx = 2'h0 < io_approx_level; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 133:30]
  assign encoders_1_io_b_bits = b_extended[4:2]; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 138:43]
  assign encoders_1_io_is_approx = 2'h1 < io_approx_level; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 133:30]
  assign encoders_2_io_b_bits = b_extended[6:4]; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 138:43]
  assign encoders_2_io_is_approx = 2'h2 < io_approx_level; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 133:30]
  assign encoders_3_io_b_bits = b_extended[8:6]; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 138:43]
  assign encoders_3_io_is_approx = 1'h0; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 133:30]
  assign ppgs_0_io_a = io_multiplicand; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 142:23]
  assign ppgs_0_io_negate = encoders_0_io_negate; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 143:23]
  assign ppgs_1_io_a = io_multiplicand; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 142:23]
  assign ppgs_1_io_negate = encoders_1_io_negate; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 143:23]
  assign ppgs_2_io_a = io_multiplicand; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 142:23]
  assign ppgs_2_io_negate = encoders_2_io_negate; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 143:23]
  assign ppgs_3_io_a = io_multiplicand; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 142:23]
  assign ppgs_3_io_negate = encoders_3_io_negate; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 143:23]
  assign wallace_tree_io_shifted_partial_products_0 = $signed(pp_extended) + $signed(correction_bit); // @[src/main/scala/empty/DynamicApproxMultiplier.scala 176:60]
  assign wallace_tree_io_shifted_partial_products_1 = _partial_products_1_T_4[15:0]; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 118:30 176:25]
  assign wallace_tree_io_shifted_partial_products_2 = _partial_products_2_T_4[15:0]; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 118:30 176:25]
  assign wallace_tree_io_shifted_partial_products_3 = _partial_products_3_T_4[15:0]; // @[src/main/scala/empty/DynamicApproxMultiplier.scala 118:30 176:25]
endmodule
