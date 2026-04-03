// =============================================================================
// nangate45_cells.v - Nangate45 标准单元行为级 Verilog 模型
// 用于 iverilog 门级仿真验证
// Pin 命名遵循 NangateOpenCellLibrary 规范
// =============================================================================

// ── 反相器 ──────────────────────────────────────────────
module INV_X1(input A, output ZN);
  assign ZN = ~A;
endmodule

// ── AND 门 ──────────────────────────────────────────────
module AND2_X1(input A1, A2, output ZN);
  assign ZN = A1 & A2;
endmodule

module AND3_X1(input A1, A2, A3, output ZN);
  assign ZN = A1 & A2 & A3;
endmodule

module AND4_X1(input A1, A2, A3, A4, output ZN);
  assign ZN = A1 & A2 & A3 & A4;
endmodule

// ── OR 门 ───────────────────────────────────────────────
module OR2_X1(input A1, A2, output ZN);
  assign ZN = A1 | A2;
endmodule

module OR3_X1(input A1, A2, A3, output ZN);
  assign ZN = A1 | A2 | A3;
endmodule

module OR4_X1(input A1, A2, A3, A4, output ZN);
  assign ZN = A1 | A2 | A3 | A4;
endmodule

// ── NAND 门 ─────────────────────────────────────────────
module NAND2_X1(input A1, A2, output ZN);
  assign ZN = ~(A1 & A2);
endmodule

module NAND3_X1(input A1, A2, A3, output ZN);
  assign ZN = ~(A1 & A2 & A3);
endmodule

module NAND4_X1(input A1, A2, A3, A4, output ZN);
  assign ZN = ~(A1 & A2 & A3 & A4);
endmodule

// ── NOR 门 ──────────────────────────────────────────────
module NOR2_X1(input A1, A2, output ZN);
  assign ZN = ~(A1 | A2);
endmodule

module NOR3_X1(input A1, A2, A3, output ZN);
  assign ZN = ~(A1 | A2 | A3);
endmodule

module NOR4_X1(input A1, A2, A3, A4, output ZN);
  assign ZN = ~(A1 | A2 | A3 | A4);
endmodule

// ── XOR / XNOR ─────────────────────────────────────────
module XOR2_X1(input A, B, output Z);
  assign Z = A ^ B;
endmodule

module XNOR2_X1(input A, B, output ZN);
  assign ZN = ~(A ^ B);
endmodule

// ── MUX ─────────────────────────────────────────────────
module MUX2_X1(input A, B, S, output Z);
  assign Z = S ? B : A;
endmodule

// ── AOI (AND-OR-Invert) ─────────────────────────────────
// AOI21: ~((A & B1) | B2)  → NangateOpenCellLibrary 定义
module AOI21_X1(input A, B1, B2, output ZN);
  assign ZN = ~((B1 & B2) | A);
endmodule

module AOI22_X1(input A1, A2, B1, B2, output ZN);
  assign ZN = ~((A1 & A2) | (B1 & B2));
endmodule

module AOI211_X1(input A, B, C1, C2, output ZN);
  assign ZN = ~(A | B | (C1 & C2));
endmodule

module AOI221_X1(input A, B1, B2, C1, C2, output ZN);
  assign ZN = ~(A | (B1 & B2) | (C1 & C2));
endmodule

// ── OAI (OR-AND-Invert) ─────────────────────────────────
module OAI21_X1(input A, B1, B2, output ZN);
  assign ZN = ~((B1 | B2) & A);
endmodule

module OAI22_X1(input A1, A2, B1, B2, output ZN);
  assign ZN = ~((A1 | A2) & (B1 | B2));
endmodule

module OAI211_X1(input A, B, C1, C2, output ZN);
  assign ZN = ~(A & B & (C1 | C2));
endmodule
