module EXMEM (clk,flush,stall,RegWr_in,RegDst_in,MemWr_in,MemRead_in,MemtoReg_in,Branch_in,Jump_in,Zero_in,Extop_in,Bitop_in,rs_in,rt_in,rd_in,busB_in,Result_in,
RegWr_out,RegDst_out,MemWr_out,MemRead_out,MemtoReg_out,Branch_out,Jump_out,Zero_out,Extop_out,Bitop_out,rs_out,rt_out,rd_out,busB_out,Result_out
);
input clk;
input flush;
input stall;
/////INput
input RegWr_in;
input RegDst_in;
input MemWr_in;
input MemRead_in;
input MemtoReg_in;
input Branch_in;
input Jump_in;
input Zero_in;
input Extop_in;
input Bitop_in;
input [4:0] rs_in;
input [4:0] rt_in;
input [4:0] rd_in;
input [31:0] busB_in;
input [31:0] Result_in;
/////Output
output reg RegWr_out;
output reg RegDst_out;
output reg MemWr_out;
output reg MemRead_out;
output reg MemtoReg_out;
output reg Branch_out;
output reg Jump_out;
output reg Zero_out;
output reg Extop_out;
output reg Bitop_out;
output reg [4:0]rs_out;
output reg [4:0]rt_out;
output reg [4:0]rd_out;
output reg [31:0] busB_out;
output reg [31:0] Result_out;
      
always @(posedge clk )
   begin
      if (flush) //清空
        begin
            RegWr_out <= 0;
            RegDst_out <= 0;
            MemWr_out <= 0;
            MemRead_out <= 0 ;
            MemtoReg_out <= 0;
            Branch_out <= 0;
            Jump_out  <= 0;
            Zero_out  <= 0;
            Extop_out <= 0;
            Bitop_out <= 0;
            rs_out    <= 0;
            rt_out    <= 0;
            rd_out    <= 0;
            busB_out   <= 0;
            Result_out <= 0;
        end
      if(!stall) //非阻塞
        begin
            RegWr_out <= RegWr_in;
             RegDst_out <= RegDst_in;
            MemWr_out <= MemWr_in;
            MemRead_out <= MemRead_in;
            MemtoReg_out <= MemtoReg_in;
            Branch_out <= Branch_in;
            Jump_out  <= Jump_in;
            Zero_out  <= Zero_in;
            Extop_out <= Extop_in;
            Bitop_out <= Bitop_in;
            rs_out   <= rs_in;
            rt_out   <= rt_in;
            rd_out    <= rd_in;
            busB_out  <= busB_in;
            Result_out <= Result_in;
        end
   end 
endmodule