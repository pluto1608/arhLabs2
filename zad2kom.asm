li $v0,5
syscall
move $s0,$v0 #n

li $s1,1 #i
li $s3,0 #sum

vrti:
bgt $s1,$s0,sled #ako s2 e pogolem od s0 odnosno ako brojot na pati koi e izvrten kodot od ovaa linija do sob se preminuva kaj sled

	li $v0,5
	syscall
	move $s2,$v0 #vnesen br
	
	addi $s1,$s1,1
	
	move $a0,$s2 #teoretski potocno e preku a reg da se prenese vrednost vo procedura
	jal proverka#jal ripa kaj proverka pa koga vo proverka se povika jr $ra ripa na linijata odma posle ovaa

	beq $v0,1,sob #ako v0 e 1 odnosno brojot e prost ripa kaj sob
	
	j vrti #ova e za koga brojot ne e prost za da se vrati gore pred bgt
	
sob: #sobira i se vraka gore
	add $s3,$s2,$s3
	j vrti
	
proverka:
	li $v0,1 #true, se pretpostavuva deka brojot e prost
	li $t0,2 #i
	addi $sp,$sp,-4 #vo stackot se pravi mesto za 1 zbor(int) 4 e zasho raboti so 4 bitni adresi, - zasho ednostavno taka raboti nz
	sw $a0,0($sp) #se zacuvuva a0 vo stackot
	subi $a0,$a0,1 #se odzima 1 za da ne se proveruva dellivost na brojot sam so sebe
	
loop: #proveruva dellivost na brojot od 2 se do brojot pred vneseniot
	bgt $t0,$a0,endP
	div $s2,$t0 #vo lo se stava s2/t0 a vo hi s2%t0
	mfhi $t1 #rez od s2%i
	addi $t0,$t0,1
	beq $t1,0,krajSl #ako se najde broj so koj vneseniot e delliv ripa kaj krajSl, odnosno ako s2%t0=0
	j loop
	
krajSl:
	li $v0,0 #false
endP:
	lw $a0,0($sp) #se vraka originalnata vrednost vo a0
	addi $sp,$sp,4 #se osloboduva memoriskoto mesto
	jr $ra #se vraka na linija 19
	
sled:
	li $v0,1 #se pecati sumata
	move $a0,$s3
	syscall
	
	li $v0,10 #kraj na progrma ekv na return 0;
	syscall
	
	
