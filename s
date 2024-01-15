.data

.globl main
.text
main:
	move $fp, $sp
	li $t0, 0
	sw $t0, -4($fp)
	li $t0, 0
	sw $t0, -8($fp)

Label_3:
	lw $t0, -8($fp)
	li $t1, 21
	blt $t0, $t1, Label_6
	j Label_12
	lw $t0, -4($fp)
	li $t1, 3
	add $t2, $t0, $t1
	sw $t2, -16($fp)

Label_6:
	lw $t0, -16($fp)
	sw $t0, -4($fp)
	lw $t0, -4($fp)
	li $t1, 1
	sub $t2, $t0, $t1
	sw $t2, -20($fp)
	lw $t0, -20($fp)
	sw $t0, -4($fp)
	lw $t0, -8($fp)
	li $t1, 1
	add $t2, $t0, $t1
	sw $t2, -12($fp)
	lw $t0, -12($fp)
	sw $t0, -8($fp)
	j Label_3

Label_12:
	lw $t0, -4($fp)
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 10
	syscall
