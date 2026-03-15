li $v0,5
syscall
move $s0,$v0 #n

li $s1,1 #i
li $s3,0 #sum

vrti:
bgt $s1,$s0,sled

	li $v0,5
	syscall
	move $s2,$v0 #vnesen br
	
	addi $s1,$s1,1
	
	jal proverka
	
	beq $v0,1,sob
	
	j vrti
	
sob:
	
	add $s3,$s2,$s3
	j vrti
	
proverka:
	li $v0,1 #true
	li $t0,2 #i
	move $t2,$s2
	subi $t2,$t2,1 #s2-1
	
loop:
	bgt $t0,$t2,krajPro
	div $s2,$t0
	mfhi $t1 #rez od s2%i
	addi $t0,$t0,1
	beq $t1,0,krajSl
	j loop
	
krajSl:
	li $v0,0 #false
	jr $ra
krajPro:
	jr $ra
	
sled:
	li $v0,1
	move $a0,$s3
	syscall
	
	li $v0,10
	syscall
	
	