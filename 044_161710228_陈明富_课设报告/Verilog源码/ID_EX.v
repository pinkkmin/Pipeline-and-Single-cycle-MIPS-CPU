module IDEX (clk,flush,stall,RegWr_in,RegDst_in,ALUsrc_in,MemWr_in,MemRead_in,Extop_in,MemToReg_in,Bitop_in,Branch_in,Jump_in,
ALUop_in,rs_in,rt_in,rd_in,target_in,imm16_in,inst_in,busA_in,busB_in,
RegWr_out,RegDst_out,ALUsrc_out,MemWr_out,MemRead_out,Extop_out,MemToReg_out,Bitop_out,Branch_out,Jump_out,
ALUop_out,rs_out,rt_out,rd_out,target_out,imm16_out,inst_out,busA_out,busB_out
);

input         clk;//时钟信号
input         flush;//清空
input         stall; //阻塞     
////Input：
input  RegWr_in;
input  RegDst_in;
input  ALUsrc_in;
input  MemWr_in;
input  MemRead_in;
input  Extop_in;
input  MemToReg_in;
input  Bitop_in;
input  Branch_in;
input  Jump_in;
input  [4:0]  ALUop_in;
input  [4:0]  rs_in ;
input  [4:0]  rt_in;
input  [4:0]  rd_in;
input  [25:0] target_in; 
input  [15:0] imm16_in;
input  [31:0] inst_in;
input  [31:0] busA_in;
input  [31:0] busB_in;
//// Output:
output reg RegWr_out;
output reg RegDst_out;
output reg ALUsrc_out;
output reg MemWr_out;
output reg MemRead_out;
output reg Extop_out;
output reg MemToReg_out;
output reg Bitop_out;   
output reg Branch_out;
output reg Jump_out;
output reg [4:0] ALUop_out;
output reg [4:0]  rs_out ;
output reg [4:0] rt_out;
output reg [4:0] rd_out;
output reg [25:0] target_out; 
output reg [15:0] imm16_out;
output reg [31:0] inst_out;
output reg [31:0] busA_out;
output reg [31:0] busB_out;

	always@(posedge clk)
     begin
       if ( flush )  //清空信号 
            begin
            RegWr_out  <= 0;
            RegDst_out <= 0;
            ALUsrc_out <= 0;
            MemWr_out <= 0;
            MemRead_out <= 0 ;
            Extop_out <= 0;
            MemToReg_out <= 0;
            Bitop_out <= 0;   
            Branch_out <= 0;
            Jump_out <= 0;
            ALUop_out <= 0;
            rs_out <= 0;
            rd_out <= 0;
            rt_out <= 0;
            target_out <= 0; 
            imm16_out <= 0;
            inst_out <= 0;
            busA_out <= 0;
            busB_out <= 0;
            end
        else if(!stall) //阻塞信号
             begin
                RegWr_out  <= RegWr_in;
                RegDst_out <= RegDst_in;
                ALUsrc_out <= ALUsrc_in;
                MemWr_out <= MemWr_in;
                MemRead_out <= MemRead_in;
                Extop_out <= Extop_in;
                MemToReg_out <= MemToReg_in;
                Bitop_out <= Bitop_in;   
                Branch_out <= Branch_in;
                Jump_out <= Jump_in;
                ALUop_out <= ALUop_in;
                rd_out <= rd_in;
                rs_out <= rs_in;
                rt_out <= rt_in;
                target_out <= target_in; 
                imm16_out <= imm16_in;
                inst_out <= inst_in;
                busA_out <= busA_in;
                busB_out <= busB_in;    
             end
     end
endmodule
   