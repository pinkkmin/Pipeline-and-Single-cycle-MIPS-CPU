he:
addiu $s5,$0,100 
addu  $s5,$s5,$s5
addi $t1,$0,0
addi $t1,$t1,100
addi $t2,$t2,100
add $t1,$t2,$t1 
add $t4,$t1,$t2 
lui $s7,100		
label:
addi $t1,$t1,0
sub $t4,$t4,$t1  #第10条
bltz $t4,he #10
ww:
and $t5,$t4,$t1
and $t6,$4,$t2
or  $t7,$4,$t1				
slt $s2,$t4,$t1
slti $s3,$t4,102
bgtz $s3,label #16
sw  $t1,100($t2)
lw  $s3,100($t2)
beq $t4,$t2,label #19   #第20条
j he
