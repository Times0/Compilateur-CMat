.data

.globl main
.text
main:
	move $fp, $sp
	li $t0, 1
	sw $t0, -4($fp)
	li $t0, 0
	sw $t0, -8($fp)
	li $t0, 2
	li $t1, 9
	mult $t0, $t1
	mflo $t2
	sw $t2, -12($fp)
	li $t0, 1
	lw $t1, -12($fp)
	add $t2, $t0, $t1
	sw $t2, -16($fp)
	lw $t0, -16($fp)
	li $v0, 1
	move $a0, $t0
	syscall
	li $t0, 2
	li $t1, 1
	blt $t0, $t1, Label_7
	j Label_9

Label_7:
	li $v0, 4
	la $a0, -36($fp)
	li $t0, 60
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	j Label_9

Label_9:
	li $t0, 2
	li $t1, 1
	ble $t0, $t1, Label_11
	j Label_13

Label_11:
	li $v0, 4
	la $a0, -40($fp)
	li $t0, 60
	sb $t0, 0($a0)
	li $t0, 61
	sb $t0, 1($a0)
	li $t0, 0
	sb $t0, 2($a0)
	syscall
	j Label_13

Label_13:
	li $t0, 2
	li $t1, 1
	bgt $t0, $t1, Label_15
	j Label_17

Label_15:
	li $v0, 4
	la $a0, -36($fp)
	li $t0, 62
	sb $t0, 0($a0)
	li $t0, 0
	sb $t0, 1($a0)
	syscall
	j Label_17

Label_17:
	li $t0, 2
	li $t1, 1
	bge $t0, $t1, Label_19
	j Label_21

Label_19:
	li $v0, 4
	la $a0, -40($fp)
	li $t0, 62
	sb $t0, 0($a0)
	li $t0, 61
	sb $t0, 1($a0)
	li $t0, 0
	sb $t0, 2($a0)
	syscall
	j Label_21

Label_21:
	li $t0, 2
	li $t1, 2
	beq $t0, $t1, Label_23
	j Label_25

Label_23:
	li $v0, 4
	la $a0, -40($fp)
	li $t0, 61
	sb $t0, 0($a0)
	li $t0, 61
	sb $t0, 1($a0)
	li $t0, 0
	sb $t0, 2($a0)
	syscall
	j Label_25

Label_25:
	li $t0, 1
	li $t1, 1
	bne $t0, $t1, Label_29
	j Label_27

Label_27:
	li $t0, 1
	li $t1, 2
	bgt $t0, $t1, Label_29
	j Label_33

Label_29:
	lw $t0, -4($fp)
	li $t1, 0
	bne $t0, $t1, Label_31
	j Label_33

Label_31:
	li $v0, 4
	la $a0, -40($fp)
	li $t0, 33
	sb $t0, 0($a0)
	li $t0, 61
	sb $t0, 1($a0)
	li $t0, 0
	sb $t0, 2($a0)
	syscall
	j Label_33

Label_33:
	li $t0, 1
	sw $t0, -20($fp)
	li $v0, 10
	syscall
