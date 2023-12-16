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
	sw $t2, -304($fp)
	lw $t0, -304($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -304($fp)
	li $t0, 66
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
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -312($fp)
	lw $t0, -312($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -312($fp)
	li $t0, 24
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
	lw $t0, -304($fp)
	lw $t1, -312($fp)
	l.s $f9, 0($t1)
	li.s $f10, 2.000000
	mul.s $f11, $f9, $f10
	s.s $f11, 0($t0)
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -312($fp)
	lw $t0, -312($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -312($fp)
	li $t0, 66
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
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -320($fp)
	lw $t0, -320($fp)
	li $t1, 1
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
	lw $t0, -312($fp)
	lw $t1, -320($fp)
	l.s $f9, 0($t1)
	li.s $f10, 2.000000
	mul.s $f11, $f9, $f10
	s.s $f11, 0($t0)
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -320($fp)
	lw $t0, -320($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -320($fp)
	li $t0, 66
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
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -328($fp)
	lw $t0, -328($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -328($fp)
	li $t0, 24
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
	lw $t0, -320($fp)
	lw $t1, -328($fp)
	l.s $f9, 0($t1)
	li.s $f10, 2.000000
	mul.s $f11, $f9, $f10
	s.s $f11, 0($t0)
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -328($fp)
	lw $t0, -328($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -328($fp)
	li $t0, 66
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
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -336($fp)
	li $t0, 24
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
	lw $t0, -328($fp)
	lw $t1, -336($fp)
	l.s $f9, 0($t1)
	li.s $f10, 2.000000
	mul.s $f11, $f9, $f10
	s.s $f11, 0($t0)
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -336($fp)
	lw $t0, -336($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -336($fp)
	li $t0, 66
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
	li $t1, 1
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
	lw $t0, -336($fp)
	lw $t1, -344($fp)
	l.s $f9, 0($t1)
	li.s $f10, 2.000000
	mul.s $f11, $f9, $f10
	s.s $f11, 0($t0)
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -344($fp)
	lw $t0, -344($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -344($fp)
	li $t0, 66
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
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -352($fp)
	lw $t0, -352($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -352($fp)
	li $t0, 24
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
	lw $t0, -344($fp)
	lw $t1, -352($fp)
	l.s $f9, 0($t1)
	li.s $f10, 2.000000
	mul.s $f11, $f9, $f10
	s.s $f11, 0($t0)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -352($fp)
	lw $t0, -352($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -352($fp)
	li $t0, 66
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
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -360($fp)
	li $t0, 24
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
	lw $t0, -352($fp)
	lw $t1, -360($fp)
	l.s $f9, 0($t1)
	li.s $f10, 2.000000
	mul.s $f11, $f9, $f10
	s.s $f11, 0($t0)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -360($fp)
	lw $t0, -360($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -360($fp)
	li $t0, 66
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
	lw $t0, -360($fp)
	lw $t1, -368($fp)
	l.s $f9, 0($t1)
	li.s $f10, 2.000000
	mul.s $f11, $f9, $f10
	s.s $f11, 0($t0)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -368($fp)
	lw $t0, -368($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -368($fp)
	li $t0, 66
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
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -376($fp)
	lw $t0, -376($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -376($fp)
	li $t0, 24
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
	lw $t0, -368($fp)
	lw $t1, -376($fp)
	l.s $f9, 0($t1)
	li.s $f10, 2.000000
	mul.s $f11, $f9, $f10
	s.s $f11, 0($t0)
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
	li $t0, 39
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
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -428($fp)
	li $t0, 66
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
	lw $t0, -412($fp)
	lw $t1, -420($fp)
	l.s $f9, 0($t1)
	lw $t2, -428($fp)
	l.s $f10, 0($t2)
	add.s $f11, $f9, $f10
	s.s $f11, 0($t0)
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -424($fp)
	lw $t0, -424($fp)
	li $t1, 1
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
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -432($fp)
	lw $t0, -432($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -432($fp)
	li $t0, 39
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
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -440($fp)
	lw $t0, -440($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -440($fp)
	li $t0, 66
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
	lw $t0, -424($fp)
	lw $t1, -432($fp)
	l.s $f9, 0($t1)
	lw $t2, -440($fp)
	l.s $f10, 0($t2)
	add.s $f11, $f9, $f10
	s.s $f11, 0($t0)
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -436($fp)
	lw $t0, -436($fp)
	li $t1, 2
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
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -444($fp)
	lw $t0, -444($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -444($fp)
	li $t0, 39
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
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -452($fp)
	lw $t0, -452($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -452($fp)
	li $t0, 66
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
	lw $t0, -436($fp)
	lw $t1, -444($fp)
	l.s $f9, 0($t1)
	lw $t2, -452($fp)
	l.s $f10, 0($t2)
	add.s $f11, $f9, $f10
	s.s $f11, 0($t0)
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -448($fp)
	lw $t0, -448($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -448($fp)
	li $t0, 93
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
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -456($fp)
	lw $t0, -456($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -456($fp)
	li $t0, 39
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
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -464($fp)
	lw $t0, -464($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -464($fp)
	li $t0, 66
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
	lw $t0, -448($fp)
	lw $t1, -456($fp)
	l.s $f9, 0($t1)
	lw $t2, -464($fp)
	l.s $f10, 0($t2)
	add.s $f11, $f9, $f10
	s.s $f11, 0($t0)
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -460($fp)
	lw $t0, -460($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -460($fp)
	li $t0, 93
	lw $t1, -460($fp)
	add $t2, $t0, $t1
	sw $t2, -460($fp)
	lw $t0, -460($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -460($fp)
	lw $t0, -460($fp)
	add $t2, $t0, $fp
	sw $t2, -460($fp)
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -468($fp)
	lw $t0, -468($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -468($fp)
	li $t0, 39
	lw $t1, -468($fp)
	add $t2, $t0, $t1
	sw $t2, -468($fp)
	lw $t0, -468($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -468($fp)
	lw $t0, -468($fp)
	add $t2, $t0, $fp
	sw $t2, -468($fp)
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -476($fp)
	lw $t0, -476($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -476($fp)
	li $t0, 66
	lw $t1, -476($fp)
	add $t2, $t0, $t1
	sw $t2, -476($fp)
	lw $t0, -476($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -476($fp)
	lw $t0, -476($fp)
	add $t2, $t0, $fp
	sw $t2, -476($fp)
	lw $t0, -460($fp)
	lw $t1, -468($fp)
	l.s $f9, 0($t1)
	lw $t2, -476($fp)
	l.s $f10, 0($t2)
	add.s $f11, $f9, $f10
	s.s $f11, 0($t0)
	li $t0, 3
	li $t1, 1
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
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -480($fp)
	lw $t0, -480($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -480($fp)
	li $t0, 39
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
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -488($fp)
	li $t0, 66
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
	lw $t0, -472($fp)
	lw $t1, -480($fp)
	l.s $f9, 0($t1)
	lw $t2, -488($fp)
	l.s $f10, 0($t2)
	add.s $f11, $f9, $f10
	s.s $f11, 0($t0)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -484($fp)
	lw $t0, -484($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -484($fp)
	li $t0, 93
	lw $t1, -484($fp)
	add $t2, $t0, $t1
	sw $t2, -484($fp)
	lw $t0, -484($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -484($fp)
	lw $t0, -484($fp)
	add $t2, $t0, $fp
	sw $t2, -484($fp)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -492($fp)
	lw $t0, -492($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -492($fp)
	li $t0, 39
	lw $t1, -492($fp)
	add $t2, $t0, $t1
	sw $t2, -492($fp)
	lw $t0, -492($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -492($fp)
	lw $t0, -492($fp)
	add $t2, $t0, $fp
	sw $t2, -492($fp)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -500($fp)
	lw $t0, -500($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -500($fp)
	li $t0, 66
	lw $t1, -500($fp)
	add $t2, $t0, $t1
	sw $t2, -500($fp)
	lw $t0, -500($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -500($fp)
	lw $t0, -500($fp)
	add $t2, $t0, $fp
	sw $t2, -500($fp)
	lw $t0, -484($fp)
	lw $t1, -492($fp)
	l.s $f9, 0($t1)
	lw $t2, -500($fp)
	l.s $f10, 0($t2)
	add.s $f11, $f9, $f10
	s.s $f11, 0($t0)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -496($fp)
	lw $t0, -496($fp)
	li $t1, 1
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
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -504($fp)
	lw $t0, -504($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -504($fp)
	li $t0, 39
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
	li $t0, 66
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
	lw $t0, -496($fp)
	lw $t1, -504($fp)
	l.s $f9, 0($t1)
	lw $t2, -512($fp)
	l.s $f10, 0($t2)
	add.s $f11, $f9, $f10
	s.s $f11, 0($t0)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -508($fp)
	lw $t0, -508($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -508($fp)
	li $t0, 93
	lw $t1, -508($fp)
	add $t2, $t0, $t1
	sw $t2, -508($fp)
	lw $t0, -508($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -508($fp)
	lw $t0, -508($fp)
	add $t2, $t0, $fp
	sw $t2, -508($fp)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -516($fp)
	lw $t0, -516($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -516($fp)
	li $t0, 39
	lw $t1, -516($fp)
	add $t2, $t0, $t1
	sw $t2, -516($fp)
	lw $t0, -516($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -516($fp)
	lw $t0, -516($fp)
	add $t2, $t0, $fp
	sw $t2, -516($fp)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -524($fp)
	lw $t0, -524($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -524($fp)
	li $t0, 66
	lw $t1, -524($fp)
	add $t2, $t0, $t1
	sw $t2, -524($fp)
	lw $t0, -524($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -524($fp)
	lw $t0, -524($fp)
	add $t2, $t0, $fp
	sw $t2, -524($fp)
	lw $t0, -508($fp)
	lw $t1, -516($fp)
	l.s $f9, 0($t1)
	lw $t2, -524($fp)
	l.s $f10, 0($t2)
	add.s $f11, $f9, $f10
	s.s $f11, 0($t0)
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -520($fp)
	lw $t0, -520($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -520($fp)
	li $t0, 9
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
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -528($fp)
	lw $t0, -528($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -528($fp)
	li $t0, 93
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
	l.s $f9, 0($t0)
	lw $t1, -520($fp)
	s.s $f9, 0($t1)
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -528($fp)
	lw $t0, -528($fp)
	li $t1, 1
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
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -536($fp)
	lw $t0, -536($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -536($fp)
	li $t0, 93
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
	l.s $f9, 0($t0)
	lw $t1, -528($fp)
	s.s $f9, 0($t1)
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
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -544($fp)
	lw $t0, -544($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -544($fp)
	li $t0, 93
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
	l.s $f9, 0($t0)
	lw $t1, -536($fp)
	s.s $f9, 0($t1)
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -544($fp)
	lw $t0, -544($fp)
	li $t1, 0
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
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -552($fp)
	lw $t0, -552($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -552($fp)
	li $t0, 93
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
	l.s $f9, 0($t0)
	lw $t1, -544($fp)
	s.s $f9, 0($t1)
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -552($fp)
	lw $t0, -552($fp)
	li $t1, 1
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
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -560($fp)
	lw $t0, -560($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -560($fp)
	li $t0, 93
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
	l.s $f9, 0($t0)
	lw $t1, -552($fp)
	s.s $f9, 0($t1)
	li $t0, 3
	li $t1, 1
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
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -568($fp)
	lw $t0, -568($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -568($fp)
	li $t0, 93
	lw $t1, -568($fp)
	add $t2, $t0, $t1
	sw $t2, -568($fp)
	lw $t0, -568($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -568($fp)
	lw $t0, -568($fp)
	add $t2, $t0, $fp
	sw $t2, -568($fp)
	lw $t0, -568($fp)
	l.s $f9, 0($t0)
	lw $t1, -560($fp)
	s.s $f9, 0($t1)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -568($fp)
	lw $t0, -568($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -568($fp)
	li $t0, 9
	lw $t1, -568($fp)
	add $t2, $t0, $t1
	sw $t2, -568($fp)
	lw $t0, -568($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -568($fp)
	lw $t0, -568($fp)
	add $t2, $t0, $fp
	sw $t2, -568($fp)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -576($fp)
	lw $t0, -576($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -576($fp)
	li $t0, 93
	lw $t1, -576($fp)
	add $t2, $t0, $t1
	sw $t2, -576($fp)
	lw $t0, -576($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -576($fp)
	lw $t0, -576($fp)
	add $t2, $t0, $fp
	sw $t2, -576($fp)
	lw $t0, -576($fp)
	l.s $f9, 0($t0)
	lw $t1, -568($fp)
	s.s $f9, 0($t1)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -576($fp)
	lw $t0, -576($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -576($fp)
	li $t0, 9
	lw $t1, -576($fp)
	add $t2, $t0, $t1
	sw $t2, -576($fp)
	lw $t0, -576($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -576($fp)
	lw $t0, -576($fp)
	add $t2, $t0, $fp
	sw $t2, -576($fp)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -584($fp)
	lw $t0, -584($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -584($fp)
	li $t0, 93
	lw $t1, -584($fp)
	add $t2, $t0, $t1
	sw $t2, -584($fp)
	lw $t0, -584($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -584($fp)
	lw $t0, -584($fp)
	add $t2, $t0, $fp
	sw $t2, -584($fp)
	lw $t0, -584($fp)
	l.s $f9, 0($t0)
	lw $t1, -576($fp)
	s.s $f9, 0($t1)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -584($fp)
	lw $t0, -584($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -584($fp)
	li $t0, 9
	lw $t1, -584($fp)
	add $t2, $t0, $t1
	sw $t2, -584($fp)
	lw $t0, -584($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -584($fp)
	lw $t0, -584($fp)
	add $t2, $t0, $fp
	sw $t2, -584($fp)
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -592($fp)
	lw $t0, -592($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -592($fp)
	li $t0, 93
	lw $t1, -592($fp)
	add $t2, $t0, $t1
	sw $t2, -592($fp)
	lw $t0, -592($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -592($fp)
	lw $t0, -592($fp)
	add $t2, $t0, $fp
	sw $t2, -592($fp)
	lw $t0, -592($fp)
	l.s $f9, 0($t0)
	lw $t1, -584($fp)
	s.s $f9, 0($t1)
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -600($fp)
	lw $t0, -600($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -600($fp)
	li $t0, 9
	lw $t1, -600($fp)
	add $t2, $t0, $t1
	sw $t2, -600($fp)
	lw $t0, -600($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -600($fp)
	lw $t0, -600($fp)
	add $t2, $t0, $fp
	sw $t2, -600($fp)
	lw $t0, -600($fp)
	l.s $f9, 0($t0)
	li $v0, 2
	mov.s $f12, $f9
	syscall
	li $v0, 4
	la $a0, -616($fp)
	li $t0, 9
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -604($fp)
	lw $t0, -604($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -604($fp)
	li $t0, 9
	lw $t1, -604($fp)
	add $t2, $t0, $t1
	sw $t2, -604($fp)
	lw $t0, -604($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -604($fp)
	lw $t0, -604($fp)
	add $t2, $t0, $fp
	sw $t2, -604($fp)
	lw $t0, -604($fp)
	l.s $f9, 0($t0)
	li $v0, 2
	mov.s $f12, $f9
	syscall
	li $v0, 4
	la $a0, -616($fp)
	li $t0, 9
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $t0, 3
	li $t1, 0
	mult $t0, $t1
	mflo $t2
	sw $t2, -608($fp)
	lw $t0, -608($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -608($fp)
	li $t0, 9
	lw $t1, -608($fp)
	add $t2, $t0, $t1
	sw $t2, -608($fp)
	lw $t0, -608($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -608($fp)
	lw $t0, -608($fp)
	add $t2, $t0, $fp
	sw $t2, -608($fp)
	lw $t0, -608($fp)
	l.s $f9, 0($t0)
	li $v0, 2
	mov.s $f12, $f9
	syscall
	li $v0, 4
	la $a0, -616($fp)
	li $t0, 9
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $v0, 4
	la $a0, -612($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -612($fp)
	lw $t0, -612($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -612($fp)
	li $t0, 9
	lw $t1, -612($fp)
	add $t2, $t0, $t1
	sw $t2, -612($fp)
	lw $t0, -612($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -612($fp)
	lw $t0, -612($fp)
	add $t2, $t0, $fp
	sw $t2, -612($fp)
	lw $t0, -612($fp)
	l.s $f9, 0($t0)
	li $v0, 2
	mov.s $f12, $f9
	syscall
	li $v0, 4
	la $a0, -616($fp)
	li $t0, 9
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -616($fp)
	lw $t0, -616($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -616($fp)
	li $t0, 9
	lw $t1, -616($fp)
	add $t2, $t0, $t1
	sw $t2, -616($fp)
	lw $t0, -616($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -616($fp)
	lw $t0, -616($fp)
	add $t2, $t0, $fp
	sw $t2, -616($fp)
	lw $t0, -616($fp)
	l.s $f9, 0($t0)
	li $v0, 2
	mov.s $f12, $f9
	syscall
	li $v0, 4
	la $a0, -616($fp)
	li $t0, 9
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $t0, 3
	li $t1, 1
	mult $t0, $t1
	mflo $t2
	sw $t2, -620($fp)
	lw $t0, -620($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -620($fp)
	li $t0, 9
	lw $t1, -620($fp)
	add $t2, $t0, $t1
	sw $t2, -620($fp)
	lw $t0, -620($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -620($fp)
	lw $t0, -620($fp)
	add $t2, $t0, $fp
	sw $t2, -620($fp)
	lw $t0, -620($fp)
	l.s $f9, 0($t0)
	li $v0, 2
	mov.s $f12, $f9
	syscall
	li $v0, 4
	la $a0, -616($fp)
	li $t0, 9
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $v0, 4
	la $a0, -612($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -624($fp)
	lw $t0, -624($fp)
	li $t1, 0
	add $t2, $t0, $t1
	sw $t2, -624($fp)
	li $t0, 9
	lw $t1, -624($fp)
	add $t2, $t0, $t1
	sw $t2, -624($fp)
	lw $t0, -624($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -624($fp)
	lw $t0, -624($fp)
	add $t2, $t0, $fp
	sw $t2, -624($fp)
	lw $t0, -624($fp)
	l.s $f9, 0($t0)
	li $v0, 2
	mov.s $f12, $f9
	syscall
	li $v0, 4
	la $a0, -616($fp)
	li $t0, 9
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -628($fp)
	lw $t0, -628($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -628($fp)
	li $t0, 9
	lw $t1, -628($fp)
	add $t2, $t0, $t1
	sw $t2, -628($fp)
	lw $t0, -628($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -628($fp)
	lw $t0, -628($fp)
	add $t2, $t0, $fp
	sw $t2, -628($fp)
	lw $t0, -628($fp)
	l.s $f9, 0($t0)
	li $v0, 2
	mov.s $f12, $f9
	syscall
	li $v0, 4
	la $a0, -616($fp)
	li $t0, 9
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $t0, 3
	li $t1, 2
	mult $t0, $t1
	mflo $t2
	sw $t2, -632($fp)
	lw $t0, -632($fp)
	li $t1, 2
	add $t2, $t0, $t1
	sw $t2, -632($fp)
	li $t0, 9
	lw $t1, -632($fp)
	add $t2, $t0, $t1
	sw $t2, -632($fp)
	lw $t0, -632($fp)
	li $t1, 4
	mult $t0, $t1
	mflo $t2
	sw $t2, -632($fp)
	lw $t0, -632($fp)
	add $t2, $t0, $fp
	sw $t2, -632($fp)
	lw $t0, -632($fp)
	l.s $f9, 0($t0)
	li $v0, 2
	mov.s $f12, $f9
	syscall
	li $v0, 4
	la $a0, -616($fp)
	li $t0, 9
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $v0, 4
	la $a0, -612($fp)
	li $t0, 10
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	li $v0, 10
	syscall
