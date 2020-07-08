module MEMWB( clk,stall,
RegWr_in,RegDst_in,MemToReg_in,rt_in,rd_in,Dout_in,Result_in,
RegWr_out,RegDst_out,MemToReg_out,rt_out,rd_out,Dout_out,Result_out
);

input  clk;
input  stall;
////Input 
input RegWr_in; //Regfile写
input RegDst_in;//选择rd或者rt
input MemToReg_in;//选择写Reg的内容
input [4:0] rt_in;
input [4:0] rd_in;
input [31:0]  Dout_in; //DM读出的内容
input  [31:0] Result_in; //ALU计算结果，DM地址或者Reg待写内容 
////Output
output reg RegWr_out;
output reg RegDst_out;
output reg MemToReg_out;
output reg [4:0] rt_out;
output reg [4:0] rd_out;
output reg [31:0] Dout_out;
output reg [31:0] Result_out;

 always @(posedge clk )
  begin
     if(stall)
         begin
         RegWr_out <= 0;
         RegDst_out <= 0;
         MemToReg_out <= 0;
         rt_out <= 0;
         rd_out <= 0;
         Dout_out <= 0;
         Result_out <= 0;
         end
      else 
         begin
         RegWr_out <= RegWr_in;
         RegDst_out <= RegDst_in;
         MemToReg_out <= MemToReg_in;
         rt_out <= rt_in;
         rd_out <= rd_in;
         Dout_out <= Dout_in;
         Result_out <=Result_in;
         end
  end
endmodule