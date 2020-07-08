/////////////////////////////////////////////////////////////////////////
// 单位: 南京航空航天大学-计算机科学与技术学院
// 作者:陈明富
//
// Create Date:   2019/7/4
// Design Name:   单周期COU
// Module Name: DM.v
/////////////////////////////////////////////////////////////////////////
module dm_4k( address,DMop,Bitop,din, we, clk, dout ) ;
 input [11:0] address ;
 input DMop;
 input Bitop;
input [31:0] din ; 
 input we ; 
 input clk ;
 wire[7:0] dout_bit;
 output reg [31:0] dout ;
 wire[31:0]dout_word; 
 reg [31:0] dm[0:1023];
reg[1:0]  pos  ;
Mux4_8R  mux4_1r(clk,pos,dm[address][7:0],dm[address][15:8],dm[address][23:16],dm[address][31:24],dout_bit) ;  
SignExtend8 ex(Bitop,dout_bit,dout_word);	 
always@(clk)
	 begin 
	 pos   = {address[1:0] };
     if(we)
		 begin
		     if(DMop)
		     begin
		            dm[address] <= din;
		      end
		     else 
			         //Mux4_8W  mux4_1w(clk,pos,din,dm[addr][0:7],dm[addr][8:15],dm[addr][16:23],dm[addr][24:31]) ;
	         case(pos)
                 2'b00:  dm[address[11:2]]  =   {dm[address[11:2]][31:8],din[7:0] };
				 2'b01:  dm[address[11:2]]  =   {dm[address[11:2]][31:16],din[7:0],dm[address[11:2]][7:0] };
				 2'b10:  dm[address[11:2]]  =   {dm[address[11:2]][31:25],din[7:0],dm[address[11:2]][15:0] };
                 2'b11:  dm[address[11:2]]  =   {din[7:0],dm[address[11:2]][23:0] };
             endcase
		 end
		// 读内存
		else
		  if(DMop)
		      begin
                   dout <= dm[address[11:2]];
		      end
		  else
               dout <= dout_word;
    end

endmodule



























/*module dm_4k( address,DMop,Bitop,din, we, clk, dout ) ;
 input [11:0] address ;
 input DMop;
 input Bitop;
input [31:0] din ; 
 input we ; 
 input clk ;
 wire[7:0] dout_bit;
 output reg [31:0] dout ;
 wire[31:0]dout_word; 
 reg [31:0] dm[0:1023];
reg[11:2] addr  ;
reg[1:0]  pos  ;
Mux4_8R  mux4_1r(clk,pos,dm[addr][7:0],dm[addr][15:8],dm[addr][23:16],dm[addr][31:24],dout_bit) ;  
SignExtend8 ex(Bitop,dout_bit,dout_word);	 
always@(clk)
	 begin 
	 addr  = {address[11:2] };
	 pos   = {address[1:0] };
     if(we)
		 begin
		     if(DMop)
		     begin
		            dm[address] <= din;
		      end
		     else 
			         //Mux4_8W  mux4_1w(clk,pos,din,dm[addr][0:7],dm[addr][8:15],dm[addr][16:23],dm[addr][24:31]) ;
	         case(pos)
                 2'b00:  dm[address[11:2]]  =   {dm[address[11:2]][31:8],din[7:0] };
				 2'b01:  dm[address[11:2]]  =   {dm[address[11:2]][31:16],din[7:0],dm[address[11:2]][7:0] };
				 2'b10:  dm[address[11:2]]  =   {dm[address[11:2]][31:25],din[7:0],dm[address[11:2]][15:0] };
                 2'b11:  dm[address[11:2]]  =   {din[7:0],dm[address[11:2]][23:0] };
             endcase
		 end
		// 读内存
		else
		  if(DMop)
		      begin
                   dout <= dm[address[11:2]];
		      end
		  else
               dout <= dout_word;
    end

endmodule
*/