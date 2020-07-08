`include "define_op.v"
module mips(clk, rst) ;
input clk ; // clock
input rst ;// reset
 
 //////PC//////NPC
wire  pc_stall; // 阻塞信号
wire [31:2] Pc,Npc;         
wire        Zero;
////IM_4k
wire [31:0] inst;//指令
wire [5:0] op;  
wire [5:0] func;   
wire [4:0] rd,rt,rs;
wire [15:0] imm16;
wire [25:0] target;
wire  [31:0] imm32;

/////ctrl 此处信号已完整
wire ALUSrc;    //ALU选择    
wire RegWr;    //Regfile写使能
wire RegDst;    //Regfile写地址选择，rd or rt   
wire MemtoReg; //写回结果内容选择  
wire MemWr;   //存储器写使能
wire MemRead; //lw读 
wire Extop;    //符号扩展
wire Branch;  
wire Jump;        
wire Bitop;    //DM的字节   
wire [4:0] ALUop; 

///ALU
wire [4:0]shf;
wire[31:0]  ALUA,ALUB;
wire[31:0]  Result;

/////DM_4k
wire [11:0] dm_addr;
wire [31:0] dm_dout;
////Regfile
wire[4:0] RW;
wire [31:0] busW;
wire [31:0] busA,busB;
////
///IDIF_Reg//////
wire         IFID_flush;//清空
wire         IFID_stall; //阻塞
wire  [31:0] IFID_pc_in; // IFID保存的地址
wire  [31:0] IFID_inst_in;// IFID保存的指令
wire [31:0]  IFID_pc_out;  
wire [31:0]  IFID_inst_out;
///
///IDEX_Reg//////
wire         IDEX_flush;//清空
wire         IDEX_stall; //阻塞     
////Input：
wire   IDEX_RegWr_in;
wire   IDEX_RegDst_in;
wire   IDEX_ALUsrc_in;
wire   IDEX_MemWr_in;
wire   IDEX_MemRead_in;
wire   IDEX_Extop_in;
wire   IDEX_MemToReg_in;
wire   IDEX_IDEX_Bitop_in;
wire   IDEX_Branch_in;
wire   IDEX_Jump_in;
wire   [4:0]  IDEX_ALUop_in;
wire   [4:0]  IDEX_rs_in;
wire   [4:0]  IDEX_rt_in;
wire   [4:0]  IDEX_rd_in;
wire   [25:0] IDEX_target_in; 
wire   [15:0] IDEX_imm16_in;
wire   [31:0] IDEX_inst_in;
wire   [31:0] IDEX_busA_in;
wire   [31:0] IDEX_busB_in;
//// Output:
wire  IDEX_RegWr_out;
wire  IDEX_RegDst_out;
wire  IDEX_ALUsrc_out;
wire  IDEX_MemWr_out;
wire  IDEX_MemRead_out;
wire  IDEX_Extop_out;
wire  IDEX_MemToReg_out;
wire  IDEX_Bitop_out;   
wire  IDEX_Branch_out;
wire  IDEX_Jump_out;
wire  [4:0] IDEX_ALUop_out;
wire   [4:0]  IDEX_rs_out;
wire  [4:0] IDEX_rt_out;
wire  [4:0] IDEX_rd_out;
wire  [25:0] IDEX_target_out; 
wire  [15:0] IDEX_imm16_out;
wire  [31:0] IDEX_inst_out;
wire  [31:0] IDEX_busA_out;
wire  [31:0] IDEX_busB_out;
///
///EXMEM_Reg//////
wire EXMEM_flush;
wire EXMEM_stall;
/////INput
wire EXMEM_RegWr_in;
wire EXMEM_RegDst_in;
wire EXMEM_MemWr_in;
wire EXMEM_MemRead_in;
wire EXMEM_MemtoReg_in;
wire EXMEM_Branch_in;
wire EXMEM_Jump_in;
wire EXMEM_Zero_in;
wire EXMEM_Extop_in;
wire EXMEM_Bitop_in;
wire [4:0] EXMEM_rs_in;
wire [4:0] EXMEM_rt_in;
wire [4:0] EXMEM_rd_in;
wire [31:0] EXMEM_busB_in;
wire [31:0] EXMEM_Result_in;
/////Output
wire EXMEM_RegWr_out;
wire EXMEM_RegDst_out;
wire EXMEM_MemWr_out;
wire EXMEM_Read_out;
wire EXMEM_MemtoReg_out;
wire EXMEM_Branch_out;
wire EXMEM_Jump_out;
wire EXMEM_Zero_out;
wire EXMEM_Extop_out;
wire EXMEM_Bitop_out;
wire [4:0] EXMEM_rs_out;
wire [4:0] EXMEM_rt_out;
wire [4:0] EXMEM_rd_out;
wire [31:0]  EXMEM_busB_out;
wire [31:0]  EXMEM_Result_out;
////
//////MEMWR_Reg/////
wire MEMWR_stall;
////Input 
wire MEMWR_RegWr_in; //Regfile写
wire MEMWR_RegDst_in;//选择rd或者rt
wire MEMWR_MemToReg_in;//选择写Reg的内容
wire [4:0] MEMWR_rt_in;
wire [4:0] MEMWR_rd_in;
wire [31:0]  MEMWR_Dout_in; //DM读出数据
wire  [31:0] MEMWR_Result_in; //DM地址或者Reg待写内容 
////Output
wire MEMWR_RegWr_out;
wire MEMWR_RegDst_out;
wire MEMWR_MemToReg_out;
wire [4:0] MEMWR_rt_out;
wire [4:0] MEMWR_rd_out;
wire [31:0] MEMWR_Dout_out;
wire [31:0] MEMWR_Result_out;
////
wire [5:0] haza_op;
wire Haza_Jump;
wire Haza_Sign;


//IF阶段
PC PC_(clk,rst,pc_stall,Npc,Pc);
im_4k im(Pc,inst); 
NPC NPC_(Pc,Zero,Branch,Jump,target,imm16,Npc); 
assign  haza_op = inst[31:26];
assign  Haza_Jump = haza_op==`J? 1 : 0;
assign  Haza_Sign = ((busA==busB&&haza_op==`BEQ)||(busA!=busB&&haza_op==`BNE)||(busA<=0&&haza_op==`BLEZ)||(busA>0&&haza_op==`BGTZ)||(haza_op== 6'b000001&&rt==`BGEZ_Rt&&busA>=0)||(haza_op== 6'b000001&&rt==`BLTZ_Rt&&busA<0)) ? 1: 0 ;
///处理分支冒险
Ctrl_Hazar ctr_hazar(clk,Haza_Sign,Haza_Jump,pc_stall,IFID_flush);

///****IFID_Reg*****
assign  IFID_pc_in  = Pc ; // IFID保存的地址
assign  IFID_inst_in = inst;// IFID保存的指令
IFID IFID_(clk,IFID_flush,IFID_stall,IFID_pc_in ,IFID_inst_in, IFID_pc_out,IFID_inst_out);
///

//ID阶段
assign op = IFID_inst_out[31:26];
assign func = IFID_inst_out[5:0];
assign rt = IFID_inst_out[20:16];
assign rs = IFID_inst_out[25:21];
assign rd = IFID_inst_out[15:11];
assign shf = IFID_inst_out[10:6];   //逻辑左右移，算术右移的shf
assign imm16 = IFID_inst_out[15:0];
assign target = IFID_inst_out[25:0];
Ctrl ctrl_(op,func,rt,ALUSrc,RegWr,RegDst,MemtoReg,MemWr,MemRead,Extop,Branch,Jump,Bitop,ALUop);

///****IDEX_Reg*****
assign   IDEX_RegWr_in = RegWr ;
assign   IDEX_RegDst_in = RegDst;
assign   IDEX_ALUsrc_in = ALUSrc;
assign   IDEX_MemWr_in = MemWr;
assign   IDEX_MemRead_in = MemRead;
assign   IDEX_Extop_in = Extop;
assign   IDEX_MemToReg_in  = MemtoReg;
assign   IDEX_Bitop_in = Bitop;
assign   IDEX_Branch_in = Branch;
assign   IDEX_Jump_in = Jump;
assign   IDEX_ALUop_in = ALUop;
assign   IDEX_rs_in = rs;
assign   IDEX_rt_in = rt;
assign   IDEX_rd_in  = rd;
assign   IDEX_target_in = target; 
assign   IDEX_imm16_in = imm16;
assign   IDEX_inst_in = IFID_inst_out;
assign   IDEX_busA_in = busA;
assign   IDEX_busB_in = busB;
//
assign IDEX_flush= 0;
assign IDEX_stall = 0;
IDEX IDEX_(clk,IDEX_flush,IDEX_stall,
IDEX_RegWr_in,IDEX_RegDst_in,IDEX_ALUsrc_in,IDEX_MemWr_in,IDEX_MemRead_in,IDEX_Extop_in,IDEX_MemToReg_in,IDEX_Bitop_in,IDEX_Branch_in,IDEX_Jump_in,
IDEX_ALUop_in,IDEX_rs_in,IDEX_rt_in,IDEX_rd_in,IDEX_target_in,IDEX_imm16_in,IDEX_inst_in,IDEX_busA_in,IDEX_busB_in,
IDEX_RegWr_out,IDEX_RegDst_out,IDEX_ALUsrc_out,IDEX_MemWr_out,IDEX_MemRead_out,IDEX_Extop_out,IDEX_MemToReg_out,IDEX_Bitop_out,IDEX_Branch_out,IDEX_Jump_out,
IDEX_ALUop_out,IDEX_rs_out,IDEX_rt_out,IDEX_rd_out,IDEX_target_out,IDEX_imm16_out,IDEX_inst_out,IDEX_busA_out,IDEX_busB_out
);
///

//EX阶段
//assign ALUA = IDEX_busA_out;
Extend16 Ex(IDEX_Extop_out,IDEX_imm16_out,imm32); 
//Mux2_32 Mux_ALUB(IDEX_ALUsrc_out,IDEX_busB_out,imm32,ALUB); //选择ALUB输入端
Alu ALU_(ALUA,ALUB,IDEX_ALUop_out,shf,Result,Zero);

///****EXMEM_Reg*****
assign EXMEM_RegWr_in = IDEX_RegWr_out;
assign EXMEM_RegDst_in = IDEX_RegDst_out ;
assign EXMEM_MemWr_in = IDEX_MemWr_out;
assign EXMEM_MemRead_in = IDEX_MemRead_out;
assign EXMEM_MemtoReg_in = IDEX_MemToReg_out;
assign EXMEM_Branch_in = IDEX_Branch_out;
assign EXMEM_Jump_in = IDEX_Jump_out;
assign EXMEM_Zero_in = Zero;
assign EXMEM_Extop_in = IDEX_Extop_out;
assign EXMEM_Bitop_in = IDEX_Bitop_out;
assign EXMEM_rs_in = IDEX_rs_out;
assign EXMEM_rt_in = IDEX_rt_out;
assign EXMEM_rd_in = IDEX_rd_out;
assign EXMEM_busB_in = IDEX_busB_out;
assign EXMEM_Result_in = Result;

assign EXMEM_flush= 0;
assign EXMEM_stall = 0;
EXMEM EXMEM_(clk,EXMEM_flush,EXMEM_stall,
EXMEM_RegWr_in,EXMEM_RegDst_in,EXMEM_MemWr_in,EXMEM_MemRead_in,EXMEM_MemtoReg_in,EXMEM_Branch_in,EXMEM_Jump_in,EXMEM_Zero_in,EXMEM_Extop_in,EXMEM_Bitop_in,
EXMEM_rs_in,EXMEM_rt_in,EXMEM_rd_in,EXMEM_busB_in,EXMEM_Result_in,
EXMEM_RegWr_out,EXMEM_RegDst_out,EXMEM_MemWr_out,EXMEM_MemRead_out,EXMEM_MemtoReg_out,EXMEM_Branch_out,EXMEM_Jump_out,EXMEM_Zero_out,EXMEM_Extop_out,EXMEM_Bitop_out,
EXMEM_rs_out,EXMEM_rt_out,EXMEM_rd_out,EXMEM_busB_out,EXMEM_Result_out
);
///

////Mem阶段
assign dm_addr = EXMEM_Result_out;
 dm_4k dm( dm_addr,EXMEM_Bitop_out,EXMEM_Extop_out,EXMEM_busB_out, EXMEM_MemWr_out,EXMEM_MemRead_out, clk, dm_dout) ;
////

///****MEMWR_Reg*****
assign MEMWR_RegWr_in = EXMEM_RegWr_out; 
assign MEMWR_RegDst_in = EXMEM_RegDst_out;
assign MEMWR_MemToReg_in = EXMEM_MemtoReg_out;
assign MEMWR_rt_in = EXMEM_rt_out;
assign MEMWR_rd_in = EXMEM_rd_out;
assign MEMWR_Dout_in = dm_dout ; 
assign MEMWR_Result_in = EXMEM_Result_out ; 

assign MEMWR_stall = 1'b0;
MEMWB MEMWB( clk,MEMWR_stall,
MEMWR_RegWr_in,MEMWR_RegDst_in,MEMWR_MemToReg_in,MEMWR_rt_in,MEMWR_rd_in,MEMWR_Dout_in,MEMWR_Result_in,
MEMWR_RegWr_out,MEMWR_RegDst_out,MEMWR_MemToReg_out,MEMWR_rt_out,MEMWR_rd_out,MEMWR_Dout_out,MEMWR_Result_out);
///
///WB写回阶段//////
Mux2_5 MUX_RW(MEMWR_RegDst_out,MEMWR_rt_out,MEMWR_rd_out,RW);
Mux2_32  Mux_busw( MEMWR_MemToReg_out,MEMWR_Result_out,MEMWR_Dout_out,busW);
//
wire we;
assign we = MEMWR_RegWr_out;
RF RF_(clk,we,RW,rs,rt,busW,busA,busB);



///处理冒险
wire [4:0] Mem_Rw;
wire REGwR;
Mux2_5 MUX_MemRW(EXMEM_RegDst_out,EXMEM_rt_out,EXMEM_rd_out,Mem_Rw);
DataHazard Forward(EXMEM_RegWr_out,MEMWR_RegWr_out, MEMWR_MemToReg_out,Mem_Rw, IDEX_rs_out,IDEX_rt_out,RW,
                  IDEX_ALUsrc_out, imm32, IDEX_busA_out, IDEX_busB_out, EXMEM_Result_out,MEMWR_Result_out,MEMWR_dout_out,
                  ALUA, ALUB);
 Load_use loaduse(IDEX_MemRead_out,rt,rs,IDEX_rt_out,pc_stall,IFID_stall,IDEX_flush);
 Ctrl_Hazar Ctrl_hazard(clk,Sign,Jump,pc_stall,IFID_flush);
////
endmodule