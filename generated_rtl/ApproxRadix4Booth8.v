module R4ABE2(
  input  [2:0] io_b_bits, // @[src/main/scala/empty/R4ABE2.scala 14:14]
  output       io_negate, // @[src/main/scala/empty/R4ABE2.scala 14:14]
  output       io_zero // @[src/main/scala/empty/R4ABE2.scala 14:14]
);
  assign io_negate = io_b_bits[2]; // @[src/main/scala/empty/R4ABE2.scala 25:27]
  assign io_zero = io_b_bits == 3'h0 | io_b_bits == 3'h7; // @[src/main/scala/empty/R4ABE2.scala 30:38]
endmodule
module R4ABE2_2(
  input  [2:0] io_b_bits, // @[src/main/scala/empty/R4ABE2.scala 14:14]
  output       io_negate, // @[src/main/scala/empty/R4ABE2.scala 14:14]
  output       io_zero, // @[src/main/scala/empty/R4ABE2.scala 14:14]
  output       io_two // @[src/main/scala/empty/R4ABE2.scala 14:14]
);
  assign io_negate = io_b_bits[2]; // @[src/main/scala/empty/R4ABE2.scala 38:27]
  assign io_zero = io_b_bits == 3'h0 | io_b_bits == 3'h7; // @[src/main/scala/empty/R4ABE2.scala 41:38]
  assign io_two = io_b_bits == 3'h3 | io_b_bits == 3'h4; // @[src/main/scala/empty/R4ABE2.scala 44:38]
endmodule
module PartialProductGenerator(
  input  [7:0] io_a, // @[src/main/scala/empty/PartialProductGenerator.scala 41:14]
  input        io_negate, // @[src/main/scala/empty/PartialProductGenerator.scala 41:14]
  output [8:0] io_partial_product // @[src/main/scala/empty/PartialProductGenerator.scala 41:14]
);
  wire [7:0] _io_partial_product_T_2 = 8'sh0 - $signed(io_a); // @[src/main/scala/empty/PartialProductGenerator.scala 56:40]
  wire [7:0] _io_partial_product_T_3 = io_negate ? $signed(_io_partial_product_T_2) : $signed(io_a); // @[src/main/scala/empty/PartialProductGenerator.scala 56:28]
  assign io_partial_product = {{1{_io_partial_product_T_3[7]}},_io_partial_product_T_3}; // @[src/main/scala/empty/PartialProductGenerator.scala 56:22]
endmodule
module ApproxWallaceTree(
  input  [15:0] io_shifted_partial_products_0, // @[src/main/scala/empty/ApproxWallaceTree.scala 23:14]
  input  [15:0] io_shifted_partial_products_1, // @[src/main/scala/empty/ApproxWallaceTree.scala 23:14]
  input  [15:0] io_shifted_partial_products_2, // @[src/main/scala/empty/ApproxWallaceTree.scala 23:14]
  input  [15:0] io_shifted_partial_products_3, // @[src/main/scala/empty/ApproxWallaceTree.scala 23:14]
  output [15:0] io_final_product // @[src/main/scala/empty/ApproxWallaceTree.scala 23:14]
);
  wire [16:0] _io_final_product_T = $signed(io_shifted_partial_products_0) + $signed(io_shifted_partial_products_1); // @[src/main/scala/empty/ApproxWallaceTree.scala 31:64]
  wire [16:0] _io_final_product_T_1 = $signed(io_shifted_partial_products_2) + $signed(io_shifted_partial_products_3); // @[src/main/scala/empty/ApproxWallaceTree.scala 31:64]
  wire [17:0] _io_final_product_T_2 = $signed(_io_final_product_T) + $signed(_io_final_product_T_1); // @[src/main/scala/empty/ApproxWallaceTree.scala 31:64]
  assign io_final_product = _io_final_product_T_2[15:0]; // @[src/main/scala/empty/ApproxWallaceTree.scala 31:20]
