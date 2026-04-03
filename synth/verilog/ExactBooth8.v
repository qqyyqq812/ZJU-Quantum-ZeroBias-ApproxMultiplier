// =============================================================================
// ExactBooth8.v - 精确 Radix-4 Booth 乘法器 (8x8 → 16-bit)
// 对照组：所有 4 行均使用精确编码 (含 two 信号)
// =============================================================================

module ExactBooth8(
  input  [7:0]  io_a,
  input  [7:0]  io_b,
  output [15:0] io_product
);

  wire signed [7:0]  a_s = io_a;
  wire signed [15:0] exact_product = $signed(io_a) * $signed(io_b);
  
  assign io_product = exact_product;

endmodule
