module R4ABE2(
  input  [2:0] io_b_bits, // @[src/main/scala/empty/R4ABE2.scala 7:14]
  output       io_negate // @[src/main/scala/empty/R4ABE2.scala 7:14]
);
  assign io_negate = io_b_bits[2]; // @[src/main/scala/empty/R4ABE2.scala 12:25]
endmodule
module PartialProductGenerator(
  input  [7:0] io_a, // @[src/main/scala/empty/PartialProductGenerator.scala 15:14]
  input        io_negate, // @[src/main/scala/empty/PartialProductGenerator.scala 15:14]
  output [8:0] io_partial_product // @[src/main/scala/empty/PartialProductGenerator.scala 15:14]
);
  wire [7:0] a_inv = ~io_a; // @[src/main/scala/empty/PartialProductGenerator.scala 23:30]
  wire [7:0] _io_partial_product_T = io_negate ? $signed(a_inv) : $signed(io_a); // @[src/main/scala/empty/PartialProductGenerator.scala 26:28]
  assign io_partial_product = {{1{_io_partial_product_T[7]}},_io_partial_product_T}; // @[src/main/scala/empty/PartialProductGenerator.scala 26:22]
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
  input  [7:0]  io_multiplicand, // @[src/main/scala/empty/ApproxRadix4Booth8.scala 6:14]
  input  [7:0]  io_multiplier, // @[src/main/scala/empty/ApproxRadix4Booth8.scala 6:14]
  output [15:0] io_product // @[src/main/scala/empty/ApproxRadix4Booth8.scala 6:14]
);
  wire [2:0] encoders_0_io_b_bits; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 15:36]
  wire  encoders_0_io_negate; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 15:36]
  wire [2:0] encoders_1_io_b_bits; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 15:36]
  wire  encoders_1_io_negate; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 15:36]
  wire [2:0] encoders_2_io_b_bits; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 15:36]
  wire  encoders_2_io_negate; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 15:36]
  wire [2:0] encoders_3_io_b_bits; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 15:36]
  wire  encoders_3_io_negate; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 15:36]
  wire [7:0] ppgs_0_io_a; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 16:32]
  wire  ppgs_0_io_negate; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 16:32]
  wire [8:0] ppgs_0_io_partial_product; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 16:32]
  wire [7:0] ppgs_1_io_a; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 16:32]
  wire  ppgs_1_io_negate; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 16:32]
  wire [8:0] ppgs_1_io_partial_product; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 16:32]
  wire [7:0] ppgs_2_io_a; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 16:32]
  wire  ppgs_2_io_negate; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 16:32]
  wire [8:0] ppgs_2_io_partial_product; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 16:32]
  wire [7:0] ppgs_3_io_a; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 16:32]
  wire  ppgs_3_io_negate; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 16:32]
  wire [8:0] ppgs_3_io_partial_product; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 16:32]
  wire [15:0] wallace_tree_io_shifted_partial_products_0; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 49:28]
  wire [15:0] wallace_tree_io_shifted_partial_products_1; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 49:28]
  wire [15:0] wallace_tree_io_shifted_partial_products_2; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 49:28]
  wire [15:0] wallace_tree_io_shifted_partial_products_3; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 49:28]
  wire [15:0] wallace_tree_io_final_product; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 49:28]
  wire [8:0] b_extended = {io_multiplier,1'h0}; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 13:23]
  wire  comp_bit = ~encoders_0_io_negate; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 30:21]
  wire [9:0] pp_candidate = {comp_bit,ppgs_0_io_partial_product}; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 34:73]
  wire  is_zero = encoders_0_io_b_bits == 3'h0 | encoders_0_io_b_bits == 3'h7; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 38:56]
  wire [9:0] pp_final = is_zero ? $signed(10'sh0) : $signed(pp_candidate); // @[src/main/scala/empty/ApproxRadix4Booth8.scala 42:23]
  wire  comp_bit_1 = ~encoders_1_io_negate; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 30:21]
  wire [9:0] pp_candidate_1 = {comp_bit_1,ppgs_1_io_partial_product}; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 34:73]
  wire  is_zero_1 = encoders_1_io_b_bits == 3'h0 | encoders_1_io_b_bits == 3'h7; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 38:56]
  wire [9:0] pp_final_1 = is_zero_1 ? $signed(10'sh0) : $signed(pp_candidate_1); // @[src/main/scala/empty/ApproxRadix4Booth8.scala 42:23]
  wire [11:0] _partial_products_1_T = {$signed(pp_final_1), 2'h0}; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 45:37]
  wire  comp_bit_2 = ~encoders_2_io_negate; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 30:21]
  wire [9:0] pp_candidate_2 = {comp_bit_2,ppgs_2_io_partial_product}; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 34:73]
  wire  is_zero_2 = encoders_2_io_b_bits == 3'h0 | encoders_2_io_b_bits == 3'h7; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 38:56]
  wire [9:0] pp_final_2 = is_zero_2 ? $signed(10'sh0) : $signed(pp_candidate_2); // @[src/main/scala/empty/ApproxRadix4Booth8.scala 42:23]
  wire [13:0] _partial_products_2_T = {$signed(pp_final_2), 4'h0}; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 45:37]
  wire  comp_bit_3 = ~encoders_3_io_negate; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 30:21]
  wire [9:0] pp_candidate_3 = {comp_bit_3,ppgs_3_io_partial_product}; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 34:73]
  wire  is_zero_3 = encoders_3_io_b_bits == 3'h0 | encoders_3_io_b_bits == 3'h7; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 38:56]
  wire [9:0] pp_final_3 = is_zero_3 ? $signed(10'sh0) : $signed(pp_candidate_3); // @[src/main/scala/empty/ApproxRadix4Booth8.scala 42:23]
  R4ABE2 encoders_0 ( // @[src/main/scala/empty/ApproxRadix4Booth8.scala 15:36]
    .io_b_bits(encoders_0_io_b_bits),
    .io_negate(encoders_0_io_negate)
  );
  R4ABE2 encoders_1 ( // @[src/main/scala/empty/ApproxRadix4Booth8.scala 15:36]
    .io_b_bits(encoders_1_io_b_bits),
    .io_negate(encoders_1_io_negate)
  );
  R4ABE2 encoders_2 ( // @[src/main/scala/empty/ApproxRadix4Booth8.scala 15:36]
    .io_b_bits(encoders_2_io_b_bits),
    .io_negate(encoders_2_io_negate)
  );
  R4ABE2 encoders_3 ( // @[src/main/scala/empty/ApproxRadix4Booth8.scala 15:36]
    .io_b_bits(encoders_3_io_b_bits),
    .io_negate(encoders_3_io_negate)
  );
  PartialProductGenerator ppgs_0 ( // @[src/main/scala/empty/ApproxRadix4Booth8.scala 16:32]
    .io_a(ppgs_0_io_a),
    .io_negate(ppgs_0_io_negate),
    .io_partial_product(ppgs_0_io_partial_product)
  );
  PartialProductGenerator ppgs_1 ( // @[src/main/scala/empty/ApproxRadix4Booth8.scala 16:32]
    .io_a(ppgs_1_io_a),
    .io_negate(ppgs_1_io_negate),
    .io_partial_product(ppgs_1_io_partial_product)
  );
  PartialProductGenerator ppgs_2 ( // @[src/main/scala/empty/ApproxRadix4Booth8.scala 16:32]
    .io_a(ppgs_2_io_a),
    .io_negate(ppgs_2_io_negate),
    .io_partial_product(ppgs_2_io_partial_product)
  );
  PartialProductGenerator ppgs_3 ( // @[src/main/scala/empty/ApproxRadix4Booth8.scala 16:32]
    .io_a(ppgs_3_io_a),
    .io_negate(ppgs_3_io_negate),
    .io_partial_product(ppgs_3_io_partial_product)
  );
  ApproxWallaceTree wallace_tree ( // @[src/main/scala/empty/ApproxRadix4Booth8.scala 49:28]
    .io_shifted_partial_products_0(wallace_tree_io_shifted_partial_products_0),
    .io_shifted_partial_products_1(wallace_tree_io_shifted_partial_products_1),
    .io_shifted_partial_products_2(wallace_tree_io_shifted_partial_products_2),
    .io_shifted_partial_products_3(wallace_tree_io_shifted_partial_products_3),
    .io_final_product(wallace_tree_io_final_product)
  );
  assign io_product = wallace_tree_io_final_product; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 51:14]
  assign encoders_0_io_b_bits = b_extended[2:0]; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 21:40]
  assign encoders_1_io_b_bits = b_extended[4:2]; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 21:40]
  assign encoders_2_io_b_bits = b_extended[6:4]; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 21:40]
  assign encoders_3_io_b_bits = b_extended[8:6]; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 21:40]
  assign ppgs_0_io_a = io_multiplicand; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 24:18]
  assign ppgs_0_io_negate = encoders_0_io_negate; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 25:23]
  assign ppgs_1_io_a = io_multiplicand; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 24:18]
  assign ppgs_1_io_negate = encoders_1_io_negate; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 25:23]
  assign ppgs_2_io_a = io_multiplicand; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 24:18]
  assign ppgs_2_io_negate = encoders_2_io_negate; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 25:23]
  assign ppgs_3_io_a = io_multiplicand; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 24:18]
  assign ppgs_3_io_negate = encoders_3_io_negate; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 25:23]
  assign wallace_tree_io_shifted_partial_products_0 = {{6{pp_final[9]}},pp_final}; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 17:30 45:25]
  assign wallace_tree_io_shifted_partial_products_1 = {{4{_partial_products_1_T[11]}},_partial_products_1_T}; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 17:30 45:25]
  assign wallace_tree_io_shifted_partial_products_2 = {{2{_partial_products_2_T[13]}},_partial_products_2_T}; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 17:30 45:25]
  assign wallace_tree_io_shifted_partial_products_3 = {$signed(pp_final_3), 6'h0}; // @[src/main/scala/empty/ApproxRadix4Booth8.scala 45:37]
endmodule
