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
	li.s $f1, 1.000000
	add.s $f2, $f0, $f1
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
	li.s $f1, 1.000000
	add.s $f2, $f0, $f1
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
	li.s $f1, 1.000000
	add.s $f2, $f0, $f1
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
	li.s $f1, 1.000000
	add.s $f2, $f0, $f1
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
	li.s $f1, 1.000000
	add.s $f2, $f0, $f1
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
	li.s $f1, 1.000000
	add.s $f2, $f0, $f1
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
	li.s $f1, 1.000000
	add.s $f2, $f0, $f1
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
	li.s $f1, 1.000000
	add.s $f2, $f0, $f1
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
	li.s $f1, 1.000000
	add.s $f2, $f0, $f1
	s.s $f2, 0($t0)
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -268($fp)
	lw $t0, -268($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -268($fp)
	li $t0, 57
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
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -284($fp)
	lw $t0, -284($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -284($fp)
	li $t0, 24
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
	lw $t0, -268($fp)
	lw $t1, -276($fp)
	l.s $f0, 0($t1)
	lw $t2, -284($fp)
	l.s $f1, 0($t2)
	add.s $f2, $f0, $f1
	s.s $f2, 0($t0)
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -280($fp)
	lw $t0, -280($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -280($fp)
	li $t0, 57
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
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -288($fp)
	lw $t0, -288($fp)
	li $t1, 1
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
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -296($fp)
	lw $t0, -296($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -296($fp)
	li $t0, 24
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
	lw $t0, -280($fp)
	lw $t1, -288($fp)
	l.s $f0, 0($t1)
	lw $t2, -296($fp)
	l.s $f1, 0($t2)
	add.s $f2, $f0, $f1
	s.s $f2, 0($t0)
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -292($fp)
	lw $t0, -292($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -292($fp)
	li $t0, 57
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
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -300($fp)
	lw $t0, -300($fp)
	li $t1, 2
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
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -308($fp)
	lw $t0, -308($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -308($fp)
	li $t0, 24
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
	lw $t0, -292($fp)
	lw $t1, -300($fp)
	l.s $f0, 0($t1)
	lw $t2, -308($fp)
	l.s $f1, 0($t2)
	add.s $f2, $f0, $f1
	s.s $f2, 0($t0)
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -304($fp)
	lw $t0, -304($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -304($fp)
	li $t0, 57
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
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -312($fp)
	lw $t0, -312($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -312($fp)
	li $t0, 39
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
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -320($fp)
	lw $t0, -320($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -320($fp)
	li $t0, 24
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
	lw $t0, -304($fp)
	lw $t1, -312($fp)
	l.s $f0, 0($t1)
	lw $t2, -320($fp)
	l.s $f1, 0($t2)
	add.s $f2, $f0, $f1
	s.s $f2, 0($t0)
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -316($fp)
	lw $t0, -316($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -316($fp)
	li $t0, 57
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
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -324($fp)
	lw $t0, -324($fp)
	li $t1, 1
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
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -332($fp)
	lw $t0, -332($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -332($fp)
	li $t0, 24
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
	lw $t0, -316($fp)
	lw $t1, -324($fp)
	l.s $f0, 0($t1)
	lw $t2, -332($fp)
	l.s $f1, 0($t2)
	add.s $f2, $f0, $f1
	s.s $f2, 0($t0)
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -328($fp)
	lw $t0, -328($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -328($fp)
	li $t0, 57
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
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -336($fp)
	lw $t0, -336($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -336($fp)
	li $t0, 39
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
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -344($fp)
	lw $t0, -344($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -344($fp)
	li $t0, 24
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
	lw $t0, -328($fp)
	lw $t1, -336($fp)
	l.s $f0, 0($t1)
	lw $t2, -344($fp)
	l.s $f1, 0($t2)
	add.s $f2, $f0, $f1
	s.s $f2, 0($t0)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -340($fp)
	lw $t0, -340($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -340($fp)
	li $t0, 57
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
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -348($fp)
	lw $t0, -348($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -348($fp)
	li $t0, 39
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
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -356($fp)
	lw $t0, -356($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -356($fp)
	li $t0, 24
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
	lw $t0, -340($fp)
	lw $t1, -348($fp)
	l.s $f0, 0($t1)
	lw $t2, -356($fp)
	l.s $f1, 0($t2)
	add.s $f2, $f0, $f1
	s.s $f2, 0($t0)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -352($fp)
	lw $t0, -352($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -352($fp)
	li $t0, 57
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
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -360($fp)
	lw $t0, -360($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -360($fp)
	li $t0, 39
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
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -368($fp)
	lw $t0, -368($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -368($fp)
	li $t0, 24
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
	lw $t0, -352($fp)
	lw $t1, -360($fp)
	l.s $f0, 0($t1)
	lw $t2, -368($fp)
	l.s $f1, 0($t2)
	add.s $f2, $f0, $f1
	s.s $f2, 0($t0)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -364($fp)
	lw $t0, -364($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -364($fp)
	li $t0, 57
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
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -372($fp)
	lw $t0, -372($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -372($fp)
	li $t0, 39
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
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -380($fp)
	lw $t0, -380($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -380($fp)
	li $t0, 24
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
	lw $t0, -364($fp)
	lw $t1, -372($fp)
	l.s $f0, 0($t1)
	lw $t2, -380($fp)
	l.s $f1, 0($t2)
	add.s $f2, $f0, $f1
	s.s $f2, 0($t0)
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -412($fp)
	lw $t0, -412($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -412($fp)
	li $t0, 93
	lw $t1, -412($fp)
	add $t2, $t0, $t1
	sw $t2, -412($fp)
	lw $t0, -412($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -412($fp)
	lw $t0, -412($fp)
	add $t2, $t0, $fp
	sw $t2, -412($fp)
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -420($fp)
	lw $t0, -420($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -420($fp)
	li $t0, 57
	lw $t1, -420($fp)
	add $t2, $t0, $t1
	sw $t2, -420($fp)
	lw $t0, -420($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -420($fp)
	lw $t0, -420($fp)
	add $t2, $t0, $fp
	sw $t2, -420($fp)
	lw $t0, -412($fp)
	lw $t1, -420($fp)
	l.s $f0, 0($t1)
	li.s $f1, 1.300000
	add.s $f2, $f0, $f1
	s.s $f2, 0($t0)
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -416($fp)
	lw $t0, -416($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -416($fp)
	li $t0, 93
	lw $t1, -416($fp)
	add $t2, $t0, $t1
	sw $t2, -416($fp)
	lw $t0, -416($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -416($fp)
	lw $t0, -416($fp)
	add $t2, $t0, $fp
	sw $t2, -416($fp)
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -424($fp)
	lw $t0, -424($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -424($fp)
	li $t0, 57
	lw $t1, -424($fp)
	add $t2, $t0, $t1
	sw $t2, -424($fp)
	lw $t0, -424($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -424($fp)
	lw $t0, -424($fp)
	add $t2, $t0, $fp
	sw $t2, -424($fp)
	lw $t0, -416($fp)
	lw $t1, -424($fp)
	l.s $f0, 0($t1)
	li.s $f1, 1.300000
	add.s $f2, $f0, $f1
	s.s $f2, 0($t0)
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -420($fp)
	lw $t0, -420($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -420($fp)
	li $t0, 93
	lw $t1, -420($fp)
	add $t2, $t0, $t1
	sw $t2, -420($fp)
	lw $t0, -420($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -420($fp)
	lw $t0, -420($fp)
	add $t2, $t0, $fp
	sw $t2, -420($fp)
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -428($fp)
	lw $t0, -428($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -428($fp)
	li $t0, 57
	lw $t1, -428($fp)
	add $t2, $t0, $t1
	sw $t2, -428($fp)
	lw $t0, -428($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -428($fp)
	lw $t0, -428($fp)
	add $t2, $t0, $fp
	sw $t2, -428($fp)
	lw $t0, -420($fp)
	lw $t1, -428($fp)
	l.s $f0, 0($t1)
	li.s $f1, 1.300000
	add.s $f2, $f0, $f1
	s.s $f2, 0($t0)
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -424($fp)
	lw $t0, -424($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -424($fp)
	li $t0, 93
	lw $t1, -424($fp)
	add $t2, $t0, $t1
	sw $t2, -424($fp)
	lw $t0, -424($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -424($fp)
	lw $t0, -424($fp)
	add $t2, $t0, $fp
	sw $t2, -424($fp)
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -432($fp)
	lw $t0, -432($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -432($fp)
	li $t0, 57
	lw $t1, -432($fp)
	add $t2, $t0, $t1
	sw $t2, -432($fp)
	lw $t0, -432($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -432($fp)
	lw $t0, -432($fp)
	add $t2, $t0, $fp
	sw $t2, -432($fp)
	lw $t0, -424($fp)
	lw $t1, -432($fp)
	l.s $f0, 0($t1)
	li.s $f1, 1.300000
	add.s $f2, $f0, $f1
	s.s $f2, 0($t0)
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -428($fp)
	lw $t0, -428($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -428($fp)
	li $t0, 93
	lw $t1, -428($fp)
	add $t2, $t0, $t1
	sw $t2, -428($fp)
	lw $t0, -428($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -428($fp)
	lw $t0, -428($fp)
	add $t2, $t0, $fp
	sw $t2, -428($fp)
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -436($fp)
	lw $t0, -436($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -436($fp)
	li $t0, 57
	lw $t1, -436($fp)
	add $t2, $t0, $t1
	sw $t2, -436($fp)
	lw $t0, -436($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -436($fp)
	lw $t0, -436($fp)
	add $t2, $t0, $fp
	sw $t2, -436($fp)
	lw $t0, -428($fp)
	lw $t1, -436($fp)
	l.s $f0, 0($t1)
	li.s $f1, 1.300000
	add.s $f2, $f0, $f1
	s.s $f2, 0($t0)
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -432($fp)
	lw $t0, -432($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -432($fp)
	li $t0, 93
	lw $t1, -432($fp)
	add $t2, $t0, $t1
	sw $t2, -432($fp)
	lw $t0, -432($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -432($fp)
	lw $t0, -432($fp)
	add $t2, $t0, $fp
	sw $t2, -432($fp)
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -440($fp)
	lw $t0, -440($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -440($fp)
	li $t0, 57
	lw $t1, -440($fp)
	add $t2, $t0, $t1
	sw $t2, -440($fp)
	lw $t0, -440($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -440($fp)
	lw $t0, -440($fp)
	add $t2, $t0, $fp
	sw $t2, -440($fp)
	lw $t0, -432($fp)
	lw $t1, -440($fp)
	l.s $f0, 0($t1)
	li.s $f1, 1.300000
	add.s $f2, $f0, $f1
	s.s $f2, 0($t0)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -436($fp)
	lw $t0, -436($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -436($fp)
	li $t0, 93
	lw $t1, -436($fp)
	add $t2, $t0, $t1
	sw $t2, -436($fp)
	lw $t0, -436($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -436($fp)
	lw $t0, -436($fp)
	add $t2, $t0, $fp
	sw $t2, -436($fp)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -444($fp)
	lw $t0, -444($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -444($fp)
	li $t0, 57
	lw $t1, -444($fp)
	add $t2, $t0, $t1
	sw $t2, -444($fp)
	lw $t0, -444($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -444($fp)
	lw $t0, -444($fp)
	add $t2, $t0, $fp
	sw $t2, -444($fp)
	lw $t0, -436($fp)
	lw $t1, -444($fp)
	l.s $f0, 0($t1)
	li.s $f1, 1.300000
	add.s $f2, $f0, $f1
	s.s $f2, 0($t0)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -440($fp)
	lw $t0, -440($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -440($fp)
	li $t0, 93
	lw $t1, -440($fp)
	add $t2, $t0, $t1
	sw $t2, -440($fp)
	lw $t0, -440($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -440($fp)
	lw $t0, -440($fp)
	add $t2, $t0, $fp
	sw $t2, -440($fp)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -448($fp)
	lw $t0, -448($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -448($fp)
	li $t0, 57
	lw $t1, -448($fp)
	add $t2, $t0, $t1
	sw $t2, -448($fp)
	lw $t0, -448($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -448($fp)
	lw $t0, -448($fp)
	add $t2, $t0, $fp
	sw $t2, -448($fp)
	lw $t0, -440($fp)
	lw $t1, -448($fp)
	l.s $f0, 0($t1)
	li.s $f1, 1.300000
	add.s $f2, $f0, $f1
	s.s $f2, 0($t0)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -444($fp)
	lw $t0, -444($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -444($fp)
	li $t0, 93
	lw $t1, -444($fp)
	add $t2, $t0, $t1
	sw $t2, -444($fp)
	lw $t0, -444($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -444($fp)
	lw $t0, -444($fp)
	add $t2, $t0, $fp
	sw $t2, -444($fp)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -452($fp)
	lw $t0, -452($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -452($fp)
	li $t0, 57
	lw $t1, -452($fp)
	add $t2, $t0, $t1
	sw $t2, -452($fp)
	lw $t0, -452($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -452($fp)
	lw $t0, -452($fp)
	add $t2, $t0, $fp
	sw $t2, -452($fp)
	lw $t0, -444($fp)
	lw $t1, -452($fp)
	l.s $f0, 0($t1)
	li.s $f1, 1.300000
	add.s $f2, $f0, $f1
	s.s $f2, 0($t0)
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -448($fp)
	lw $t0, -448($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -448($fp)
	li $t0, 9
	lw $t1, -448($fp)
	add $t2, $t0, $t1
	sw $t2, -448($fp)
	lw $t0, -448($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -448($fp)
	lw $t0, -448($fp)
	add $t2, $t0, $fp
	sw $t2, -448($fp)
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -456($fp)
	lw $t0, -456($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -456($fp)
	li $t0, 93
	lw $t1, -456($fp)
	add $t2, $t0, $t1
	sw $t2, -456($fp)
	lw $t0, -456($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -456($fp)
	lw $t0, -456($fp)
	add $t2, $t0, $fp
	sw $t2, -456($fp)
	lw $t0, -456($fp)
	l.s $f0, 0($t0)
	lw $t1, -448($fp)
	s.s $f0, 0($t1)
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -456($fp)
	lw $t0, -456($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -456($fp)
	li $t0, 9
	lw $t1, -456($fp)
	add $t2, $t0, $t1
	sw $t2, -456($fp)
	lw $t0, -456($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -456($fp)
	lw $t0, -456($fp)
	add $t2, $t0, $fp
	sw $t2, -456($fp)
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -464($fp)
	lw $t0, -464($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -464($fp)
	li $t0, 93
	lw $t1, -464($fp)
	add $t2, $t0, $t1
	sw $t2, -464($fp)
	lw $t0, -464($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -464($fp)
	lw $t0, -464($fp)
	add $t2, $t0, $fp
	sw $t2, -464($fp)
	lw $t0, -464($fp)
	l.s $f0, 0($t0)
	lw $t1, -456($fp)
	s.s $f0, 0($t1)
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -464($fp)
	lw $t0, -464($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -464($fp)
	li $t0, 9
	lw $t1, -464($fp)
	add $t2, $t0, $t1
	sw $t2, -464($fp)
	lw $t0, -464($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -464($fp)
	lw $t0, -464($fp)
	add $t2, $t0, $fp
	sw $t2, -464($fp)
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -472($fp)
	lw $t0, -472($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -472($fp)
	li $t0, 93
	lw $t1, -472($fp)
	add $t2, $t0, $t1
	sw $t2, -472($fp)
	lw $t0, -472($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -472($fp)
	lw $t0, -472($fp)
	add $t2, $t0, $fp
	sw $t2, -472($fp)
	lw $t0, -472($fp)
	l.s $f0, 0($t0)
	lw $t1, -464($fp)
	s.s $f0, 0($t1)
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -472($fp)
	lw $t0, -472($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -472($fp)
	li $t0, 9
	lw $t1, -472($fp)
	add $t2, $t0, $t1
	sw $t2, -472($fp)
	lw $t0, -472($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -472($fp)
	lw $t0, -472($fp)
	add $t2, $t0, $fp
	sw $t2, -472($fp)
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -480($fp)
	lw $t0, -480($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -480($fp)
	li $t0, 93
	lw $t1, -480($fp)
	add $t2, $t0, $t1
	sw $t2, -480($fp)
	lw $t0, -480($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -480($fp)
	lw $t0, -480($fp)
	add $t2, $t0, $fp
	sw $t2, -480($fp)
	lw $t0, -480($fp)
	l.s $f0, 0($t0)
	lw $t1, -472($fp)
	s.s $f0, 0($t1)
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -480($fp)
	lw $t0, -480($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -480($fp)
	li $t0, 9
	lw $t1, -480($fp)
	add $t2, $t0, $t1
	sw $t2, -480($fp)
	lw $t0, -480($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -480($fp)
	lw $t0, -480($fp)
	add $t2, $t0, $fp
	sw $t2, -480($fp)
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -488($fp)
	lw $t0, -488($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -488($fp)
	li $t0, 93
	lw $t1, -488($fp)
	add $t2, $t0, $t1
	sw $t2, -488($fp)
	lw $t0, -488($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -488($fp)
	lw $t0, -488($fp)
	add $t2, $t0, $fp
	sw $t2, -488($fp)
	lw $t0, -488($fp)
	l.s $f0, 0($t0)
	lw $t1, -480($fp)
	s.s $f0, 0($t1)
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -488($fp)
	lw $t0, -488($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -488($fp)
	li $t0, 9
	lw $t1, -488($fp)
	add $t2, $t0, $t1
	sw $t2, -488($fp)
	lw $t0, -488($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -488($fp)
	lw $t0, -488($fp)
	add $t2, $t0, $fp
	sw $t2, -488($fp)
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -496($fp)
	lw $t0, -496($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -496($fp)
	li $t0, 93
	lw $t1, -496($fp)
	add $t2, $t0, $t1
	sw $t2, -496($fp)
	lw $t0, -496($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -496($fp)
	lw $t0, -496($fp)
	add $t2, $t0, $fp
	sw $t2, -496($fp)
	lw $t0, -496($fp)
	l.s $f0, 0($t0)
	lw $t1, -488($fp)
	s.s $f0, 0($t1)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -496($fp)
	lw $t0, -496($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -496($fp)
	li $t0, 9
	lw $t1, -496($fp)
	add $t2, $t0, $t1
	sw $t2, -496($fp)
	lw $t0, -496($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -496($fp)
	lw $t0, -496($fp)
	add $t2, $t0, $fp
	sw $t2, -496($fp)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -504($fp)
	lw $t0, -504($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -504($fp)
	li $t0, 93
	lw $t1, -504($fp)
	add $t2, $t0, $t1
	sw $t2, -504($fp)
	lw $t0, -504($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -504($fp)
	lw $t0, -504($fp)
	add $t2, $t0, $fp
	sw $t2, -504($fp)
	lw $t0, -504($fp)
	l.s $f0, 0($t0)
	lw $t1, -496($fp)
	s.s $f0, 0($t1)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -504($fp)
	lw $t0, -504($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -504($fp)
	li $t0, 9
	lw $t1, -504($fp)
	add $t2, $t0, $t1
	sw $t2, -504($fp)
	lw $t0, -504($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -504($fp)
	lw $t0, -504($fp)
	add $t2, $t0, $fp
	sw $t2, -504($fp)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -512($fp)
	lw $t0, -512($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -512($fp)
	li $t0, 93
	lw $t1, -512($fp)
	add $t2, $t0, $t1
	sw $t2, -512($fp)
	lw $t0, -512($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -512($fp)
	lw $t0, -512($fp)
	add $t2, $t0, $fp
	sw $t2, -512($fp)
	lw $t0, -512($fp)
	l.s $f0, 0($t0)
	lw $t1, -504($fp)
	s.s $f0, 0($t1)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -512($fp)
	lw $t0, -512($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -512($fp)
	li $t0, 9
	lw $t1, -512($fp)
	add $t2, $t0, $t1
	sw $t2, -512($fp)
	lw $t0, -512($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -512($fp)
	lw $t0, -512($fp)
	add $t2, $t0, $fp
	sw $t2, -512($fp)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -520($fp)
	lw $t0, -520($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -520($fp)
	li $t0, 93
	lw $t1, -520($fp)
	add $t2, $t0, $t1
	sw $t2, -520($fp)
	lw $t0, -520($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -520($fp)
	lw $t0, -520($fp)
	add $t2, $t0, $fp
	sw $t2, -520($fp)
	lw $t0, -520($fp)
	l.s $f0, 0($t0)
	lw $t1, -512($fp)
	s.s $f0, 0($t1)
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -528($fp)
	lw $t0, -528($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -528($fp)
	li $t0, 9
	lw $t1, -528($fp)
	add $t2, $t0, $t1
	sw $t2, -528($fp)
	lw $t0, -528($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -528($fp)
	lw $t0, -528($fp)
	add $t2, $t0, $fp
	sw $t2, -528($fp)
	lw $t0, -528($fp)
	l.s $f0, 0($t0)
	li $v0, 2
	mov.s $f12, $f0
	syscall
	li $v0, 4
	la $a0, -544($fp)
	li $t0, 9
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -532($fp)
	lw $t0, -532($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -532($fp)
	li $t0, 9
	lw $t1, -532($fp)
	add $t2, $t0, $t1
	sw $t2, -532($fp)
	lw $t0, -532($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -532($fp)
	lw $t0, -532($fp)
	add $t2, $t0, $fp
	sw $t2, -532($fp)
	lw $t0, -532($fp)
	l.s $f0, 0($t0)
	li $v0, 2
	mov.s $f12, $f0
	syscall
	li $v0, 4
	la $a0, -544($fp)
	li $t0, 9
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -536($fp)
	lw $t0, -536($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -536($fp)
	li $t0, 9
	lw $t1, -536($fp)
	add $t2, $t0, $t1
	sw $t2, -536($fp)
	lw $t0, -536($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -536($fp)
	lw $t0, -536($fp)
	add $t2, $t0, $fp
	sw $t2, -536($fp)
	lw $t0, -536($fp)
	l.s $f0, 0($t0)
	li $v0, 2
	mov.s $f12, $f0
	syscall
	li $v0, 4
	la $a0, -544($fp)
	li $t0, 9
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $v0, 4
	la $a0, -540($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -540($fp)
	lw $t0, -540($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -540($fp)
	li $t0, 9
	lw $t1, -540($fp)
	add $t2, $t0, $t1
	sw $t2, -540($fp)
	lw $t0, -540($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -540($fp)
	lw $t0, -540($fp)
	add $t2, $t0, $fp
	sw $t2, -540($fp)
	lw $t0, -540($fp)
	l.s $f0, 0($t0)
	li $v0, 2
	mov.s $f12, $f0
	syscall
	li $v0, 4
	la $a0, -544($fp)
	li $t0, 9
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -544($fp)
	lw $t0, -544($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -544($fp)
	li $t0, 9
	lw $t1, -544($fp)
	add $t2, $t0, $t1
	sw $t2, -544($fp)
	lw $t0, -544($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -544($fp)
	lw $t0, -544($fp)
	add $t2, $t0, $fp
	sw $t2, -544($fp)
	lw $t0, -544($fp)
	l.s $f0, 0($t0)
	li $v0, 2
	mov.s $f12, $f0
	syscall
	li $v0, 4
	la $a0, -544($fp)
	li $t0, 9
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -548($fp)
	lw $t0, -548($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -548($fp)
	li $t0, 9
	lw $t1, -548($fp)
	add $t2, $t0, $t1
	sw $t2, -548($fp)
	lw $t0, -548($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -548($fp)
	lw $t0, -548($fp)
	add $t2, $t0, $fp
	sw $t2, -548($fp)
	lw $t0, -548($fp)
	l.s $f0, 0($t0)
	li $v0, 2
	mov.s $f12, $f0
	syscall
	li $v0, 4
	la $a0, -544($fp)
	li $t0, 9
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $v0, 4
	la $a0, -540($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -552($fp)
	lw $t0, -552($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -552($fp)
	li $t0, 9
	lw $t1, -552($fp)
	add $t2, $t0, $t1
	sw $t2, -552($fp)
	lw $t0, -552($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -552($fp)
	lw $t0, -552($fp)
	add $t2, $t0, $fp
	sw $t2, -552($fp)
	lw $t0, -552($fp)
	l.s $f0, 0($t0)
	li $v0, 2
	mov.s $f12, $f0
	syscall
	li $v0, 4
	la $a0, -544($fp)
	li $t0, 9
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -556($fp)
	lw $t0, -556($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -556($fp)
	li $t0, 9
	lw $t1, -556($fp)
	add $t2, $t0, $t1
	sw $t2, -556($fp)
	lw $t0, -556($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -556($fp)
	lw $t0, -556($fp)
	add $t2, $t0, $fp
	sw $t2, -556($fp)
	lw $t0, -556($fp)
	l.s $f0, 0($t0)
	li $v0, 2
	mov.s $f12, $f0
	syscall
	li $v0, 4
	la $a0, -544($fp)
	li $t0, 9
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -560($fp)
	lw $t0, -560($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -560($fp)
	li $t0, 9
	lw $t1, -560($fp)
	add $t2, $t0, $t1
	sw $t2, -560($fp)
	lw $t0, -560($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -560($fp)
	lw $t0, -560($fp)
	add $t2, $t0, $fp
	sw $t2, -560($fp)
	lw $t0, -560($fp)
	l.s $f0, 0($t0)
	li $v0, 2
	mov.s $f12, $f0
	syscall
	li $v0, 4
	la $a0, -544($fp)
	li $t0, 9
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $v0, 4
	la $a0, -540($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $v0, 10
	syscall
