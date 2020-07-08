module dm_4k( addr,Bitop,Extop,din, we,MemRead, clk, dout ) ;
input [11:0] addr ;
input Bitop;        // 判断是否进行字节的读写
input Extop;        // bit读时扩展
input MemRead;      // 读使能
input [31:0] din ;  // 待写数据
input we;           //写使能
input clk ;
output reg [31:0] dout ;  //输出数据  bit时候需要进行位扩展
reg [31:0] dm[0:1023];
reg [1:0] pos;   //地址的后两位 据此选择bit
reg [7:0] bit;   
reg [31:0] Ext_bit;

always@(clk)
begin 
	 pos <= addr[1:0];
     if(we)
		begin
		     if(!Bitop)
		     begin
		            dm[addr] <= din;
		      end
		     else 
	         case(pos)
                 2'b00:  dm[addr[11:2]]  =   {dm[addr[11:2]][31:8],din[7:0] };
				 2'b01:  dm[addr[11:2]]  =   {dm[addr[11:2]][31:16],din[7:0],dm[addr[11:2]][7:0] };
				 2'b10:  dm[addr[11:2]]  =   {dm[addr[11:2]][31:25],din[7:0],dm[addr[11:2]][15:0] };
                 2'b11:  dm[addr[11:2]]  =   {din[7:0],dm[addr[11:2]][23:0] };
             endcase
		 end
		// 读内存
	else
    begin
		if(MemRead)
		begin
		     if(!Bitop)    dout <= dm[addr[11:2]];
		     else 
		     begin
             case(pos)
                 2'b00:  bit  <=   dm[addr[11:2]][7:0];
				 2'b01:  bit  <=   dm[addr[11:2]][15:8];
				 2'b10:  bit  <=   dm[addr[11:2]][23:16];
                 2'b11:  bit  <=   dm[addr[11:2]][31:24];
			 endcase
                if(Extop)
                      begin 
                           if(bit[7])  Ext_bit <=  {24'hffffff,bit};
                            else
                            Ext_bit <=  {24'h000000,bit};
                       end
              else     Ext_bit =  {24'b0,bit};
              dout <= Ext_bit;
              end
		end
	end	
end

endmodule
