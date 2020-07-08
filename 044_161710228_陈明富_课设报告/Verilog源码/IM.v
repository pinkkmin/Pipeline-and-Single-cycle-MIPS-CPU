module im_4k(
    input  [11:2] addr,     //  读取指令存储地址
    output [31:0] dout ); //  指令内容
reg[31:0] im[0:1023];       //  指令存储器
initial 
	 begin
		$readmemh("data.txt", im);  //读取文件中的指令 b-2进制 h-16进制
	 end
	 assign dout  = im[addr];
endmodule
