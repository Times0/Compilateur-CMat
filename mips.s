.data

.globl main
.text
main:
	move $fp, $sp
	li $t0, 5
	sw $t0, -4($fp)
	li $t0, 2
	sw $t0, -8($fp)
	lw $t0, -4($fp)
	lw $t1, -8($fp)
	add $t2, $t0, $t1
	sw $t2, -12($fp)
	lw $t0, -12($fp)
	li $v0, 1
	move $a0, $t0
	syscall
	lw $t0, -4($fp)
	lw $t1, -8($fp)
	mult $t0, $t1
	mflo $t2
	sw $t2, -16($fp)
	lw $t0, -16($fp)
	li $v0, 1
	move $a0, $t0
	syscall
	lw $t0, -4($fp)
	lw $t1, -8($fp)
	sub $t2, $t0, $t1
	sw $t2, -20($fp)
	lw $t0, -20($fp)
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 10
	syscall
