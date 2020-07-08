/////////////////////////////////////////////////////////////////////////
// 单位: 南京航空航天大学-计算机科学与技术学院
// 作者:陈明富
//
// Create Date:   2019/7/4
// Design Name:   单周期COU
// Module Name: Ex.v
/////////////////////////////////////////////////////////////////////////
module SignExtend5(
input ExtOp,
input [4:0] immediate,
 output [31:0] extendImmediate 
);
assign extendImmediate[4:0] = immediate;
assign extendImmediate[31:5] = ExtOp ? (immediate[4] ? 27'hffff : 27'h0000) : 27'h0000;
endmodule
//5位->32位

module SignExtend8(
input ExtOp,
input [7:0] immediate,
 output [31:0] extendImmediate 
);
assign extendImmediate[7:0] = immediate;
assign extendImmediate[31:8] = ExtOp ? (immediate[7] ? 24'hffff : 24'h0000) : 24'h0000;
endmodule
//8位->32位


module SignExtend16(
input ExtOp,
input [15:0] immediate,
 output [31:0] extendImmediate 
);
assign extendImmediate[15:0] = immediate;
assign extendImmediate[31:16] = ExtOp ? (immediate[15] ? 16'hffff : 16'h0000) : 16'h0000;
endmodule
//16位->32位