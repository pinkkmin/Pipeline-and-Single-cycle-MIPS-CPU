/////////////////////////////////////////////////////////////////////////
// 单位: 南京航空航天大学-计算机科学与技术学院
// 作者:陈明富
//
// Create Date:   2019/7/4
// Design Name:   单周期COU
// Module Name: mux.v
/////////////////////////////////////////////////////////////////////////
//选择写寄存器 rd or rt
module Mux2_5(
	input MuxOp,
    input [4:0] cin_a,
    input [4:0] cin_b,
    output [4:0] out
    );
assign out = MuxOp ?  cin_b : cin_a;
endmodule

module Mux2_32(
	input MuxOp,
    input [31:0] cin_a,
    input [31:0] cin_b,
    output [31:0] out
    );
assign out = MuxOp ? cin_b : cin_a;
endmodule

module Mux4_8R(clk,Muxop,a,b,c,d,out);
input clk;
input [1:0] Muxop;
input [7:0] a,b,c,d;
output reg [7:0] out;
always@(clk)
	 begin
	 case(Muxop)
                 2'b00:  out <= a;
				 2'b01:  out <= b;
				 2'b10:  out <= c; 
                 2'b11:  out <= d;
     endcase
	 end
endmodule 

module Mux4_8W(clk,Muxop,cin,a,b,c,d);
input clk;
input [1:0] Muxop;
input [7:0] cin;
output reg [7:0] a,b,c,d;
always@(clk)
	 begin
	 case(Muxop)
                 2'b00:  a <= cin ;
				 2'b01:  b<=  cin ;
				 2'b10:  c <= cin ;
                 2'b11:  d <= cin ;
     endcase
	 end
endmodule 