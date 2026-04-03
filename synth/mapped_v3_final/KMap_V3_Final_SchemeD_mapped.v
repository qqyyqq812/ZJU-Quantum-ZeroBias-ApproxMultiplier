/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : V-2023.12-SP3
// Date      : Thu Apr  2 22:56:23 2026
/////////////////////////////////////////////////////////////


module KMap_V3_Final_SchemeD ( clock, reset, io_a, io_b, io_product );
  input [7:0] io_a;
  input [7:0] io_b;
  output [15:0] io_product;
  input clock, reset;
  wire   \intadd_1/A[11] , \intadd_1/A[10] , \intadd_1/A[9] , \intadd_1/A[8] ,
         \intadd_1/A[7] , \intadd_1/A[6] , \intadd_1/A[5] , \intadd_1/A[4] ,
         \intadd_1/A[3] , \intadd_1/A[2] , \intadd_1/A[1] , \intadd_1/A[0] ,
         \intadd_1/B[11] , \intadd_1/B[10] , \intadd_1/B[9] , \intadd_1/B[8] ,
         \intadd_1/B[7] , \intadd_1/B[6] , \intadd_1/B[5] , \intadd_1/B[4] ,
         \intadd_1/B[3] , \intadd_1/B[2] , \intadd_1/B[1] , \intadd_1/B[0] ,
         \intadd_1/CI , \intadd_1/n12 , \intadd_1/n11 , \intadd_1/n10 ,
         \intadd_1/n9 , \intadd_1/n8 , \intadd_1/n7 , \intadd_1/n6 ,
         \intadd_1/n5 , \intadd_1/n4 , \intadd_1/n3 , \intadd_1/n2 ,
         \intadd_1/n1 , n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40,
         n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54,
         n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68,
         n69, n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n80, n81, n82,
         n83, n84, n85, n86, n87, n88, n89, n90, n91, n92, n93, n94, n95, n96,
         n97, n98, n99, n100, n101, n102, n103, n104, n105, n106, n107, n108,
         n109, n110, n111, n112, n113, n114, n115, n116, n117, n118, n119,
         n120, n121, n122, n123, n124, n125, n126, n127, n128;
  assign io_product[14] = io_product[15];

  FA_X1 \intadd_1/U13  ( .A(\intadd_1/A[0] ), .B(\intadd_1/B[0] ), .CI(
        \intadd_1/CI ), .CO(\intadd_1/n12 ), .S(io_product[2]) );
  FA_X1 \intadd_1/U12  ( .A(\intadd_1/A[1] ), .B(\intadd_1/B[1] ), .CI(
        \intadd_1/n12 ), .CO(\intadd_1/n11 ), .S(io_product[3]) );
  FA_X1 \intadd_1/U11  ( .A(\intadd_1/A[2] ), .B(\intadd_1/B[2] ), .CI(
        \intadd_1/n11 ), .CO(\intadd_1/n10 ), .S(io_product[4]) );
  FA_X1 \intadd_1/U10  ( .A(\intadd_1/A[3] ), .B(\intadd_1/B[3] ), .CI(
        \intadd_1/n10 ), .CO(\intadd_1/n9 ), .S(io_product[5]) );
  FA_X1 \intadd_1/U9  ( .A(\intadd_1/A[4] ), .B(\intadd_1/B[4] ), .CI(
        \intadd_1/n9 ), .CO(\intadd_1/n8 ), .S(io_product[6]) );
  FA_X1 \intadd_1/U8  ( .A(\intadd_1/A[5] ), .B(\intadd_1/B[5] ), .CI(
        \intadd_1/n8 ), .CO(\intadd_1/n7 ), .S(io_product[7]) );
  FA_X1 \intadd_1/U7  ( .A(\intadd_1/A[6] ), .B(\intadd_1/B[6] ), .CI(
        \intadd_1/n7 ), .CO(\intadd_1/n6 ), .S(io_product[8]) );
  FA_X1 \intadd_1/U6  ( .A(\intadd_1/A[7] ), .B(\intadd_1/B[7] ), .CI(
        \intadd_1/n6 ), .CO(\intadd_1/n5 ), .S(io_product[9]) );
  FA_X1 \intadd_1/U5  ( .A(\intadd_1/A[8] ), .B(\intadd_1/B[8] ), .CI(
        \intadd_1/n5 ), .CO(\intadd_1/n4 ), .S(io_product[10]) );
  FA_X1 \intadd_1/U4  ( .A(\intadd_1/A[9] ), .B(\intadd_1/B[9] ), .CI(
        \intadd_1/n4 ), .CO(\intadd_1/n3 ), .S(io_product[11]) );
  FA_X1 \intadd_1/U3  ( .A(\intadd_1/A[10] ), .B(\intadd_1/B[10] ), .CI(
        \intadd_1/n3 ), .CO(\intadd_1/n2 ), .S(io_product[12]) );
  FA_X1 \intadd_1/U2  ( .A(\intadd_1/A[11] ), .B(\intadd_1/B[11] ), .CI(
        \intadd_1/n2 ), .CO(\intadd_1/n1 ), .S(io_product[13]) );
  INV_X1 U68 ( .A(io_b[3]), .ZN(n31) );
  AOI21_X1 U69 ( .B1(io_b[1]), .B2(io_b[2]), .A(n31), .ZN(\intadd_1/A[0] ) );
  INV_X1 U70 ( .A(io_b[5]), .ZN(n30) );
  AOI21_X1 U71 ( .B1(io_b[3]), .B2(io_b[4]), .A(n30), .ZN(n80) );
  INV_X1 U72 ( .A(n80), .ZN(n99) );
  OAI21_X1 U73 ( .B1(io_b[3]), .B2(io_b[4]), .A(n30), .ZN(n100) );
  INV_X1 U74 ( .A(n100), .ZN(n81) );
  INV_X1 U75 ( .A(io_a[0]), .ZN(n122) );
  AOI22_X1 U76 ( .A1(io_a[0]), .A2(n81), .B1(n80), .B2(n122), .ZN(n35) );
  OAI21_X1 U77 ( .B1(io_b[1]), .B2(io_b[2]), .A(n31), .ZN(n79) );
  INV_X1 U78 ( .A(\intadd_1/A[0] ), .ZN(n78) );
  INV_X1 U79 ( .A(io_a[1]), .ZN(n53) );
  AOI22_X1 U80 ( .A1(io_a[1]), .A2(n79), .B1(n78), .B2(n53), .ZN(n119) );
  NAND2_X1 U81 ( .A1(io_b[1]), .A2(io_b[0]), .ZN(n124) );
  INV_X1 U82 ( .A(io_b[1]), .ZN(n127) );
  NAND2_X1 U83 ( .A1(n127), .A2(io_b[0]), .ZN(n59) );
  INV_X1 U84 ( .A(n59), .ZN(n126) );
  NOR2_X1 U85 ( .A1(io_b[0]), .A2(n127), .ZN(n60) );
  INV_X1 U86 ( .A(io_a[2]), .ZN(n66) );
  AOI22_X1 U87 ( .A1(io_a[3]), .A2(n126), .B1(n60), .B2(n66), .ZN(n32) );
  OAI21_X1 U88 ( .B1(io_a[3]), .B2(n124), .A(n32), .ZN(n118) );
  NAND2_X1 U89 ( .A1(n119), .A2(n118), .ZN(n34) );
  INV_X1 U90 ( .A(n33), .ZN(\intadd_1/B[2] ) );
  FA_X1 U91 ( .A(n99), .B(n35), .CI(n34), .CO(n36), .S(n33) );
  INV_X1 U92 ( .A(n36), .ZN(\intadd_1/B[3] ) );
  AOI22_X1 U93 ( .A1(io_a[1]), .A2(n100), .B1(n99), .B2(n53), .ZN(n38) );
  INV_X1 U94 ( .A(io_a[3]), .ZN(n77) );
  AOI22_X1 U95 ( .A1(io_a[3]), .A2(n79), .B1(n78), .B2(n77), .ZN(n37) );
  NAND2_X1 U96 ( .A1(n37), .A2(n38), .ZN(n50) );
  OAI21_X1 U97 ( .B1(n38), .B2(n37), .A(n50), .ZN(n44) );
  INV_X1 U98 ( .A(n60), .ZN(n110) );
  OAI22_X1 U99 ( .A1(io_a[4]), .A2(n110), .B1(io_a[5]), .B2(n124), .ZN(n39) );
  AOI21_X1 U100 ( .B1(n126), .B2(io_a[5]), .A(n39), .ZN(n43) );
  AOI22_X1 U101 ( .A1(io_a[2]), .A2(n79), .B1(n78), .B2(n66), .ZN(n117) );
  AOI22_X1 U102 ( .A1(n126), .A2(io_a[4]), .B1(n60), .B2(n77), .ZN(n40) );
  OAI21_X1 U103 ( .B1(io_a[4]), .B2(n124), .A(n40), .ZN(n116) );
  NAND2_X1 U104 ( .A1(n117), .A2(n116), .ZN(n42) );
  INV_X1 U105 ( .A(n41), .ZN(\intadd_1/A[3] ) );
  FA_X1 U106 ( .A(n44), .B(n43), .CI(n42), .CO(n45), .S(n41) );
  INV_X1 U107 ( .A(n45), .ZN(\intadd_1/B[4] ) );
  INV_X1 U108 ( .A(n79), .ZN(n112) );
  INV_X1 U109 ( .A(io_a[4]), .ZN(n93) );
  AOI22_X1 U110 ( .A1(io_a[4]), .A2(n112), .B1(\intadd_1/A[0] ), .B2(n93), 
        .ZN(n58) );
  OAI22_X1 U111 ( .A1(io_a[5]), .A2(n110), .B1(io_a[6]), .B2(n124), .ZN(n46)
         );
  AOI21_X1 U112 ( .B1(n126), .B2(io_a[6]), .A(n46), .ZN(n57) );
  AOI22_X1 U113 ( .A1(io_a[2]), .A2(n81), .B1(n80), .B2(n66), .ZN(n56) );
  INV_X1 U114 ( .A(io_b[7]), .ZN(n47) );
  OAI21_X1 U115 ( .B1(io_b[5]), .B2(io_b[6]), .A(n47), .ZN(n109) );
  INV_X1 U116 ( .A(n109), .ZN(n115) );
  AOI21_X1 U117 ( .B1(io_b[5]), .B2(io_b[6]), .A(n47), .ZN(n114) );
  OAI21_X1 U118 ( .B1(n115), .B2(n114), .A(io_a[0]), .ZN(n49) );
  INV_X1 U119 ( .A(n48), .ZN(\intadd_1/A[4] ) );
  FA_X1 U120 ( .A(n51), .B(n50), .CI(n49), .CO(n52), .S(n48) );
  INV_X1 U121 ( .A(n52), .ZN(\intadd_1/B[5] ) );
  INV_X1 U122 ( .A(io_a[5]), .ZN(n98) );
  AOI22_X1 U123 ( .A1(io_a[5]), .A2(n79), .B1(n78), .B2(n98), .ZN(n55) );
  INV_X1 U124 ( .A(n114), .ZN(n108) );
  AOI22_X1 U125 ( .A1(io_a[1]), .A2(n109), .B1(n108), .B2(n53), .ZN(n54) );
  NAND2_X1 U126 ( .A1(n54), .A2(n55), .ZN(n82) );
  OAI21_X1 U127 ( .B1(n55), .B2(n54), .A(n82), .ZN(n64) );
  FA_X1 U128 ( .A(n58), .B(n57), .CI(n56), .CO(n63), .S(n51) );
  AOI22_X1 U129 ( .A1(io_a[3]), .A2(n81), .B1(n80), .B2(n77), .ZN(n69) );
  INV_X1 U130 ( .A(io_a[6]), .ZN(n107) );
  INV_X1 U131 ( .A(io_a[7]), .ZN(n113) );
  AOI22_X1 U132 ( .A1(io_a[7]), .A2(n59), .B1(n127), .B2(n113), .ZN(n84) );
  AOI22_X1 U133 ( .A1(n60), .A2(n107), .B1(n84), .B2(n110), .ZN(n68) );
  NAND2_X1 U134 ( .A1(n114), .A2(n122), .ZN(n67) );
  INV_X1 U135 ( .A(n61), .ZN(\intadd_1/A[5] ) );
  FA_X1 U136 ( .A(n64), .B(n63), .CI(n62), .CO(n65), .S(n61) );
  INV_X1 U137 ( .A(n65), .ZN(\intadd_1/B[6] ) );
  AOI22_X1 U138 ( .A1(io_a[2]), .A2(n115), .B1(n114), .B2(n66), .ZN(n83) );
  FA_X1 U139 ( .A(n69), .B(n68), .CI(n67), .CO(n74), .S(n62) );
  AOI22_X1 U140 ( .A1(io_a[6]), .A2(n79), .B1(n78), .B2(n107), .ZN(n71) );
  AOI22_X1 U141 ( .A1(io_a[4]), .A2(n100), .B1(n99), .B2(n93), .ZN(n70) );
  NOR2_X1 U142 ( .A1(n71), .A2(n70), .ZN(n86) );
  AOI21_X1 U143 ( .B1(n71), .B2(n70), .A(n86), .ZN(n73) );
  INV_X1 U144 ( .A(n72), .ZN(\intadd_1/A[6] ) );
  FA_X1 U145 ( .A(n75), .B(n74), .CI(n73), .CO(n76), .S(n72) );
  INV_X1 U146 ( .A(n76), .ZN(\intadd_1/B[7] ) );
  AOI22_X1 U147 ( .A1(io_a[3]), .A2(n115), .B1(n114), .B2(n77), .ZN(n92) );
  AOI22_X1 U148 ( .A1(io_a[7]), .A2(n79), .B1(n78), .B2(n113), .ZN(n91) );
  AOI22_X1 U149 ( .A1(io_a[5]), .A2(n81), .B1(n80), .B2(n98), .ZN(n90) );
  FA_X1 U150 ( .A(n84), .B(n83), .CI(n82), .CO(n87), .S(n75) );
  INV_X1 U151 ( .A(n85), .ZN(\intadd_1/A[7] ) );
  FA_X1 U152 ( .A(n88), .B(n87), .CI(n86), .CO(n89), .S(n85) );
  INV_X1 U153 ( .A(n89), .ZN(\intadd_1/B[8] ) );
  AOI22_X1 U154 ( .A1(io_a[6]), .A2(n100), .B1(n99), .B2(n107), .ZN(n101) );
  FA_X1 U155 ( .A(n92), .B(n91), .CI(n90), .CO(n96), .S(n88) );
  AOI22_X1 U156 ( .A1(io_a[4]), .A2(n115), .B1(n114), .B2(n93), .ZN(n95) );
  INV_X1 U157 ( .A(n94), .ZN(\intadd_1/A[8] ) );
  FA_X1 U158 ( .A(n101), .B(n96), .CI(n95), .CO(n97), .S(n94) );
  INV_X1 U159 ( .A(n97), .ZN(\intadd_1/B[9] ) );
  AOI22_X1 U160 ( .A1(io_a[5]), .A2(n115), .B1(n114), .B2(n98), .ZN(n105) );
  AOI22_X1 U161 ( .A1(io_a[7]), .A2(n100), .B1(n99), .B2(n113), .ZN(n104) );
  INV_X1 U162 ( .A(n101), .ZN(n103) );
  INV_X1 U163 ( .A(n102), .ZN(\intadd_1/A[9] ) );
  FA_X1 U164 ( .A(n105), .B(n104), .CI(n103), .CO(n106), .S(n102) );
  INV_X1 U165 ( .A(n106), .ZN(\intadd_1/B[10] ) );
  AOI22_X1 U166 ( .A1(io_a[6]), .A2(n109), .B1(n108), .B2(n107), .ZN(
        \intadd_1/B[11] ) );
  INV_X1 U167 ( .A(\intadd_1/B[11] ), .ZN(\intadd_1/A[10] ) );
  INV_X1 U168 ( .A(\intadd_1/n1 ), .ZN(io_product[15]) );
  OAI22_X1 U169 ( .A1(io_a[2]), .A2(n124), .B1(io_a[1]), .B2(n110), .ZN(n111)
         );
  AOI21_X1 U170 ( .B1(io_a[2]), .B2(n126), .A(n111), .ZN(n120) );
  AOI22_X1 U171 ( .A1(io_a[0]), .A2(n112), .B1(\intadd_1/A[0] ), .B2(n122), 
        .ZN(n121) );
  NOR2_X1 U172 ( .A1(n120), .A2(n121), .ZN(\intadd_1/B[1] ) );
  AOI22_X1 U173 ( .A1(io_a[7]), .A2(n115), .B1(n114), .B2(n113), .ZN(
        \intadd_1/A[11] ) );
  XOR2_X1 U174 ( .A(n117), .B(n116), .Z(\intadd_1/A[2] ) );
  XOR2_X1 U175 ( .A(n119), .B(n118), .Z(\intadd_1/A[1] ) );
  AOI211_X1 U176 ( .C1(io_b[0]), .C2(io_a[1]), .A(io_a[0]), .B(n127), .ZN(
        \intadd_1/B[0] ) );
  AOI21_X1 U177 ( .B1(n121), .B2(n120), .A(\intadd_1/B[1] ), .ZN(\intadd_1/CI ) );
  INV_X1 U178 ( .A(io_b[0]), .ZN(n123) );
  NOR2_X1 U179 ( .A1(n123), .A2(n122), .ZN(io_product[0]) );
  NOR2_X1 U180 ( .A1(io_a[1]), .A2(n124), .ZN(n125) );
  AOI21_X1 U181 ( .B1(n126), .B2(io_a[1]), .A(n125), .ZN(n128) );
  AOI221_X1 U182 ( .B1(io_product[0]), .B2(n128), .C1(n127), .C2(n128), .A(
        \intadd_1/B[0] ), .ZN(io_product[1]) );
endmodule

