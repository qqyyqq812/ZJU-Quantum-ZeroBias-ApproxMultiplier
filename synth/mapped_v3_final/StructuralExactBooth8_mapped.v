/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : V-2023.12-SP3
// Date      : Thu Apr  2 22:56:21 2026
/////////////////////////////////////////////////////////////


module ExactEncoder_3 ( io_b_bits, io_neg, io_zero, io_two, io_one );
  input [2:0] io_b_bits;
  output io_neg, io_zero, io_two, io_one;
  wire   n2;
  assign io_neg = io_b_bits[2];
  assign io_one = io_b_bits[1];

  NOR2_X1 U1 ( .A1(io_b_bits[1]), .A2(n2), .ZN(io_two) );
  INV_X1 U2 ( .A(io_b_bits[2]), .ZN(n2) );
  NOR2_X1 U3 ( .A1(io_b_bits[1]), .A2(io_b_bits[2]), .ZN(io_zero) );
endmodule


module ExactEncoder_2 ( io_b_bits, io_neg, io_zero, io_two, io_one );
  input [2:0] io_b_bits;
  output io_neg, io_zero, io_two, io_one;
  wire   n1, n2, n3;
  assign io_neg = io_b_bits[2];

  NAND2_X1 U1 ( .A1(io_b_bits[0]), .A2(io_b_bits[1]), .ZN(n2) );
  OR2_X1 U2 ( .A1(io_b_bits[0]), .A2(io_b_bits[1]), .ZN(n3) );
  AND2_X1 U3 ( .A1(n2), .A2(n3), .ZN(io_one) );
  INV_X1 U4 ( .A(io_b_bits[2]), .ZN(n1) );
  AOI22_X1 U5 ( .A1(io_b_bits[2]), .A2(n2), .B1(n3), .B2(n1), .ZN(io_zero) );
  AOI22_X1 U6 ( .A1(io_b_bits[2]), .A2(n3), .B1(n2), .B2(n1), .ZN(io_two) );
endmodule


module ExactEncoder_0 ( io_b_bits, io_neg, io_zero, io_two, io_one );
  input [2:0] io_b_bits;
  output io_neg, io_zero, io_two, io_one;
  wire   n1, n2, n3;
  assign io_neg = io_b_bits[2];

  NAND2_X1 U1 ( .A1(io_b_bits[0]), .A2(io_b_bits[1]), .ZN(n2) );
  OR2_X1 U2 ( .A1(io_b_bits[0]), .A2(io_b_bits[1]), .ZN(n3) );
  AND2_X1 U3 ( .A1(n2), .A2(n3), .ZN(io_one) );
  INV_X1 U4 ( .A(io_b_bits[2]), .ZN(n1) );
  AOI22_X1 U5 ( .A1(io_b_bits[2]), .A2(n2), .B1(n3), .B2(n1), .ZN(io_zero) );
  AOI22_X1 U6 ( .A1(io_b_bits[2]), .A2(n3), .B1(n2), .B2(n1), .ZN(io_two) );
endmodule


module ExactEncoder_1 ( io_b_bits, io_neg, io_zero, io_two, io_one );
  input [2:0] io_b_bits;
  output io_neg, io_zero, io_two, io_one;
  wire   n1, n2, n3;
  assign io_neg = io_b_bits[2];

  NAND2_X1 U1 ( .A1(io_b_bits[0]), .A2(io_b_bits[1]), .ZN(n2) );
  OR2_X1 U2 ( .A1(io_b_bits[0]), .A2(io_b_bits[1]), .ZN(n3) );
  AND2_X1 U3 ( .A1(n2), .A2(n3), .ZN(io_one) );
  INV_X1 U4 ( .A(io_b_bits[2]), .ZN(n1) );
  AOI22_X1 U5 ( .A1(io_b_bits[2]), .A2(n2), .B1(n3), .B2(n1), .ZN(io_zero) );
  AOI22_X1 U6 ( .A1(io_b_bits[2]), .A2(n3), .B1(n2), .B2(n1), .ZN(io_two) );
