.data
	a:	.float 0.0
	c:	.word 0

.globl main
.text
main:
	move $fp, $sp
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -76($fp)
	lw $t0, -76($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -76($fp)
	li $t0, 9
	lw $t1, -76($fp)
	add $t2, $t0, $t1
	sw $t2, -76($fp)
	lw $t0, -76($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -76($fp)
	lw $t0, -76($fp)
	add $t2, $t0, $fp
	sw $t2, -76($fp)
	li.s $f0, 1.000000
	lw $t0, -76($fp)
	s.s $f0, 0($t0)
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -84($fp)
	lw $t0, -84($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -84($fp)
	li $t0, 9
	lw $t1, -84($fp)
	add $t2, $t0, $t1
	sw $t2, -84($fp)
	lw $t0, -84($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -84($fp)
	lw $t0, -84($fp)
	add $t2, $t0, $fp
	sw $t2, -84($fp)
	li.s $f0, 2.000000
	lw $t0, -84($fp)
	s.s $f0, 0($t0)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -92($fp)
	lw $t0, -92($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -92($fp)
	li $t0, 9
	lw $t1, -92($fp)
	add $t2, $t0, $t1
	sw $t2, -92($fp)
	lw $t0, -92($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -92($fp)
	lw $t0, -92($fp)
	add $t2, $t0, $fp
	sw $t2, -92($fp)
	li.s $f0, 3.000000
	lw $t0, -92($fp)
	s.s $f0, 0($t0)
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -136($fp)
	lw $t0, -136($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -136($fp)
	li $t0, 24
	lw $t1, -136($fp)
	add $t2, $t0, $t1
	sw $t2, -136($fp)
	lw $t0, -136($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -136($fp)
	lw $t0, -136($fp)
	add $t2, $t0, $fp
	sw $t2, -136($fp)
	li.s $f0, 4.000000
	lw $t0, -136($fp)
	s.s $f0, 0($t0)
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -144($fp)
	lw $t0, -144($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -144($fp)
	li $t0, 24
	lw $t1, -144($fp)
	add $t2, $t0, $t1
	sw $t2, -144($fp)
	lw $t0, -144($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -144($fp)
	lw $t0, -144($fp)
	add $t2, $t0, $fp
	sw $t2, -144($fp)
	li.s $f0, 5.000000
	lw $t0, -144($fp)
	s.s $f0, 0($t0)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -152($fp)
	lw $t0, -152($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -152($fp)
	li $t0, 24
	lw $t1, -152($fp)
	add $t2, $t0, $t1
	sw $t2, -152($fp)
	lw $t0, -152($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -152($fp)
	lw $t0, -152($fp)
	add $t2, $t0, $fp
	sw $t2, -152($fp)
	li.s $f0, 6.000000
	lw $t0, -152($fp)
	s.s $f0, 0($t0)
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -196($fp)
	lw $t0, -196($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -196($fp)
	li $t0, 39
	lw $t1, -196($fp)
	add $t2, $t0, $t1
	sw $t2, -196($fp)
	lw $t0, -196($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -196($fp)
	lw $t0, -196($fp)
	add $t2, $t0, $fp
	sw $t2, -196($fp)
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -200($fp)
	lw $t0, -200($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -200($fp)
	li $t0, 9
	lw $t1, -200($fp)
	add $t2, $t0, $t1
	sw $t2, -200($fp)
	lw $t0, -200($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -200($fp)
	lw $t0, -200($fp)
	add $t2, $t0, $fp
	sw $t2, -200($fp)
	lw $t0, -196($fp)
	lw $t1, -200($fp)
	l.s $f0, 0($t1)
	neg.s $f1, $f0
	s.s $f1, 0($t0)
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -204($fp)
	lw $t0, -204($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -204($fp)
	li $t0, 39
	lw $t1, -204($fp)
	add $t2, $t0, $t1
	sw $t2, -204($fp)
	lw $t0, -204($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -204($fp)
	lw $t0, -204($fp)
	add $t2, $t0, $fp
	sw $t2, -204($fp)
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -208($fp)
	lw $t0, -208($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -208($fp)
	li $t0, 9
	lw $t1, -208($fp)
	add $t2, $t0, $t1
	sw $t2, -208($fp)
	lw $t0, -208($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -208($fp)
	lw $t0, -208($fp)
	add $t2, $t0, $fp
	sw $t2, -208($fp)
	lw $t0, -204($fp)
	lw $t1, -208($fp)
	l.s $f1, 0($t1)
	neg.s $f2, $f1
	s.s $f2, 0($t0)
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -212($fp)
	lw $t0, -212($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -212($fp)
	li $t0, 39
	lw $t1, -212($fp)
	add $t2, $t0, $t1
	sw $t2, -212($fp)
	lw $t0, -212($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -212($fp)
	lw $t0, -212($fp)
	add $t2, $t0, $fp
	sw $t2, -212($fp)
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -216($fp)
	lw $t0, -216($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -216($fp)
	li $t0, 9
	lw $t1, -216($fp)
	add $t2, $t0, $t1
	sw $t2, -216($fp)
	lw $t0, -216($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -216($fp)
	lw $t0, -216($fp)
	add $t2, $t0, $fp
	sw $t2, -216($fp)
	lw $t0, -212($fp)
	lw $t1, -216($fp)
	l.s $f2, 0($t1)
	neg.s $f3, $f2
	s.s $f3, 0($t0)
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -220($fp)
	lw $t0, -220($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -220($fp)
	li $t0, 39
	lw $t1, -220($fp)
	add $t2, $t0, $t1
	sw $t2, -220($fp)
	lw $t0, -220($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -220($fp)
	lw $t0, -220($fp)
	add $t2, $t0, $fp
	sw $t2, -220($fp)
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -224($fp)
	lw $t0, -224($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -224($fp)
	li $t0, 9
	lw $t1, -224($fp)
	add $t2, $t0, $t1
	sw $t2, -224($fp)
	lw $t0, -224($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -224($fp)
	lw $t0, -224($fp)
	add $t2, $t0, $fp
	sw $t2, -224($fp)
	lw $t0, -220($fp)
	lw $t1, -224($fp)
	l.s $f3, 0($t1)
	neg.s $f4, $f3
	s.s $f4, 0($t0)
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -228($fp)
	lw $t0, -228($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -228($fp)
	li $t0, 39
	lw $t1, -228($fp)
	add $t2, $t0, $t1
	sw $t2, -228($fp)
	lw $t0, -228($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -228($fp)
	lw $t0, -228($fp)
	add $t2, $t0, $fp
	sw $t2, -228($fp)
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -232($fp)
	lw $t0, -232($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -232($fp)
	li $t0, 9
	lw $t1, -232($fp)
	add $t2, $t0, $t1
	sw $t2, -232($fp)
	lw $t0, -232($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -232($fp)
	lw $t0, -232($fp)
	add $t2, $t0, $fp
	sw $t2, -232($fp)
	lw $t0, -228($fp)
	lw $t1, -232($fp)
	l.s $f4, 0($t1)
	neg.s $f5, $f4
	s.s $f5, 0($t0)
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -236($fp)
	lw $t0, -236($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -236($fp)
	li $t0, 39
	lw $t1, -236($fp)
	add $t2, $t0, $t1
	sw $t2, -236($fp)
	lw $t0, -236($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -236($fp)
	lw $t0, -236($fp)
	add $t2, $t0, $fp
	sw $t2, -236($fp)
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -240($fp)
	lw $t0, -240($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -240($fp)
	li $t0, 9
	lw $t1, -240($fp)
	add $t2, $t0, $t1
	sw $t2, -240($fp)
	lw $t0, -240($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -240($fp)
	lw $t0, -240($fp)
	add $t2, $t0, $fp
	sw $t2, -240($fp)
	lw $t0, -236($fp)
	lw $t1, -240($fp)
	l.s $f5, 0($t1)
	neg.s $f6, $f5
	s.s $f6, 0($t0)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -244($fp)
	lw $t0, -244($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -244($fp)
	li $t0, 39
	lw $t1, -244($fp)
	add $t2, $t0, $t1
	sw $t2, -244($fp)
	lw $t0, -244($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -244($fp)
	lw $t0, -244($fp)
	add $t2, $t0, $fp
	sw $t2, -244($fp)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -248($fp)
	lw $t0, -248($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -248($fp)
	li $t0, 9
	lw $t1, -248($fp)
	add $t2, $t0, $t1
	sw $t2, -248($fp)
	lw $t0, -248($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -248($fp)
	lw $t0, -248($fp)
	add $t2, $t0, $fp
	sw $t2, -248($fp)
	lw $t0, -244($fp)
	lw $t1, -248($fp)
	l.s $f6, 0($t1)
	neg.s $f7, $f6
	s.s $f7, 0($t0)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -252($fp)
	lw $t0, -252($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -252($fp)
	li $t0, 39
	lw $t1, -252($fp)
	add $t2, $t0, $t1
	sw $t2, -252($fp)
	lw $t0, -252($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -252($fp)
	lw $t0, -252($fp)
	add $t2, $t0, $fp
	sw $t2, -252($fp)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -256($fp)
	lw $t0, -256($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -256($fp)
	li $t0, 9
	lw $t1, -256($fp)
	add $t2, $t0, $t1
	sw $t2, -256($fp)
	lw $t0, -256($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -256($fp)
	lw $t0, -256($fp)
	add $t2, $t0, $fp
	sw $t2, -256($fp)
	lw $t0, -252($fp)
	lw $t1, -256($fp)
	l.s $f7, 0($t1)
	neg.s $f8, $f7
	s.s $f8, 0($t0)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -260($fp)
	lw $t0, -260($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -260($fp)
	li $t0, 39
	lw $t1, -260($fp)
	add $t2, $t0, $t1
	sw $t2, -260($fp)
	lw $t0, -260($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -260($fp)
	lw $t0, -260($fp)
	add $t2, $t0, $fp
	sw $t2, -260($fp)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -264($fp)
	lw $t0, -264($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -264($fp)
	li $t0, 9
	lw $t1, -264($fp)
	add $t2, $t0, $t1
	sw $t2, -264($fp)
	lw $t0, -264($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -264($fp)
	lw $t0, -264($fp)
	add $t2, $t0, $fp
	sw $t2, -264($fp)
	lw $t0, -260($fp)
	lw $t1, -264($fp)
	l.s $f8, 0($t1)
	neg.s $f9, $f8
	s.s $f9, 0($t0)
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -268($fp)
	lw $t0, -268($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -268($fp)
	li $t0, 9
	lw $t1, -268($fp)
	add $t2, $t0, $t1
	sw $t2, -268($fp)
	lw $t0, -268($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -268($fp)
	lw $t0, -268($fp)
	add $t2, $t0, $fp
	sw $t2, -268($fp)
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -276($fp)
	lw $t0, -276($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -276($fp)
	li $t0, 39
	lw $t1, -276($fp)
	add $t2, $t0, $t1
	sw $t2, -276($fp)
	lw $t0, -276($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -276($fp)
	lw $t0, -276($fp)
	add $t2, $t0, $fp
	sw $t2, -276($fp)
	lw $t0, -276($fp)
	l.s $f9, 0($t0)
	lw $t1, -268($fp)
	s.s $f9, 0($t1)
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -276($fp)
	lw $t0, -276($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -276($fp)
	li $t0, 9
	lw $t1, -276($fp)
	add $t2, $t0, $t1
	sw $t2, -276($fp)
	lw $t0, -276($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -276($fp)
	lw $t0, -276($fp)
	add $t2, $t0, $fp
	sw $t2, -276($fp)
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -284($fp)
	lw $t0, -284($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -284($fp)
	li $t0, 39
	lw $t1, -284($fp)
	add $t2, $t0, $t1
	sw $t2, -284($fp)
	lw $t0, -284($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -284($fp)
	lw $t0, -284($fp)
	add $t2, $t0, $fp
	sw $t2, -284($fp)
	lw $t0, -284($fp)
	l.s $f9, 0($t0)
	lw $t1, -276($fp)
	s.s $f9, 0($t1)
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -284($fp)
	lw $t0, -284($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -284($fp)
	li $t0, 9
	lw $t1, -284($fp)
	add $t2, $t0, $t1
	sw $t2, -284($fp)
	lw $t0, -284($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -284($fp)
	lw $t0, -284($fp)
	add $t2, $t0, $fp
	sw $t2, -284($fp)
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -292($fp)
	lw $t0, -292($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -292($fp)
	li $t0, 39
	lw $t1, -292($fp)
	add $t2, $t0, $t1
	sw $t2, -292($fp)
	lw $t0, -292($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -292($fp)
	lw $t0, -292($fp)
	add $t2, $t0, $fp
	sw $t2, -292($fp)
	lw $t0, -292($fp)
	l.s $f9, 0($t0)
	lw $t1, -284($fp)
	s.s $f9, 0($t1)
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -292($fp)
	lw $t0, -292($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -292($fp)
	li $t0, 9
	lw $t1, -292($fp)
	add $t2, $t0, $t1
	sw $t2, -292($fp)
	lw $t0, -292($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -292($fp)
	lw $t0, -292($fp)
	add $t2, $t0, $fp
	sw $t2, -292($fp)
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -300($fp)
	lw $t0, -300($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -300($fp)
	li $t0, 39
	lw $t1, -300($fp)
	add $t2, $t0, $t1
	sw $t2, -300($fp)
	lw $t0, -300($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -300($fp)
	lw $t0, -300($fp)
	add $t2, $t0, $fp
	sw $t2, -300($fp)
	lw $t0, -300($fp)
	l.s $f9, 0($t0)
	lw $t1, -292($fp)
	s.s $f9, 0($t1)
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -300($fp)
	lw $t0, -300($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -300($fp)
	li $t0, 9
	lw $t1, -300($fp)
	add $t2, $t0, $t1
	sw $t2, -300($fp)
	lw $t0, -300($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -300($fp)
	lw $t0, -300($fp)
	add $t2, $t0, $fp
	sw $t2, -300($fp)
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -308($fp)
	lw $t0, -308($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -308($fp)
	li $t0, 39
	lw $t1, -308($fp)
	add $t2, $t0, $t1
	sw $t2, -308($fp)
	lw $t0, -308($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -308($fp)
	lw $t0, -308($fp)
	add $t2, $t0, $fp
	sw $t2, -308($fp)
	lw $t0, -308($fp)
	l.s $f9, 0($t0)
	lw $t1, -300($fp)
	s.s $f9, 0($t1)
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -308($fp)
	lw $t0, -308($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -308($fp)
	li $t0, 9
	lw $t1, -308($fp)
	add $t2, $t0, $t1
	sw $t2, -308($fp)
	lw $t0, -308($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -308($fp)
	lw $t0, -308($fp)
	add $t2, $t0, $fp
	sw $t2, -308($fp)
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -316($fp)
	lw $t0, -316($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -316($fp)
	li $t0, 39
	lw $t1, -316($fp)
	add $t2, $t0, $t1
	sw $t2, -316($fp)
	lw $t0, -316($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -316($fp)
	lw $t0, -316($fp)
	add $t2, $t0, $fp
	sw $t2, -316($fp)
	lw $t0, -316($fp)
	l.s $f9, 0($t0)
	lw $t1, -308($fp)
	s.s $f9, 0($t1)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -316($fp)
	lw $t0, -316($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -316($fp)
	li $t0, 9
	lw $t1, -316($fp)
	add $t2, $t0, $t1
	sw $t2, -316($fp)
	lw $t0, -316($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -316($fp)
	lw $t0, -316($fp)
	add $t2, $t0, $fp
	sw $t2, -316($fp)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -324($fp)
	lw $t0, -324($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -324($fp)
	li $t0, 39
	lw $t1, -324($fp)
	add $t2, $t0, $t1
	sw $t2, -324($fp)
	lw $t0, -324($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -324($fp)
	lw $t0, -324($fp)
	add $t2, $t0, $fp
	sw $t2, -324($fp)
	lw $t0, -324($fp)
	l.s $f9, 0($t0)
	lw $t1, -316($fp)
	s.s $f9, 0($t1)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -324($fp)
	lw $t0, -324($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -324($fp)
	li $t0, 9
	lw $t1, -324($fp)
	add $t2, $t0, $t1
	sw $t2, -324($fp)
	lw $t0, -324($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -324($fp)
	lw $t0, -324($fp)
	add $t2, $t0, $fp
	sw $t2, -324($fp)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -332($fp)
	lw $t0, -332($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -332($fp)
	li $t0, 39
	lw $t1, -332($fp)
	add $t2, $t0, $t1
	sw $t2, -332($fp)
	lw $t0, -332($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -332($fp)
	lw $t0, -332($fp)
	add $t2, $t0, $fp
	sw $t2, -332($fp)
	lw $t0, -332($fp)
	l.s $f9, 0($t0)
	lw $t1, -324($fp)
	s.s $f9, 0($t1)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -332($fp)
	lw $t0, -332($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -332($fp)
	li $t0, 9
	lw $t1, -332($fp)
	add $t2, $t0, $t1
	sw $t2, -332($fp)
	lw $t0, -332($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -332($fp)
	lw $t0, -332($fp)
	add $t2, $t0, $fp
	sw $t2, -332($fp)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -340($fp)
	lw $t0, -340($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -340($fp)
	li $t0, 39
	lw $t1, -340($fp)
	add $t2, $t0, $t1
	sw $t2, -340($fp)
	lw $t0, -340($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -340($fp)
	lw $t0, -340($fp)
	add $t2, $t0, $fp
	sw $t2, -340($fp)
	lw $t0, -340($fp)
	l.s $f9, 0($t0)
	lw $t1, -332($fp)
	s.s $f9, 0($t1)
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -348($fp)
	lw $t0, -348($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -348($fp)
	li $t0, 9
	lw $t1, -348($fp)
	add $t2, $t0, $t1
	sw $t2, -348($fp)
	lw $t0, -348($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -348($fp)
	lw $t0, -348($fp)
	add $t2, $t0, $fp
	sw $t2, -348($fp)
	lw $t0, -348($fp)
	l.s $f9, 0($t0)
	li $v0, 2
	mov.s $f12, $f9
	syscall
	li $v0, 4
	la $a0, -364($fp)
	li $t0, 9
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -352($fp)
	lw $t0, -352($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -352($fp)
	li $t0, 9
	lw $t1, -352($fp)
	add $t2, $t0, $t1
	sw $t2, -352($fp)
	lw $t0, -352($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -352($fp)
	lw $t0, -352($fp)
	add $t2, $t0, $fp
	sw $t2, -352($fp)
	lw $t0, -352($fp)
	l.s $f9, 0($t0)
	li $v0, 2
	mov.s $f12, $f9
	syscall
	li $v0, 4
	la $a0, -364($fp)
	li $t0, 9
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -356($fp)
	lw $t0, -356($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -356($fp)
	li $t0, 9
	lw $t1, -356($fp)
	add $t2, $t0, $t1
	sw $t2, -356($fp)
	lw $t0, -356($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -356($fp)
	lw $t0, -356($fp)
	add $t2, $t0, $fp
	sw $t2, -356($fp)
	lw $t0, -356($fp)
	l.s $f9, 0($t0)
	li $v0, 2
	mov.s $f12, $f9
	syscall
	li $v0, 4
	la $a0, -364($fp)
	li $t0, 9
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $v0, 4
	la $a0, -360($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -360($fp)
	lw $t0, -360($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -360($fp)
	li $t0, 9
	lw $t1, -360($fp)
	add $t2, $t0, $t1
	sw $t2, -360($fp)
	lw $t0, -360($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -360($fp)
	lw $t0, -360($fp)
	add $t2, $t0, $fp
	sw $t2, -360($fp)
	lw $t0, -360($fp)
	l.s $f9, 0($t0)
	li $v0, 2
	mov.s $f12, $f9
	syscall
	li $v0, 4
	la $a0, -364($fp)
	li $t0, 9
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -364($fp)
	lw $t0, -364($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -364($fp)
	li $t0, 9
	lw $t1, -364($fp)
	add $t2, $t0, $t1
	sw $t2, -364($fp)
	lw $t0, -364($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -364($fp)
	lw $t0, -364($fp)
	add $t2, $t0, $fp
	sw $t2, -364($fp)
	lw $t0, -364($fp)
	l.s $f9, 0($t0)
	li $v0, 2
	mov.s $f12, $f9
	syscall
	li $v0, 4
	la $a0, -364($fp)
	li $t0, 9
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -368($fp)
	lw $t0, -368($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -368($fp)
	li $t0, 9
	lw $t1, -368($fp)
	add $t2, $t0, $t1
	sw $t2, -368($fp)
	lw $t0, -368($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -368($fp)
	lw $t0, -368($fp)
	add $t2, $t0, $fp
	sw $t2, -368($fp)
	lw $t0, -368($fp)
	l.s $f9, 0($t0)
	li $v0, 2
	mov.s $f12, $f9
	syscall
	li $v0, 4
	la $a0, -364($fp)
	li $t0, 9
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $v0, 4
	la $a0, -360($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -372($fp)
	lw $t0, -372($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -372($fp)
	li $t0, 9
	lw $t1, -372($fp)
	add $t2, $t0, $t1
	sw $t2, -372($fp)
	lw $t0, -372($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -372($fp)
	lw $t0, -372($fp)
	add $t2, $t0, $fp
	sw $t2, -372($fp)
	lw $t0, -372($fp)
	l.s $f9, 0($t0)
	li $v0, 2
	mov.s $f12, $f9
	syscall
	li $v0, 4
	la $a0, -364($fp)
	li $t0, 9
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -376($fp)
	lw $t0, -376($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -376($fp)
	li $t0, 9
	lw $t1, -376($fp)
	add $t2, $t0, $t1
	sw $t2, -376($fp)
	lw $t0, -376($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -376($fp)
	lw $t0, -376($fp)
	add $t2, $t0, $fp
	sw $t2, -376($fp)
	lw $t0, -376($fp)
	l.s $f9, 0($t0)
	li $v0, 2
	mov.s $f12, $f9
	syscall
	li $v0, 4
	la $a0, -364($fp)
	li $t0, 9
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -380($fp)
	lw $t0, -380($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -380($fp)
	li $t0, 9
	lw $t1, -380($fp)
	add $t2, $t0, $t1
	sw $t2, -380($fp)
	lw $t0, -380($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -380($fp)
	lw $t0, -380($fp)
	add $t2, $t0, $fp
	sw $t2, -380($fp)
	lw $t0, -380($fp)
	l.s $f9, 0($t0)
	li $v0, 2
	mov.s $f12, $f9
	syscall
	li $v0, 4
	la $a0, -364($fp)
	li $t0, 9
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $v0, 4
	la $a0, -360($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $v0, 10
	syscall