endmodule
module ApproxRadix4Booth8(
  input         clock,
  input         reset,
  input  [7:0]  io_multiplicand, // @[src/main/scala/empty/ApproxRadix4Booth8.scala 16:14]
  input  [7:0]  io_multiplier, // @[src/main/scala/empty/ApproxRadix4Booth8.scala 16:14]
  output [15:0] io_product // @[src/main/scala/empty/ApproxRadix4Booth8.scala 16:14]
);
  wire [2:0] encoders_0_io_b_bits; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 27:45]
  wire  encoders_0_io_negate; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 27:45]
  wire  encoders_0_io_zero; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 27:45]
  wire [2:0] encoders_1_io_b_bits; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 27:45]
  wire  encoders_1_io_negate; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 27:45]
  wire  encoders_1_io_zero; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 27:45]
  wire [2:0] encoders_2_io_b_bits; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 27:45]
  wire  encoders_2_io_negate; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 27:45]
  wire  encoders_2_io_zero; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 27:45]
  wire  encoders_2_io_two; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 27:45]
  wire [2:0] encoders_3_io_b_bits; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 27:45]
  wire  encoders_3_io_negate; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 27:45]
  wire  encoders_3_io_zero; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 27:45]
  wire  encoders_3_io_two; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 27:45]
  wire [7:0] ppgs_0_io_a; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 28:36]
  wire  ppgs_0_io_negate; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 28:36]
  wire [8:0] ppgs_0_io_partial_product; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 28:36]
  wire [7:0] ppgs_1_io_a; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 28:36]
  wire  ppgs_1_io_negate; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 28:36]
  wire [8:0] ppgs_1_io_partial_product; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 28:36]
  wire [7:0] ppgs_2_io_a; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 28:36]
  wire  ppgs_2_io_negate; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 28:36]
  wire [8:0] ppgs_2_io_partial_product; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 28:36]
  wire [7:0] ppgs_3_io_a; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 28:36]
  wire  ppgs_3_io_negate; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 28:36]
  wire [8:0] ppgs_3_io_partial_product; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 28:36]
  wire [15:0] wallace_tree_io_shifted_partial_products_0; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 86:28]
  wire [15:0] wallace_tree_io_shifted_partial_products_1; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 86:28]
  wire [15:0] wallace_tree_io_shifted_partial_products_2; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 86:28]
  wire [15:0] wallace_tree_io_shifted_partial_products_3; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 86:28]
  wire [15:0] wallace_tree_io_final_product; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 86:28]
  wire [8:0] b_extended = {io_multiplier,1'h0}; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 23:23]
  wire  a_is_zero = $signed(io_multiplicand) == 8'sh0; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 35:36]
  wire  row_is_zero = encoders_0_io_zero | a_is_zero; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 50:43]
  wire [9:0] _pp_signed_T_1 = {{1{ppgs_0_io_partial_product[8]}},ppgs_0_io_partial_product}; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 57:21]
  wire [8:0] pp_signed = _pp_signed_T_1[8:0]; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 56:25 57:15]
  wire [8:0] pp_gated = row_is_zero ? $signed(9'sh0) : $signed(pp_signed); // @[src/main/scala/empty/ApproxRadix4Booth8.scala 61:20]
  wire [15:0] pp_extended = {{7{pp_gated[8]}},pp_gated}; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 64:27 65:17]
  wire [16:0] _partial_products_0_T_2 = {{1{pp_extended[15]}},pp_extended}; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 82:60]
  wire  row_is_zero_1 = encoders_1_io_zero | a_is_zero; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 50:43]
  wire [9:0] _pp_signed_T_3 = {{1{ppgs_1_io_partial_product[8]}},ppgs_1_io_partial_product}; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 57:21]
  wire [8:0] pp_signed_1 = _pp_signed_T_3[8:0]; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 56:25 57:15]
  wire [8:0] pp_gated_1 = row_is_zero_1 ? $signed(9'sh0) : $signed(pp_signed_1); // @[src/main/scala/empty/ApproxRadix4Booth8.scala 61:20]
  wire [15:0] pp_extended_1 = {{7{pp_gated_1[8]}},pp_gated_1}; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 64:27 65:17]
  wire [17:0] _partial_products_1_T = {$signed(pp_extended_1), 2'h0}; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 82:41]
  wire [18:0] _partial_products_1_T_2 = {{1{_partial_products_1_T[17]}},_partial_products_1_T}; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 82:60]
  wire [17:0] _partial_products_1_T_4 = _partial_products_1_T_2[17:0]; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 82:60]
  wire  row_is_zero_2 = encoders_2_io_zero | a_is_zero; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 50:43]
  wire [9:0] _pp_signed_T_4 = {$signed(ppgs_2_io_partial_product), 1'h0}; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 57:50]
  wire [9:0] _pp_signed_T_5 = encoders_2_io_two ? $signed(_pp_signed_T_4) : $signed({{1{ppgs_2_io_partial_product[8]}},
    ppgs_2_io_partial_product}); // @[src/main/scala/empty/ApproxRadix4Booth8.scala 57:21]
  wire [8:0] pp_signed_2 = _pp_signed_T_5[8:0]; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 56:25 57:15]
  wire [8:0] pp_gated_2 = row_is_zero_2 ? $signed(9'sh0) : $signed(pp_signed_2); // @[src/main/scala/empty/ApproxRadix4Booth8.scala 61:20]
  wire [1:0] _correction_bit_T_2 = encoders_2_io_negate & ~row_is_zero_2 ? $signed(2'sh1) : $signed(2'sh0); // @[src/main/scala/empty/ApproxRadix4Booth8.scala 78:29]
  wire [15:0] pp_extended_2 = {{7{pp_gated_2[8]}},pp_gated_2}; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 64:27 65:17]
  wire [19:0] _partial_products_2_T = {$signed(pp_extended_2), 4'h0}; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 82:41]
  wire [15:0] correction_bit_2 = {{14{_correction_bit_T_2[1]}},_correction_bit_T_2}; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 71:30 78:23]
  wire [19:0] _partial_products_2_T_1 = {$signed(correction_bit_2), 4'h0}; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 82:78]
  wire [19:0] _partial_products_2_T_4 = $signed(_partial_products_2_T) + $signed(_partial_products_2_T_1); // @[src/main/scala/empty/ApproxRadix4Booth8.scala 82:60]
  wire  row_is_zero_3 = encoders_3_io_zero | a_is_zero; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 50:43]
  wire [9:0] _pp_signed_T_6 = {$signed(ppgs_3_io_partial_product), 1'h0}; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 57:50]
  wire [9:0] _pp_signed_T_7 = encoders_3_io_two ? $signed(_pp_signed_T_6) : $signed({{1{ppgs_3_io_partial_product[8]}},
    ppgs_3_io_partial_product}); // @[src/main/scala/empty/ApproxRadix4Booth8.scala 57:21]
  wire [8:0] pp_signed_3 = _pp_signed_T_7[8:0]; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 56:25 57:15]
  wire [8:0] pp_gated_3 = row_is_zero_3 ? $signed(9'sh0) : $signed(pp_signed_3); // @[src/main/scala/empty/ApproxRadix4Booth8.scala 61:20]
  wire [1:0] _correction_bit_T_5 = encoders_3_io_negate & ~row_is_zero_3 ? $signed(2'sh1) : $signed(2'sh0); // @[src/main/scala/empty/ApproxRadix4Booth8.scala 78:29]
  wire [15:0] pp_extended_3 = {{7{pp_gated_3[8]}},pp_gated_3}; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 64:27 65:17]
  wire [21:0] _partial_products_3_T = {$signed(pp_extended_3), 6'h0}; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 82:41]
  wire [15:0] correction_bit_3 = {{14{_correction_bit_T_5[1]}},_correction_bit_T_5}; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 71:30 78:23]
  wire [21:0] _partial_products_3_T_1 = {$signed(correction_bit_3), 6'h0}; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 82:78]
  wire [21:0] _partial_products_3_T_4 = $signed(_partial_products_3_T) + $signed(_partial_products_3_T_1); // @[src/main/scala/empty/ApproxRadix4Booth8.scala 82:60]
  R4ABE2 encoders_0 ( // @[src/main/scala/empty/ApproxRadix4Booth8.scala 27:45]
    .io_b_bits(encoders_0_io_b_bits),
    .io_negate(encoders_0_io_negate),
    .io_zero(encoders_0_io_zero)
  );
  R4ABE2 encoders_1 ( // @[src/main/scala/empty/ApproxRadix4Booth8.scala 27:45]
    .io_b_bits(encoders_1_io_b_bits),
    .io_negate(encoders_1_io_negate),
    .io_zero(encoders_1_io_zero)
  );
  R4ABE2_2 encoders_2 ( // @[src/main/scala/empty/ApproxRadix4Booth8.scala 27:45]
    .io_b_bits(encoders_2_io_b_bits),
    .io_negate(encoders_2_io_negate),
    .io_zero(encoders_2_io_zero),
    .io_two(encoders_2_io_two)
  );
  R4ABE2_2 encoders_3 ( // @[src/main/scala/empty/ApproxRadix4Booth8.scala 27:45]
    .io_b_bits(encoders_3_io_b_bits),
    .io_negate(encoders_3_io_negate),
    .io_zero(encoders_3_io_zero),
    .io_two(encoders_3_io_two)
  );
  PartialProductGenerator ppgs_0 ( // @[src/main/scala/empty/ApproxRadix4Booth8.scala 28:36]
    .io_a(ppgs_0_io_a),
    .io_negate(ppgs_0_io_negate),
    .io_partial_product(ppgs_0_io_partial_product)
  );
  PartialProductGenerator ppgs_1 ( // @[src/main/scala/empty/ApproxRadix4Booth8.scala 28:36]
    .io_a(ppgs_1_io_a),
    .io_negate(ppgs_1_io_negate),
    .io_partial_product(ppgs_1_io_partial_product)
  );
  PartialProductGenerator ppgs_2 ( // @[src/main/scala/empty/ApproxRadix4Booth8.scala 28:36]
    .io_a(ppgs_2_io_a),
    .io_negate(ppgs_2_io_negate),
    .io_partial_product(ppgs_2_io_partial_product)
  );
  PartialProductGenerator ppgs_3 ( // @[src/main/scala/empty/ApproxRadix4Booth8.scala 28:36]
    .io_a(ppgs_3_io_a),
    .io_negate(ppgs_3_io_negate),
    .io_partial_product(ppgs_3_io_partial_product)
  );
  ApproxWallaceTree wallace_tree ( // @[src/main/scala/empty/ApproxRadix4Booth8.scala 86:28]
    .io_shifted_partial_products_0(wallace_tree_io_shifted_partial_products_0),
    .io_shifted_partial_products_1(wallace_tree_io_shifted_partial_products_1),
    .io_shifted_partial_products_2(wallace_tree_io_shifted_partial_products_2),
    .io_shifted_partial_products_3(wallace_tree_io_shifted_partial_products_3),
    .io_final_product(wallace_tree_io_final_product)
  );
  assign io_product = wallace_tree_io_final_product; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 88:14]
  assign encoders_0_io_b_bits = b_extended[2:0]; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 39:40]
  assign encoders_1_io_b_bits = b_extended[4:2]; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 39:40]
  assign encoders_2_io_b_bits = b_extended[6:4]; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 39:40]
  assign encoders_3_io_b_bits = b_extended[8:6]; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 39:40]
  assign ppgs_0_io_a = io_multiplicand; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 42:18]
  assign ppgs_0_io_negate = encoders_0_io_negate; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 44:23]
  assign ppgs_1_io_a = io_multiplicand; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 42:18]
  assign ppgs_1_io_negate = encoders_1_io_negate; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 44:23]
  assign ppgs_2_io_a = io_multiplicand; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 42:18]
  assign ppgs_2_io_negate = encoders_2_io_negate; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 44:23]
  assign ppgs_3_io_a = io_multiplicand; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 42:18]
  assign ppgs_3_io_negate = encoders_3_io_negate; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 44:23]
  assign wallace_tree_io_shifted_partial_products_0 = _partial_products_0_T_2[15:0]; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 82:60]
  assign wallace_tree_io_shifted_partial_products_1 = _partial_products_1_T_4[15:0]; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 30:30 82:25]
  assign wallace_tree_io_shifted_partial_products_2 = _partial_products_2_T_4[15:0]; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 30:30 82:25]
  assign wallace_tree_io_shifted_partial_products_3 = _partial_products_3_T_4[15:0]; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 30:30 82:25]
endmodule
