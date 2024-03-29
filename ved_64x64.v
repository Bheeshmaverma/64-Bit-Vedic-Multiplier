`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Designer Name: Bheeshma Verma
// Create Date: 02.03.2024 17:20:47
// Module Name: ved_64x64
// Project Name: Designing of 64x64 Vedic Multiplier using Verilog
// Target Devices: Artix-7 Nexys 4 DDR FPGA Board
//////////////////////////////////////////////////////////////////////////////////

// 64x64 vedic multiplier
module ved_64x64(a,b,result);
  
  input [63:0] a,b;
  output [127:0] result;
  wire [127:0] result;
  wire [63:0] temp0,temp1,temp2,temp3;
  wire [65:0] temp4,temp5;
  wire [63:0] temp6;
  
  ved_32x32 m0(a[31:0],b[31:0],temp0);
  ved_32x32 m1(a[63:32],b[31:0],temp1);
  ved_32x32 m2(a[31:0],b[63:32],temp2);
  ved_32x32 m3(a[63:32],b[63:32],temp3);
  
  adder_66bit a0({2'b00,temp1},{2'b00,temp2},temp4);
  adder_66bit a1(temp4,{2'b00,32'h00000000,temp0[63:32]},temp5);
  adder_64bit a2(temp3,{2'b00,28'h0000000,temp5[65:32]},temp6);
  
  assign result[31:0] = temp0[31:0];
  assign result[63:32] = temp5[31:0];
  assign result[127:64] = temp6;
  
endmodule

//32x32 vedic multiplier
module ved_32x32(a,b,result);
  
  input [31:0] a,b;
  output [63:0] result;
  wire [63:0] result;
  wire [31:0] temp0,temp1,temp2,temp3;
  wire [33:0] temp4,temp5;
  wire [31:0] temp6;
  
  ved_16x16 m0(a[15:0],b[15:0],temp0);
  ved_16x16 m1(a[31:16],b[15:0],temp1);
  ved_16x16 m2(a[15:0],b[31:16],temp2);
  ved_16x16 m3(a[31:16],b[31:16],temp3);
  
  adder_34bit a0({2'b00,temp1},{2'b00,temp2},temp4);
  adder_34bit a1(temp4,{2'b00,16'h0000,temp0[31:16]},temp5);
  adder_32bit a2(temp3,{2'b00,12'h000,temp5[33:16]},temp6);
  
  assign result[15:0]= temp0[15:0];
  assign result[31:16] = temp5[15:0];
  assign result[63:32] = temp6;
  
endmodule

// 16x16 vedic multi
module ved_16x16(a,b,result);
  
  input [15:0] a,b;
  output [31:0] result;
  wire [31:0] result;
  wire [15:0] temp0,temp1,temp2,temp3;
  wire [17:0] temp4,temp5;
  wire [15:0] temp6;
  
  ved_8x8 m0(a[7:0],b[7:0],temp0);
  ved_8x8 m1(a[15:8],b[7:0],temp1);
  ved_8x8 m2(a[7:0],b[15:8],temp2);
  ved_8x8 m3(a[15:8],b[15:8],temp3);
  
  adder_18bit a0({2'b00,temp1},{2'b00,temp2},temp4);
  adder_18bit a1(temp4,{10'b0000000000,temp0[15:8]},temp5);
  adder_16bit a2(temp3,{6'b000000,temp5[17:8]},temp6);
  
  assign result[7:0] = temp0[7:0];
  assign result[15:8] = temp5[7:0];
  assign result[31:16] = temp6;
  
endmodule

// 8x8 vedic multi
module ved_8x8(a,b,result);
  
  input [7:0] a,b;
  output [15:0] result;
  wire [15:0] result;
  wire [7:0] temp0,temp1,temp2,temp3;
  wire [9:0] temp4,temp5;
  wire [7:0] temp6;
  
  ved_4x4 m0(a[3:0],b[3:0],temp0);
  ved_4x4 m1(a[7:4],b[3:0],temp1);
  ved_4x4 m2(a[3:0],b[7:4],temp2);
  ved_4x4 m3(a[7:4],b[7:4],temp3);
  
  adder_10bit a0({2'b00,temp1},{2'b00,temp2},temp4);
  adder_10bit a1(temp4,{6'b000000,temp0[7:4]},temp5);
  adder_8bit a2(temp3,{2'b00,temp5[9:4]},temp6);
  
  assign result[3:0] = temp0[3:0];
  assign result[7:4] = temp5[3:0];
  assign result[15:8] = temp6;
  
endmodule

// 4x4 vedic multi
module ved_4x4(a,b,result);
  
  input [3:0] a,b;
  output [7:0] result;
  wire [7:0] result;
  
  wire [3:0] temp0,temp1,temp2,temp3;
  wire [5:0] temp4,temp5;
  wire [3:0] temp6;
  
  ved_2x2 m0(a[1:0],b[1:0],temp0);
  ved_2x2 m1(a[3:2],b[1:0],temp1);
  ved_2x2 m2(a[1:0],b[3:2],temp2);
  ved_2x2 m3(a[3:2],b[3:2],temp3);
  
  adder_6bit a0({2'b00,temp1},{2'b00,temp2},temp4);
  adder_6bit a1(temp4,{4'b0000,temp0[3:2]},temp5);
  adder_4bit a2(temp3,temp5[5:2],temp6);
  
  assign result[1:0] = temp0[1:0];
  assign result[3:2] = temp5[1:0];
  assign result[7:4] = temp6;
  
endmodule

// 2x2 vedic multiplier
module ved_2x2(a,b,result);
  
  input [1:0] a,b;
  output [3:0] result;
  wire [3:0] w;
  
  assign result[0] = a[0] & b[0];
  assign w[0] = a[1] & b[0];
  assign w[1] = a[0] & b[1];
  assign w[2] = a[1] & b[1];
  
  half_adder ha0(w[0],w[1],result[1],w[3]);
  half_adder ha1(w[2],w[3],result[2],result[3]);
  
endmodule

// 66 bit adder
module adder_66bit(a,b,s);
  
  input [65:0] a,b;
  output [65:0] s;
  wire [65:0] s;
  
  assign s = a + b;
  
endmodule

// 64 bit adder
module adder_64bit(a,b,s);
  
  input [63:0] a,b;
  output [63:0] s;
  wire [63:0] s;
  
  assign s = a + b;
  
endmodule

// 34 bit adder
module adder_34bit(a,b,s);
  
  input [33:0] a,b;
  output [33:0] s;
  wire [33:0] s;
  
  assign s = a + b;
  
endmodule

// 32 bit adder
module adder_32bit(a,b,s);
  
  input [31:0] a,b;
  output [31:0] s;
  wire [31:0] s;
  
  assign s = a + b;
  
endmodule

// 18 bit adder
module adder_18bit(a,b,s);
  
  input [17:0] a,b;
  output [17:0] s;
  wire [17:0] s;
  
  assign s = a + b;
  
endmodule

// 16 bit adder
module adder_16bit(a,b,s);
  
  input [15:0] a,b;
  output [15:0] s;
  wire [15:0] s;
  
  assign s = a + b;
  
endmodule

// 10 bit adder
module adder_10bit(a,b,s);
  
  input [9:0] a,b;
  output [9:0] s;
  wire [9:0] s;
  
  assign s = a + b;
  
endmodule

// 8 bit adder
module adder_8bit(a,b,s);
  
  input [7:0] a,b;
  output [7:0] s;
  wire [7:0] s;
  
  assign s = a + b;
  
endmodule 

// 6 bit adder
module adder_6bit(a,b,s);
  
  input [5:0] a,b;
  output [5:0] s;
  wire [5:0] s;
  
  assign s = a + b;
  
endmodule

// 4 bit adder
module adder_4bit(a,b,s);
  
  input [3:0] a,b;
  output [3:0] s;
  wire [3:0] s;
  
  assign s = a + b;
  
endmodule

// Half adder module
module half_adder(a,b,s,co);
  
  input a,b;
  output s,co;
  
  assign s = a ^ b;
  assign co = a & b;
  
endmodule