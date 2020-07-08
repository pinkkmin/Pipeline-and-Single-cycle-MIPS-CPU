adder:
addiu $s5,$0,100 
addiu $t8,$0,5
addu  $s5,$s5,$s5 #   s5  200
addi $t1,$0,0
addi $t1,$t1,100  # t1 100
addi $t2,$t2,100  # t2 100
add $t1,$t2,$t1   # t1 200
add $t4,$t1,$t2   # t4 300
label:
addi $t1,$t1,0  # 不变 200
sub $t4,$t4,$t1 # t4 100    #第10条
lj_test:      
and $t5,$t4,$t1   
and $t6,$t4,$t2  
andi,$t5,$t1,3000

or  $t7,$t4,$t1
ori $t7,$t4,120
nor $t7,$t4,$t1	
bne $t4,$t2,label
xor  $t7,$t4,$t1
xori $t7,$t4,11
j hello   #第20条
hello:						
slt $s1,$t4,$t2
slt $s2,$t4,$t1
sltu $s2,$t4,$t1
sltiu $s2,$t4,3
sll $s2,$t4,10
srl $s2,$s4,25
sra $s2,$t4,5
sllv $s2,$t4,$t8
srlv $s2,$t4,$t8
srav $s2,$t4,$t8 #第30条  
sw  $t1,100($t2)
lw  $s3,100($t2)
beq $t4,$t2,label
j lj_test
