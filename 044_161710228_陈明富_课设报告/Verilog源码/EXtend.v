//16位->32位
module Extend16(
input Extop,
input [15:0] immediate,
 output [31:0] extendImmediate 
);
assign extendImmediate[15:0] = immediate;
assign extendImmediate[31:16] = Extop ? (immediate[15] ? 16'hffff : 16'h0000) : 16'h0000;
endmodule

