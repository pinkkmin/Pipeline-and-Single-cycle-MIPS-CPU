he:                   # д�Ĵ������     д������             ��16���ƣ�
addiu $s5,$0,100      # Rw_number: 15    busW_data: 64
addu  $s5,$s5,$s5     # Rw_number: 15    busW_data: c8
addi $t1,$0,0         # Rw_number: 09    busW_data: 0
addi $t1,$t1,100      # Rw_number: 09    busW_data: 64
addi $t2,$t2,100      # Rw_number: 0a    busW_data: 64
add $t1,$t2,$t1       # Rw_number: 09    busW_data: c8    7th CLK to EX�׶�
add $t4,$t1,$t2       # Rw_number: 0c    busW_data: 12c
lui $s7,255	      # Rw_number: 23    busW_data: 00ff0000  
label:
addi $t1,$t1,0        # Rw_number: 09    busW_data: c8
subu $t9,$t4,$2       # Rw_number: 19    busW_data: 12c
sub $t4,$t4,$t1       # Rw_number: 0c    busW_data: 64   ��10��ָ��
#bltz $t4,he #10
ww:
and $t5,$t4,$t1       # Rw_number: 0d    busW_data: 40 
andi $t6,$t4,180      # Rw_number: 0e    busW_data: 24 
or  $t7,$t4,$t1	      # Rw_number: 0f    busW_data: ec	
ori $t3,$t1,500       # Rw_number: 0b    busW_data: 1fc
xor $s1,$t4,$t7	      # Rw_number: 11    busW_data: 88
xori $s4,$t5,1000     # Rw_number: 14    busW_data: 3a8
nor $t7,$t4,$t1	      # Rw_number: 0f    busW_data: ffffff13
sll $s2,$t4,19        # Rw_number: 12    busW_data: 0320000 error
srl $s2,$s4,25        # Rw_number: 12    busW_data: 0 error
sra $s2,$t4,5         # Rw_number: 12    busW_data: 3 error
sllv $s2,$t4,$t8      # Rw_number: 12    busW_data: 64
srlv $s2,$t4,$t8      # Rw_number: 12    busW_data: 64
srav $s2,$t4,$t8      # Rw_number: 12    busW_data: 64
slt $s2,$t4,$t1       # Rw_number: 12    busW_data: 1
slti $s3,$t4,102      # Rw_number: 13    busW_data: 1
sltu $t7,$t3,$t4      # Rw_number: 0f    busW_data: 0
sltiu $t5,$t3,400      # Rw_number: 0d    busW_data: 0
#bgtz $s3,label #16
sw  $t1,100($t2)       # mem: c8     data: c8
sb   $t1,90($t2)       # Datamem: c8     data: c8
lb    $s1, 90($t2)    # Datamem: 11     data: ffffffc8   
lbu    $s2, 90($t2)     # Datamem: 12     data: 00000000c8
lw  $s3,100($t2)      # Rw_number: 13    busW_data: c8
beq $t4,$t2,label     #��һ�λ���ת��label                ��20��ָ��
j he                  #��ַתΪ0
