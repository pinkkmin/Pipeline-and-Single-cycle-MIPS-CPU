//选择写寄存器 rd or rt
// 5位2路
module Mux2_5(
	input MuxOp,
    input [4:0] cin_a,
    input [4:0] cin_b,
    output [4:0] out
    );

assign out = MuxOp ?  cin_b : cin_a;

endmodule

//32位2路
module Mux2_32(
	input MuxOp,
    input [31:0] cin_a,
    input [31:0] cin_b,
    output [31:0] out
    );

assign out = MuxOp ? cin_b : cin_a;

endmodule


//32位3路
module Mux3_32(
	input [1:0]  MuxOp,
    input [31:0] cin_a,
    input [31:0] cin_b,
    input [31:0] cin_c,
    output[31:0] out
    );

   reg [31:0] reg_out;

always @( * ) begin
        case (MuxOp)
            2'b00: reg_out = cin_a;
            2'b01: reg_out = cin_b;
            2'b10: reg_out = cin_c;
            default: ;
        endcase             
    end 
    
    assign out =  reg_out;
endmodule

//32位4路
module Mux4_32(
	input [1:0]  MuxOp,
    input [31:0] cin_a,
    input [31:0] cin_b,
    input [31:0] cin_c,
    input [31:0] cin_d,
    output[31:0] out
    );

   reg [31:0] reg_out;

always @( * ) begin
        case ( MuxOp )
            2'b00: reg_out = cin_a;
            2'b01: reg_out = cin_b;
            2'b10: reg_out = cin_c;
            2'b11: reg_out = cin_d;
            default: ;
        endcase             
    end 
    assign out =  reg_out;
endmodule