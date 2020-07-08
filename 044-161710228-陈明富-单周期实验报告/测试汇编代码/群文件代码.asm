loop0:addiu $1, $0,1
sll   $2, $1,4
addu  $3, $2,$1
srl     $4, $2,2
slti    $25,$4,5
bgez  $25,loop1
subu  $5,$3,$4
sw     $5, 20($4)
nor    $6, $5,$2
or      $7, $6,$3
xor    $8, $7,$6
sw     $8, 28($8)
beq    $8, $3,loop2
slt      $9, $6,$7

loop2: addiu $1, $0,8   #替换为注释后的代码
lw      $10,28($1)      #lw   $10,28($8)
bne    $10,$5,loop3
and    $11,$2,$1
sw     $11,28($1)
sw     $4, 16($1)

loop3: jal    loop4

loop1: lui     $12,12
srav   $26,$12,$2
sllv    $27,$26,$1
jalr    $27

loop4:  sb  $26,5($3)
sltu    $13,$3,$3
bgtz   $13,loop4
sllv    $14,$6,$4

loop5: sra     $15,$14,2
srlv    $16,$15,$1
blez    $16,loop1
srav    $16,$15,$1
addiu $11,$0,140
bltz    $16,loop5      
lw     $28,3($10)   
bne   $28,$29,loop6     

loop8:sb     $15,8($5)  
lb     $18,8($5)       
lbu    $19,8($5)   

loop6: sltiu $24,$15,-1 
or    $29,$12,$5        
jr     $11

loop7: andi $20,$15,-1
ori   $21,$15,-1
xori $22,$15,-1
j    loop0
