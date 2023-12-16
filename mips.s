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
	sw $t2, -204($fp)
	lw $t0, -204($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -204($fp)
	li $t0, 9
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
	lw $t0, -196($fp)
	lw $t1, -204($fp)
	l.s $f0, 0($t1)
	li.s $f1, 2.000000
	sub.s $f2, $f0, $f1
	s.s $f2, 0($t0)
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -200($fp)
	lw $t0, -200($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -200($fp)
	li $t0, 39
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
	lw $t0, -200($fp)
	lw $t1, -208($fp)
	l.s $f0, 0($t1)
	li.s $f1, 2.000000
	sub.s $f2, $f0, $f1
	s.s $f2, 0($t0)
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -204($fp)
	lw $t0, -204($fp)
	li $t1, 2
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
	sw $t2, -212($fp)
	lw $t0, -212($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -212($fp)
	li $t0, 9
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
	lw $t0, -204($fp)
	lw $t1, -212($fp)
	l.s $f0, 0($t1)
	li.s $f1, 2.000000
	sub.s $f2, $f0, $f1
	s.s $f2, 0($t0)
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -208($fp)
	lw $t0, -208($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -208($fp)
	li $t0, 39
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
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -216($fp)
	lw $t0, -216($fp)
	li $t1, 0
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
	lw $t0, -208($fp)
	lw $t1, -216($fp)
	l.s $f0, 0($t1)
	li.s $f1, 2.000000
	sub.s $f2, $f0, $f1
	s.s $f2, 0($t0)
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -212($fp)
	lw $t0, -212($fp)
	li $t1, 1
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
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -220($fp)
	lw $t0, -220($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -220($fp)
	li $t0, 9
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
	lw $t0, -212($fp)
	lw $t1, -220($fp)
	l.s $f0, 0($t1)
	li.s $f1, 2.000000
	sub.s $f2, $f0, $f1
	s.s $f2, 0($t0)
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -216($fp)
	lw $t0, -216($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -216($fp)
	li $t0, 39
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
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -224($fp)
	lw $t0, -224($fp)
	li $t1, 2
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
	lw $t0, -216($fp)
	lw $t1, -224($fp)
	l.s $f0, 0($t1)
	li.s $f1, 2.000000
	sub.s $f2, $f0, $f1
	s.s $f2, 0($t0)
	li $t0, 3
	li $t1, 2
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
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -228($fp)
	lw $t0, -228($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -228($fp)
	li $t0, 9
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
	lw $t0, -220($fp)
	lw $t1, -228($fp)
	l.s $f0, 0($t1)
	li.s $f1, 2.000000
	sub.s $f2, $f0, $f1
	s.s $f2, 0($t0)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -224($fp)
	lw $t0, -224($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -224($fp)
	li $t0, 39
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
	li $t0, 3
	li $t1, 2
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
	lw $t0, -224($fp)
	lw $t1, -232($fp)
	l.s $f0, 0($t1)
	li.s $f1, 2.000000
	sub.s $f2, $f0, $f1
	s.s $f2, 0($t0)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -228($fp)
	lw $t0, -228($fp)
	li $t1, 2
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
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -236($fp)
	lw $t0, -236($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -236($fp)
	li $t0, 9
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
	lw $t0, -228($fp)
	lw $t1, -236($fp)
	l.s $f0, 0($t1)
	li.s $f1, 2.000000
	sub.s $f2, $f0, $f1
	s.s $f2, 0($t0)
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -232($fp)
	lw $t0, -232($fp)
	li $t1, 0
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
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -240($fp)
	lw $t0, -240($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -240($fp)
	li $t0, 39
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
	lw $t0, -240($fp)
	l.s $f0, 0($t0)
	lw $t1, -232($fp)
	s.s $f0, 0($t1)
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -240($fp)
	lw $t0, -240($fp)
	li $t1, 1
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
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -248($fp)
	lw $t0, -248($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -248($fp)
	li $t0, 39
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
	lw $t0, -248($fp)
	l.s $f0, 0($t0)
	lw $t1, -240($fp)
	s.s $f0, 0($t1)
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -248($fp)
	lw $t0, -248($fp)
	li $t1, 2
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
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -256($fp)
	lw $t0, -256($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -256($fp)
	li $t0, 39
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
	lw $t0, -256($fp)
	l.s $f0, 0($t0)
	lw $t1, -248($fp)
	s.s $f0, 0($t1)
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -256($fp)
	lw $t0, -256($fp)
	li $t1, 0
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
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -264($fp)
	lw $t0, -264($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -264($fp)
	li $t0, 39
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
	lw $t0, -264($fp)
	l.s $f0, 0($t0)
	lw $t1, -256($fp)
	s.s $f0, 0($t1)
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -264($fp)
	lw $t0, -264($fp)
	li $t1, 1
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
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -272($fp)
	lw $t0, -272($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -272($fp)
	li $t0, 39
	lw $t1, -272($fp)
	add $t2, $t0, $t1
	sw $t2, -272($fp)
	lw $t0, -272($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -272($fp)
	lw $t0, -272($fp)
	add $t2, $t0, $fp
	sw $t2, -272($fp)
	lw $t0, -272($fp)
	l.s $f0, 0($t0)
	lw $t1, -264($fp)
	s.s $f0, 0($t1)
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -272($fp)
	lw $t0, -272($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -272($fp)
	li $t0, 9
	lw $t1, -272($fp)
	add $t2, $t0, $t1
	sw $t2, -272($fp)
	lw $t0, -272($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -272($fp)
	lw $t0, -272($fp)
	add $t2, $t0, $fp
	sw $t2, -272($fp)
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -280($fp)
	lw $t0, -280($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -280($fp)
	li $t0, 39
	lw $t1, -280($fp)
	add $t2, $t0, $t1
	sw $t2, -280($fp)
	lw $t0, -280($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -280($fp)
	lw $t0, -280($fp)
	add $t2, $t0, $fp
	sw $t2, -280($fp)
	lw $t0, -280($fp)
	l.s $f0, 0($t0)
	lw $t1, -272($fp)
	s.s $f0, 0($t1)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -280($fp)
	lw $t0, -280($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -280($fp)
	li $t0, 9
	lw $t1, -280($fp)
	add $t2, $t0, $t1
	sw $t2, -280($fp)
	lw $t0, -280($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -280($fp)
	lw $t0, -280($fp)
	add $t2, $t0, $fp
	sw $t2, -280($fp)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -288($fp)
	lw $t0, -288($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -288($fp)
	li $t0, 39
	lw $t1, -288($fp)
	add $t2, $t0, $t1
	sw $t2, -288($fp)
	lw $t0, -288($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -288($fp)
	lw $t0, -288($fp)
	add $t2, $t0, $fp
	sw $t2, -288($fp)
	lw $t0, -288($fp)
	l.s $f0, 0($t0)
	lw $t1, -280($fp)
	s.s $f0, 0($t1)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -288($fp)
	lw $t0, -288($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -288($fp)
	li $t0, 9
	lw $t1, -288($fp)
	add $t2, $t0, $t1
	sw $t2, -288($fp)
	lw $t0, -288($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -288($fp)
	lw $t0, -288($fp)
	add $t2, $t0, $fp
	sw $t2, -288($fp)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -296($fp)
	lw $t0, -296($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -296($fp)
	li $t0, 39
	lw $t1, -296($fp)
	add $t2, $t0, $t1
	sw $t2, -296($fp)
	lw $t0, -296($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -296($fp)
	lw $t0, -296($fp)
	add $t2, $t0, $fp
	sw $t2, -296($fp)
	lw $t0, -296($fp)
	l.s $f0, 0($t0)
	lw $t1, -288($fp)
	s.s $f0, 0($t1)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -296($fp)
	lw $t0, -296($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -296($fp)
	li $t0, 9
	lw $t1, -296($fp)
	add $t2, $t0, $t1
	sw $t2, -296($fp)
	lw $t0, -296($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -296($fp)
	lw $t0, -296($fp)
	add $t2, $t0, $fp
	sw $t2, -296($fp)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -304($fp)
	lw $t0, -304($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -304($fp)
	li $t0, 39
	lw $t1, -304($fp)
	add $t2, $t0, $t1
	sw $t2, -304($fp)
	lw $t0, -304($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -304($fp)
	lw $t0, -304($fp)
	add $t2, $t0, $fp
	sw $t2, -304($fp)
	lw $t0, -304($fp)
	l.s $f0, 0($t0)
	lw $t1, -296($fp)
	s.s $f0, 0($t1)
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -312($fp)
	lw $t0, -312($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -312($fp)
	li $t0, 9
	lw $t1, -312($fp)
	add $t2, $t0, $t1
	sw $t2, -312($fp)
	lw $t0, -312($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -312($fp)
	lw $t0, -312($fp)
	add $t2, $t0, $fp
	sw $t2, -312($fp)
	lw $t0, -312($fp)
	l.s $f0, 0($t0)
	li $v0, 2
	mov.s $f12, $f0
	syscall
	li $v0, 4
	la $a0, -328($fp)
	li $t0, 9
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -316($fp)
	lw $t0, -316($fp)
	li $t1, 1
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
	lw $t0, -316($fp)
	l.s $f0, 0($t0)
	li $v0, 2
	mov.s $f12, $f0
	syscall
	li $v0, 4
	la $a0, -328($fp)
	li $t0, 9
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -320($fp)
	lw $t0, -320($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -320($fp)
	li $t0, 9
	lw $t1, -320($fp)
	add $t2, $t0, $t1
	sw $t2, -320($fp)
	lw $t0, -320($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -320($fp)
	lw $t0, -320($fp)
	add $t2, $t0, $fp
	sw $t2, -320($fp)
	lw $t0, -320($fp)
	l.s $f0, 0($t0)
	li $v0, 2
	mov.s $f12, $f0
	syscall
	li $v0, 4
	la $a0, -328($fp)
	li $t0, 9
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $v0, 4
	la $a0, -324($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -324($fp)
	lw $t0, -324($fp)
	li $t1, 0
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
	lw $t0, -324($fp)
	l.s $f0, 0($t0)
	li $v0, 2
	mov.s $f12, $f0
	syscall
	li $v0, 4
	la $a0, -328($fp)
	li $t0, 9
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -328($fp)
	lw $t0, -328($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -328($fp)
	li $t0, 9
	lw $t1, -328($fp)
	add $t2, $t0, $t1
	sw $t2, -328($fp)
	lw $t0, -328($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -328($fp)
	lw $t0, -328($fp)
	add $t2, $t0, $fp
	sw $t2, -328($fp)
	lw $t0, -328($fp)
	l.s $f0, 0($t0)
	li $v0, 2
	mov.s $f12, $f0
	syscall
	li $v0, 4
	la $a0, -328($fp)
	li $t0, 9
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $t0, 3
	li $t1, 1
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
	lw $t0, -332($fp)
	l.s $f0, 0($t0)
	li $v0, 2
	mov.s $f12, $f0
	syscall
	li $v0, 4
	la $a0, -328($fp)
	li $t0, 9
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $v0, 4
	la $a0, -324($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -336($fp)
	lw $t0, -336($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -336($fp)
	li $t0, 9
	lw $t1, -336($fp)
	add $t2, $t0, $t1
	sw $t2, -336($fp)
	lw $t0, -336($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -336($fp)
	lw $t0, -336($fp)
	add $t2, $t0, $fp
	sw $t2, -336($fp)
	lw $t0, -336($fp)
	l.s $f0, 0($t0)
	li $v0, 2
	mov.s $f12, $f0
	syscall
	li $v0, 4
	la $a0, -328($fp)
	li $t0, 9
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -340($fp)
	lw $t0, -340($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -340($fp)
	li $t0, 9
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
	l.s $f0, 0($t0)
	li $v0, 2
	mov.s $f12, $f0
	syscall
	li $v0, 4
	la $a0, -328($fp)
	li $t0, 9
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -344($fp)
	lw $t0, -344($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -344($fp)
	li $t0, 9
	lw $t1, -344($fp)
	add $t2, $t0, $t1
	sw $t2, -344($fp)
	lw $t0, -344($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -344($fp)
	lw $t0, -344($fp)
	add $t2, $t0, $fp
	sw $t2, -344($fp)
	lw $t0, -344($fp)
	l.s $f0, 0($t0)
	li $v0, 2
	mov.s $f12, $f0
	syscall
	li $v0, 4
	la $a0, -328($fp)
	li $t0, 9
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $v0, 4
	la $a0, -324($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $v0, 10
	syscall
