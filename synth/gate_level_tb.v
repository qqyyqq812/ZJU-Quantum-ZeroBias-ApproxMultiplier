// =============================================================================
// gate_level_tb.v - 门级网表功能验证 Testbench
// 用 iverilog 验证 Yosys/ABC 综合后的网表功能正确性
// =============================================================================
`timescale 1ns/1ps

module gate_level_tb;
  reg  [7:0] a, b;
  wire [15:0] exact_out, approx_barc_out, approx_nobrc_out;
  
  // 精确乘法器 (门级网表)
  ExactBooth8 u_exact (
    .io_a(a), .io_b(b), .io_product(exact_out)
  );
  
  // 近似 + BARC (门级网表)
  RegularBooth8 u_barc (
    .clock(1'b0), .reset(1'b0),
    .io_a(a), .io_b(b), .io_product(approx_barc_out)
  );
  
  // 近似 无补偿 (门级网表)
  RegularBooth8NoBRC u_nobrc (
    .clock(1'b0), .reset(1'b0),
    .io_a(a), .io_b(b), .io_product(approx_nobrc_out)
  );
  
  // 参考: Verilog 原生乘法
  wire signed [15:0] golden = $signed(a) * $signed(b);
  
  integer i, j;
  integer exact_errors, barc_errors, nobrc_errors;
  integer exact_match, barc_total_err, nobrc_total_err;
  
  initial begin
    exact_errors = 0;
    barc_errors = 0;
    nobrc_errors = 0;
    barc_total_err = 0;
    nobrc_total_err = 0;
    
    // 全遍历 256x256
    for (i = 0; i < 256; i = i + 1) begin
      for (j = 0; j < 256; j = j + 1) begin
        a = i[7:0];
        b = j[7:0];
        #1;
        
        // 1) 验证精确门级 = golden
        if (exact_out !== golden) begin
          exact_errors = exact_errors + 1;
          if (exact_errors <= 5)
            $display("EXACT MISMATCH: a=%d b=%d got=%d exp=%d", 
                     $signed(a), $signed(b), $signed(exact_out), golden);
        end
        
        // 2) 统计 BARC 误差
        if (approx_barc_out !== golden) begin
          barc_errors = barc_errors + 1;
          barc_total_err = barc_total_err + ($signed(approx_barc_out) - golden);
        end
        
        // 3) 统计 NoBRC 误差
        if (approx_nobrc_out !== golden) begin
          nobrc_errors = nobrc_errors + 1;
          nobrc_total_err = nobrc_total_err + ($signed(approx_nobrc_out) - golden);
        end
      end
    end
    
    $display("============================================================");
    $display("Gate-Level Verification Results (65536 tests)");
    $display("============================================================");
    $display("ExactBooth8:        Errors = %0d  (should be 0)", exact_errors);
    $display("RegularBooth8 BARC: Errors = %0d  Mean Error = %0d/65536", 
             barc_errors, barc_total_err);
    $display("RegularBooth8NoBRC: Errors = %0d  Mean Error = %0d/65536", 
             nobrc_errors, nobrc_total_err);
    $display("============================================================");
    
    if (exact_errors == 0)
      $display(">> ExactBooth8 gate-level: PASS");
    else
      $display(">> ExactBooth8 gate-level: FAIL");
    
    if (barc_total_err == 0)
      $display(">> RegularBooth8 BARC Zero-Bias: PASS (total_error = 0)");
    else
      $display(">> RegularBooth8 BARC Zero-Bias: FAIL (total_error = %0d)", barc_total_err);

    $finish;
  end
endmodule
