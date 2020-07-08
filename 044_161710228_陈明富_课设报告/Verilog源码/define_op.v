// define OP

`define RTYPE     6'b000000

`define LB        6'b100000
`define LBU       6'b100100
`define LW        6'b100011
`define SB        6'b101000
`define SW        6'b101011

`define ADDI      6'b001000
`define ADDIU     6'b001001
`define ANDI      6'b001100
`define ORI       6'b001101 
`define XORI      6'b001110
`define LUI       6'b001111
`define SLTI      6'b001010
`define SLTIU     6'b001011

`define BEQ        6'b000100
`define BNE        6'b000101
`define BGEZ       6'b000001
`define BGTZ       6'b000111
`define BLEZ       6'b000110
`define BLTZ       6'b000001

`define J         6'b000010
//`define JAL       6'b000011

// func域  
`define ADD_func     6'b100000
`define ADDU_func    6'b100001
`define SUB_func     6'b100010
`define SUBU_func    6'b100011
`define AND_func     6'b100100
`define NOR_func     6'b100111
`define OR_func      6'b100101
`define XOR_func     6'b100110
`define SLT_func     6'b101010
`define SLTU_func    6'b101011
`define SLL_func     6'b000000
`define SRL_func     6'b000010
`define SRA_func     6'b000011
`define SLLV_func    6'b000100
`define SRLV_func    6'b000110
`define SRAV_func    6'b000111      
`define JR_func      6'b001000
`define JALR_func    6'b001001     
 
`define BGEZ_Rt      5'b00001
`define BLTZ_Rt      5'b00000
   
