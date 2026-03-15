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
	
	jal proverka #jal ripa kaj proverka pa koga vo proverka se povika jr $ra ripa na linijata odma posle ovaa
	
	beq $v0,1,sob #ako v0 e 1 odnosno brojot e prost ripa kaj sob
	
	j vrti #ova e za koga brojot ne e prost za da se vrati gore pred bgt
	
sob: #sobira i se vraka gore
	add $s3,$s2,$s3
	j vrti
	
proverka:
	li $v0,1 #true, se pretpostavuva deka brojot e prost
	li $t0,2 #i
	move $t2,$s2 #za da mozam da odzemam edenza dole kaj bgt da ne proveruvam dali brojot e delliv sam so sebe
	subi $t2,$t2,1 #s2-1
	
loop: #proveruva dellivost na brojot od 2 se do brojot pred vneseniot
	bgt $t0,$t2,krajPro
	div $s2,$t0 #vo lo se stava s2/t0 a vo hi s2%t0
	mfhi $t1 #rez od s2%i
	addi $t0,$t0,1 #se dodava eden na brojacot
	beq $t1,0,krajSl #ako se najde broj so koj vneseniot e delliv ripa kaj krajSl, odnosno ako s2%t0=0
	j loop
	
krajSl:
	li $v0,0 #false
	jr $ra #se vraka gore
krajPro:
	jr $ra #ako ne e najden delitel na brojot samo se vraka gore
	
sled:
	li $v0,1 #se pecati sumata
	move $a0,$s3
	syscall
	
	li $v0,10 #kraj na programa ekvivalent na return 0;
	syscall
	
	