endmodule


module StructuralExactBooth8 ( clock, reset, io_a, io_b, io_product );
  input [7:0] io_a;
  input [7:0] io_b;
  output [15:0] io_product;
  input clock, reset;
  wire   encoders_0_io_zero, encoders_0_io_neg, encoders_0_io_one,
         encoders_0_io_two, encoders_1_io_zero, encoders_1_io_neg,
         encoders_1_io_one, encoders_1_io_two, encoders_2_io_zero,
         encoders_2_io_neg, encoders_2_io_one, encoders_2_io_two,
         encoders_3_io_zero, encoders_3_io_neg, encoders_3_io_one,
         encoders_3_io_two, \intadd_0/A[12] , \intadd_0/A[7] , \intadd_0/A[6] ,
         \intadd_0/A[5] , \intadd_0/A[1] , \intadd_0/B[12] , \intadd_0/B[7] ,
         \intadd_0/B[6] , \intadd_0/B[5] , \intadd_0/B[0] , \intadd_0/CI ,
         \intadd_0/n13 , \intadd_0/n12 , \intadd_0/n9 , \intadd_0/n8 ,
         \intadd_0/n7 , \intadd_0/n6 , \intadd_0/n2 , \intadd_0/n1 , n45, n46,
         n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60,
         n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74,
         n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88,
         n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100, n101,
         n102, n103, n104, n105, n106, n107, n108, n109, n110, n111, n112,
         n113, n114, n115, n116, n117, n118, n119, n120, n121, n122, n123,
         n124, n125, n126, n127, n128, n129, n130, n131, n132, n133, n134,
         n135, n136, n137, n138, n139, n140, n141, n142, n143, n144, n145,
         n146, n147, n148, n149, n150, n151, n152, n153, n154, n155, n156,
         n157, n158, n159, n160, n161, n162, n163, n164, n165, n166, n167,
         n168, n169, n170, n171, n172, n173, n174, n175, n176, n177, n178,
         n179, n180, n181, n182, n183, n184, n185, n186, n187, n188, n189,
         n190, n191, n192, n193, n194, n195, n196, n197, n198, n199, n200,
         n201, n202, n203, n204, n205, n206, n207, n208, n209, n210, n211,
         n212, n213, n214, n215, n216, n217, n218, n219, n220, n221, n222,
         n223, n224, n225, n226, n227, n228, n229, n230, n231, n232, n233,
         n234, n235, net704;

  ExactEncoder_3 encoders_0 ( .io_b_bits({io_b[1:0], net704}), .io_neg(
        encoders_0_io_neg), .io_zero(encoders_0_io_zero), .io_two(
        encoders_0_io_two), .io_one(encoders_0_io_one) );
  ExactEncoder_2 encoders_1 ( .io_b_bits(io_b[3:1]), .io_neg(encoders_1_io_neg), .io_zero(encoders_1_io_zero), .io_two(encoders_1_io_two), .io_one(
        encoders_1_io_one) );
  ExactEncoder_1 encoders_2 ( .io_b_bits(io_b[5:3]), .io_neg(encoders_2_io_neg), .io_zero(encoders_2_io_zero), .io_two(encoders_2_io_two), .io_one(
        encoders_2_io_one) );
  ExactEncoder_0 encoders_3 ( .io_b_bits(io_b[7:5]), .io_neg(encoders_3_io_neg), .io_zero(encoders_3_io_zero), .io_two(encoders_3_io_two), .io_one(
        encoders_3_io_one) );
  FA_X1 \intadd_0/U14  ( .A(n235), .B(\intadd_0/CI ), .CI(\intadd_0/B[0] ), 
        .CO(\intadd_0/n13 ), .S(io_product[2]) );
  FA_X1 \intadd_0/U13  ( .A(\intadd_0/A[1] ), .B(n223), .CI(\intadd_0/n13 ), 
        .CO(\intadd_0/n12 ), .S(io_product[3]) );
  FA_X1 \intadd_0/U9  ( .A(\intadd_0/A[5] ), .B(\intadd_0/B[5] ), .CI(
        \intadd_0/n9 ), .CO(\intadd_0/n8 ), .S(io_product[7]) );
  FA_X1 \intadd_0/U8  ( .A(\intadd_0/A[6] ), .B(\intadd_0/B[6] ), .CI(
        \intadd_0/n8 ), .CO(\intadd_0/n7 ), .S(io_product[8]) );
  FA_X1 \intadd_0/U7  ( .A(\intadd_0/A[7] ), .B(\intadd_0/B[7] ), .CI(
        \intadd_0/n7 ), .CO(\intadd_0/n6 ), .S(io_product[9]) );
  FA_X1 \intadd_0/U2  ( .A(\intadd_0/A[12] ), .B(\intadd_0/B[12] ), .CI(
        \intadd_0/n2 ), .CO(\intadd_0/n1 ), .S(io_product[14]) );
  AND3_X1 U87 ( .A1(n136), .A2(n135), .A3(n134), .ZN(n154) );
  OAI21_X1 U88 ( .B1(n46), .B2(n109), .A(n108), .ZN(\intadd_0/n2 ) );
  AND3_X1 U89 ( .A1(n100), .A2(n99), .A3(n98), .ZN(n109) );
  OAI21_X1 U90 ( .B1(n154), .B2(n45), .A(n153), .ZN(\intadd_0/n9 ) );
  NOR2_X1 U91 ( .A1(n151), .A2(n152), .ZN(n45) );
  NOR2_X1 U92 ( .A1(n106), .A2(n107), .ZN(n46) );
  NAND2_X1 U93 ( .A1(n152), .A2(n151), .ZN(n153) );
  NAND2_X1 U94 ( .A1(n107), .A2(n106), .ZN(n108) );
  XNOR2_X1 U95 ( .A(n154), .B(n150), .ZN(io_product[6]) );
  INV_X1 U96 ( .A(encoders_1_io_zero), .ZN(n47) );
  NAND2_X1 U97 ( .A1(n47), .A2(encoders_1_io_neg), .ZN(n141) );
  INV_X1 U98 ( .A(n141), .ZN(n235) );
  NOR2_X1 U99 ( .A1(encoders_3_io_zero), .A2(encoders_3_io_neg), .ZN(n220) );
  INV_X1 U100 ( .A(encoders_3_io_zero), .ZN(n148) );
  NAND2_X1 U101 ( .A1(n148), .A2(encoders_3_io_neg), .ZN(n217) );
  INV_X1 U102 ( .A(n217), .ZN(n68) );
  AOI22_X1 U103 ( .A1(encoders_3_io_one), .A2(io_a[7]), .B1(encoders_3_io_two), 
        .B2(io_a[6]), .ZN(n48) );
  MUX2_X1 U104 ( .A(n220), .B(n68), .S(n48), .Z(\intadd_0/B[12] ) );
  NOR2_X1 U105 ( .A1(encoders_2_io_zero), .A2(encoders_2_io_neg), .ZN(n162) );
  INV_X1 U106 ( .A(encoders_2_io_neg), .ZN(n49) );
  NOR2_X1 U107 ( .A1(n49), .A2(encoders_2_io_zero), .ZN(n124) );
  AOI22_X1 U108 ( .A1(io_a[4]), .A2(encoders_2_io_two), .B1(encoders_2_io_one), 
        .B2(io_a[5]), .ZN(n50) );
  MUX2_X1 U109 ( .A(n162), .B(n124), .S(n50), .Z(n63) );
  INV_X1 U110 ( .A(n63), .ZN(n79) );
  AOI22_X1 U111 ( .A1(encoders_2_io_one), .A2(io_a[6]), .B1(encoders_2_io_two), 
        .B2(io_a[5]), .ZN(n52) );
  INV_X1 U112 ( .A(n124), .ZN(n159) );
  NAND2_X1 U113 ( .A1(n52), .A2(n159), .ZN(n51) );
  OAI21_X1 U114 ( .B1(n162), .B2(n52), .A(n51), .ZN(n78) );
  AOI22_X1 U115 ( .A1(io_a[3]), .A2(encoders_3_io_two), .B1(io_a[4]), .B2(
        encoders_3_io_one), .ZN(n54) );
  NAND2_X1 U116 ( .A1(n54), .A2(n217), .ZN(n53) );
  OAI21_X1 U117 ( .B1(n220), .B2(n54), .A(n53), .ZN(n77) );
  NOR2_X1 U118 ( .A1(encoders_1_io_zero), .A2(encoders_1_io_neg), .ZN(n197) );
  AOI22_X1 U119 ( .A1(encoders_1_io_one), .A2(io_a[7]), .B1(encoders_1_io_two), 
        .B2(io_a[6]), .ZN(n56) );
  NAND2_X1 U120 ( .A1(n56), .A2(n141), .ZN(n55) );
  OAI21_X1 U121 ( .B1(n197), .B2(n56), .A(n55), .ZN(n62) );
  AOI22_X1 U122 ( .A1(io_a[2]), .A2(encoders_3_io_two), .B1(io_a[3]), .B2(
        encoders_3_io_one), .ZN(n58) );
  NAND2_X1 U123 ( .A1(n58), .A2(n217), .ZN(n57) );
  OAI21_X1 U124 ( .B1(n220), .B2(n58), .A(n57), .ZN(n61) );
  OAI21_X1 U125 ( .B1(encoders_1_io_one), .B2(encoders_1_io_two), .A(io_a[7]), 
        .ZN(n59) );
  MUX2_X1 U126 ( .A(n197), .B(n235), .S(n59), .Z(n83) );
  INV_X1 U127 ( .A(n60), .ZN(n200) );
  NAND2_X1 U128 ( .A1(\intadd_0/n6 ), .A2(n200), .ZN(n75) );
  FA_X1 U129 ( .A(n63), .B(n62), .CI(n61), .CO(n84), .S(n169) );
  NOR2_X1 U130 ( .A1(encoders_0_io_zero), .A2(encoders_0_io_neg), .ZN(n230) );
  INV_X1 U131 ( .A(encoders_0_io_neg), .ZN(n227) );
  NOR2_X1 U132 ( .A1(encoders_0_io_zero), .A2(n227), .ZN(n128) );
  OAI21_X1 U133 ( .B1(encoders_0_io_two), .B2(encoders_0_io_one), .A(io_a[7]), 
        .ZN(n64) );
  MUX2_X1 U134 ( .A(n230), .B(n128), .S(n64), .Z(n156) );
  AOI22_X1 U135 ( .A1(io_a[2]), .A2(encoders_3_io_one), .B1(io_a[1]), .B2(
        encoders_3_io_two), .ZN(n66) );
  NAND2_X1 U136 ( .A1(n66), .A2(n217), .ZN(n65) );
  OAI21_X1 U137 ( .B1(n220), .B2(n66), .A(n65), .ZN(n155) );
  AOI22_X1 U138 ( .A1(io_a[1]), .A2(encoders_3_io_one), .B1(io_a[0]), .B2(
        encoders_3_io_two), .ZN(n67) );
  MUX2_X1 U139 ( .A(n220), .B(n68), .S(n67), .Z(n172) );
  AOI22_X1 U140 ( .A1(encoders_1_io_one), .A2(io_a[5]), .B1(encoders_1_io_two), 
        .B2(io_a[4]), .ZN(n69) );
  MUX2_X1 U141 ( .A(n197), .B(n235), .S(n69), .Z(n173) );
  NAND2_X1 U142 ( .A1(n172), .A2(n173), .ZN(n171) );
  AOI22_X1 U143 ( .A1(encoders_1_io_one), .A2(io_a[6]), .B1(encoders_1_io_two), 
        .B2(io_a[5]), .ZN(n70) );
  MUX2_X1 U144 ( .A(n197), .B(n235), .S(n70), .Z(n165) );
  AOI22_X1 U145 ( .A1(io_a[3]), .A2(encoders_2_io_two), .B1(io_a[4]), .B2(
        encoders_2_io_one), .ZN(n71) );
  MUX2_X1 U146 ( .A(n162), .B(n124), .S(n71), .Z(n164) );
  NOR2_X1 U147 ( .A1(n165), .A2(n164), .ZN(n167) );
  INV_X1 U148 ( .A(n72), .ZN(n199) );
  NAND2_X1 U149 ( .A1(\intadd_0/n6 ), .A2(n199), .ZN(n74) );
  NAND2_X1 U150 ( .A1(n200), .A2(n199), .ZN(n73) );
  NAND3_X1 U151 ( .A1(n75), .A2(n74), .A3(n73), .ZN(n206) );
  AOI22_X1 U152 ( .A1(encoders_2_io_one), .A2(io_a[7]), .B1(encoders_2_io_two), 
        .B2(io_a[6]), .ZN(n76) );
  MUX2_X1 U153 ( .A(n162), .B(n124), .S(n76), .Z(n95) );
  FA_X1 U154 ( .A(n79), .B(n78), .CI(n77), .CO(n91), .S(n85) );
  AOI22_X1 U155 ( .A1(io_a[4]), .A2(encoders_3_io_two), .B1(encoders_3_io_one), 
        .B2(io_a[5]), .ZN(n81) );
  NAND2_X1 U156 ( .A1(n81), .A2(n217), .ZN(n80) );
  OAI21_X1 U157 ( .B1(n220), .B2(n81), .A(n80), .ZN(n90) );
  INV_X1 U158 ( .A(n82), .ZN(n208) );
  NAND2_X1 U159 ( .A1(n206), .A2(n208), .ZN(n89) );
  FA_X1 U160 ( .A(n85), .B(n84), .CI(n83), .CO(n86), .S(n60) );
  INV_X1 U161 ( .A(n86), .ZN(n207) );
  NAND2_X1 U162 ( .A1(n206), .A2(n207), .ZN(n88) );
  NAND2_X1 U163 ( .A1(n208), .A2(n207), .ZN(n87) );
  NAND3_X1 U164 ( .A1(n89), .A2(n88), .A3(n87), .ZN(n210) );
  FA_X1 U165 ( .A(n95), .B(n91), .CI(n90), .CO(n92), .S(n82) );
  INV_X1 U166 ( .A(n92), .ZN(n211) );
  NAND2_X1 U167 ( .A1(n210), .A2(n211), .ZN(n100) );
  AOI22_X1 U168 ( .A1(encoders_3_io_one), .A2(io_a[6]), .B1(encoders_3_io_two), 
        .B2(io_a[5]), .ZN(n94) );
  NAND2_X1 U169 ( .A1(n94), .A2(n217), .ZN(n93) );
  OAI21_X1 U170 ( .B1(n220), .B2(n94), .A(n93), .ZN(n103) );
  INV_X1 U171 ( .A(n95), .ZN(n102) );
  OAI21_X1 U172 ( .B1(encoders_2_io_one), .B2(encoders_2_io_two), .A(io_a[7]), 
        .ZN(n96) );
  MUX2_X1 U173 ( .A(n162), .B(n124), .S(n96), .Z(n101) );
  INV_X1 U174 ( .A(n97), .ZN(n212) );
  NAND2_X1 U175 ( .A1(n210), .A2(n212), .ZN(n99) );
  NAND2_X1 U176 ( .A1(n212), .A2(n211), .ZN(n98) );
  FA_X1 U177 ( .A(n103), .B(n102), .CI(n101), .CO(n104), .S(n97) );
  INV_X1 U178 ( .A(n104), .ZN(n107) );
  INV_X1 U179 ( .A(\intadd_0/B[12] ), .ZN(n106) );
  XOR2_X1 U180 ( .A(n107), .B(n106), .Z(n105) );
  XNOR2_X1 U181 ( .A(n109), .B(n105), .ZN(io_product[13]) );
  NAND2_X1 U182 ( .A1(io_a[0]), .A2(encoders_2_io_one), .ZN(n110) );
  INV_X1 U183 ( .A(n110), .ZN(n111) );
  AOI22_X1 U184 ( .A1(n111), .A2(n162), .B1(n124), .B2(n110), .ZN(n121) );
  AOI22_X1 U185 ( .A1(encoders_1_io_one), .A2(io_a[1]), .B1(encoders_1_io_two), 
        .B2(io_a[0]), .ZN(n112) );
  MUX2_X1 U186 ( .A(n197), .B(n235), .S(n112), .Z(n222) );
  AOI22_X1 U187 ( .A1(io_a[2]), .A2(encoders_0_io_two), .B1(io_a[3]), .B2(
        encoders_0_io_one), .ZN(n113) );
  MUX2_X1 U188 ( .A(n230), .B(n128), .S(n113), .Z(n221) );
  NAND2_X1 U189 ( .A1(n222), .A2(n221), .ZN(n120) );
  INV_X1 U190 ( .A(n114), .ZN(n215) );
  NAND2_X1 U191 ( .A1(\intadd_0/n12 ), .A2(n215), .ZN(n119) );
  AOI22_X1 U192 ( .A1(encoders_1_io_one), .A2(io_a[2]), .B1(io_a[1]), .B2(
        encoders_1_io_two), .ZN(n115) );
  MUX2_X1 U193 ( .A(n197), .B(n235), .S(n115), .Z(n132) );
  AOI22_X1 U194 ( .A1(encoders_0_io_two), .A2(io_a[3]), .B1(encoders_0_io_one), 
        .B2(io_a[4]), .ZN(n116) );
  MUX2_X1 U195 ( .A(n230), .B(n128), .S(n116), .Z(n131) );
  XOR2_X1 U196 ( .A(n132), .B(n131), .Z(n214) );
  NAND2_X1 U197 ( .A1(\intadd_0/n12 ), .A2(n214), .ZN(n118) );
  NAND2_X1 U198 ( .A1(n215), .A2(n214), .ZN(n117) );
  NAND3_X1 U199 ( .A1(n119), .A2(n118), .A3(n117), .ZN(n202) );
  FA_X1 U200 ( .A(n159), .B(n121), .CI(n120), .CO(n122), .S(n114) );
  INV_X1 U201 ( .A(n122), .ZN(n203) );
  NAND2_X1 U202 ( .A1(n202), .A2(n203), .ZN(n136) );
  AOI22_X1 U203 ( .A1(io_a[1]), .A2(encoders_2_io_one), .B1(io_a[0]), .B2(
        encoders_2_io_two), .ZN(n123) );
  MUX2_X1 U204 ( .A(n162), .B(n124), .S(n123), .Z(n127) );
  AOI22_X1 U205 ( .A1(encoders_1_io_one), .A2(io_a[3]), .B1(io_a[2]), .B2(
        encoders_1_io_two), .ZN(n125) );
  MUX2_X1 U206 ( .A(n197), .B(n235), .S(n125), .Z(n126) );
  NAND2_X1 U207 ( .A1(n126), .A2(n127), .ZN(n186) );
  OAI21_X1 U208 ( .B1(n127), .B2(n126), .A(n186), .ZN(n139) );
  AOI22_X1 U209 ( .A1(encoders_0_io_two), .A2(io_a[4]), .B1(encoders_0_io_one), 
        .B2(io_a[5]), .ZN(n130) );
  INV_X1 U210 ( .A(n128), .ZN(n231) );
  NAND2_X1 U211 ( .A1(n130), .A2(n231), .ZN(n129) );
  OAI21_X1 U212 ( .B1(n230), .B2(n130), .A(n129), .ZN(n138) );
  NAND2_X1 U213 ( .A1(n132), .A2(n131), .ZN(n137) );
  INV_X1 U214 ( .A(n133), .ZN(n204) );
  NAND2_X1 U215 ( .A1(n202), .A2(n204), .ZN(n135) );
  NAND2_X1 U216 ( .A1(n204), .A2(n203), .ZN(n134) );
  FA_X1 U217 ( .A(n139), .B(n138), .CI(n137), .CO(n140), .S(n133) );
  INV_X1 U218 ( .A(n140), .ZN(n151) );
  AOI22_X1 U219 ( .A1(encoders_1_io_one), .A2(io_a[4]), .B1(encoders_1_io_two), 
        .B2(io_a[3]), .ZN(n143) );
  NAND2_X1 U220 ( .A1(n143), .A2(n141), .ZN(n142) );
  OAI21_X1 U221 ( .B1(n197), .B2(n143), .A(n142), .ZN(n176) );
  AOI22_X1 U222 ( .A1(encoders_0_io_two), .A2(io_a[5]), .B1(encoders_0_io_one), 
        .B2(io_a[6]), .ZN(n145) );
  NAND2_X1 U223 ( .A1(n145), .A2(n231), .ZN(n144) );
  OAI21_X1 U224 ( .B1(n230), .B2(n145), .A(n144), .ZN(n175) );
  AOI22_X1 U225 ( .A1(io_a[2]), .A2(encoders_2_io_one), .B1(io_a[1]), .B2(
        encoders_2_io_two), .ZN(n147) );
  NAND2_X1 U226 ( .A1(n147), .A2(n159), .ZN(n146) );
  OAI21_X1 U227 ( .B1(n162), .B2(n147), .A(n146), .ZN(n174) );
  NAND3_X1 U228 ( .A1(io_a[0]), .A2(encoders_3_io_one), .A3(n148), .ZN(n185)
         );
  INV_X1 U229 ( .A(n149), .ZN(n152) );
  XOR2_X1 U230 ( .A(n151), .B(n152), .Z(n150) );
  FA_X1 U231 ( .A(n156), .B(n155), .CI(n171), .CO(n168), .S(n183) );
  AOI22_X1 U232 ( .A1(encoders_0_io_two), .A2(io_a[6]), .B1(encoders_0_io_one), 
        .B2(io_a[7]), .ZN(n158) );
  NAND2_X1 U233 ( .A1(n158), .A2(n231), .ZN(n157) );
  OAI21_X1 U234 ( .B1(n230), .B2(n158), .A(n157), .ZN(n179) );
  AOI22_X1 U235 ( .A1(io_a[2]), .A2(encoders_2_io_two), .B1(io_a[3]), .B2(
        encoders_2_io_one), .ZN(n161) );
  NAND2_X1 U236 ( .A1(n161), .A2(n159), .ZN(n160) );
  OAI21_X1 U237 ( .B1(n162), .B2(n161), .A(n160), .ZN(n178) );
  AOI21_X1 U238 ( .B1(io_a[0]), .B2(encoders_3_io_one), .A(n217), .ZN(n163) );
  INV_X1 U239 ( .A(n163), .ZN(n177) );
  AOI21_X1 U240 ( .B1(n165), .B2(n164), .A(n167), .ZN(n181) );
  INV_X1 U241 ( .A(n166), .ZN(\intadd_0/B[7] ) );
  FA_X1 U242 ( .A(n169), .B(n168), .CI(n167), .CO(n72), .S(n170) );
  INV_X1 U243 ( .A(n170), .ZN(\intadd_0/A[7] ) );
  OAI21_X1 U244 ( .B1(n173), .B2(n172), .A(n171), .ZN(n191) );
  FA_X1 U245 ( .A(n176), .B(n175), .CI(n174), .CO(n190), .S(n187) );
  FA_X1 U246 ( .A(n179), .B(n178), .CI(n177), .CO(n182), .S(n189) );
  INV_X1 U247 ( .A(n180), .ZN(\intadd_0/B[6] ) );
  FA_X1 U248 ( .A(n183), .B(n182), .CI(n181), .CO(n166), .S(n184) );
  INV_X1 U249 ( .A(n184), .ZN(\intadd_0/A[6] ) );
  FA_X1 U250 ( .A(n187), .B(n186), .CI(n185), .CO(n188), .S(n149) );
  INV_X1 U251 ( .A(n188), .ZN(\intadd_0/B[5] ) );
  FA_X1 U252 ( .A(n191), .B(n190), .CI(n189), .CO(n180), .S(n192) );
  INV_X1 U253 ( .A(n192), .ZN(\intadd_0/A[5] ) );
  AOI22_X1 U254 ( .A1(io_a[2]), .A2(encoders_0_io_one), .B1(io_a[1]), .B2(
        encoders_0_io_two), .ZN(n193) );
  NAND2_X1 U255 ( .A1(n193), .A2(n231), .ZN(n195) );
  OR2_X1 U256 ( .A1(n230), .A2(n193), .ZN(n194) );
  NAND2_X1 U257 ( .A1(n195), .A2(n194), .ZN(n225) );
  NAND2_X1 U258 ( .A1(encoders_1_io_one), .A2(io_a[0]), .ZN(n196) );
  INV_X1 U259 ( .A(n196), .ZN(n198) );
  AOI22_X1 U260 ( .A1(n198), .A2(n197), .B1(n235), .B2(n196), .ZN(n224) );
  NOR2_X1 U261 ( .A1(n225), .A2(n224), .ZN(n223) );
  INV_X1 U262 ( .A(\intadd_0/n1 ), .ZN(io_product[15]) );
  XOR2_X1 U263 ( .A(n200), .B(n199), .Z(n201) );
  XOR2_X1 U264 ( .A(\intadd_0/n6 ), .B(n201), .Z(io_product[10]) );
  XOR2_X1 U265 ( .A(n204), .B(n203), .Z(n205) );
  XOR2_X1 U266 ( .A(n202), .B(n205), .Z(io_product[5]) );
  XOR2_X1 U267 ( .A(n208), .B(n207), .Z(n209) );
  XOR2_X1 U268 ( .A(n206), .B(n209), .Z(io_product[11]) );
  XOR2_X1 U269 ( .A(n212), .B(n211), .Z(n213) );
  XOR2_X1 U270 ( .A(n210), .B(n213), .Z(io_product[12]) );
  XOR2_X1 U271 ( .A(n215), .B(n214), .Z(n216) );
  XOR2_X1 U272 ( .A(\intadd_0/n12 ), .B(n216), .Z(io_product[4]) );
  OAI21_X1 U273 ( .B1(encoders_3_io_one), .B2(encoders_3_io_two), .A(io_a[7]), 
        .ZN(n219) );
  NAND2_X1 U274 ( .A1(n219), .A2(n217), .ZN(n218) );
  OAI21_X1 U275 ( .B1(n220), .B2(n219), .A(n218), .ZN(\intadd_0/A[12] ) );
  XOR2_X1 U276 ( .A(n222), .B(n221), .Z(\intadd_0/A[1] ) );
  AOI21_X1 U277 ( .B1(n225), .B2(n224), .A(n223), .ZN(\intadd_0/B[0] ) );
  NAND2_X1 U278 ( .A1(encoders_0_io_one), .A2(io_a[0]), .ZN(n234) );
  INV_X1 U279 ( .A(n234), .ZN(n233) );
  AOI22_X1 U280 ( .A1(io_a[1]), .A2(encoders_0_io_one), .B1(encoders_0_io_two), 
        .B2(io_a[0]), .ZN(n229) );
  INV_X1 U281 ( .A(n229), .ZN(n226) );
  NOR4_X1 U282 ( .A1(encoders_0_io_zero), .A2(n233), .A3(n227), .A4(n226), 
        .ZN(\intadd_0/CI ) );
  NAND2_X1 U283 ( .A1(n229), .A2(n231), .ZN(n228) );
  OAI21_X1 U284 ( .B1(n230), .B2(n229), .A(n228), .ZN(n232) );
  AOI221_X1 U285 ( .B1(n233), .B2(n232), .C1(n231), .C2(n232), .A(
        \intadd_0/CI ), .ZN(io_product[1]) );
  NOR2_X1 U286 ( .A1(encoders_0_io_zero), .A2(n234), .ZN(io_product[0]) );
endmodule

