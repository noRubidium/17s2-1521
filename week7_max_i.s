.data
.align 2
list:  .word node1
node1: .word 6, node2
node2: .word 4, node3
node3: .word 5, node4
node4: .word 2, 0

main_ret: .space 4
.text
main:
  sw $ra, main_ret
  lw $a0, list
  jal max
  move $a0, $v0
  li $v0, 1
  syscall
  li $a0, 10
  li $v0, 11
  syscall

  lw $ra, main_ret
  jr $ra

max:
  # prologue
  addi $sp, $sp, -4
  sw   $fp, ($sp)
  la   $fp, ($sp)
  addi $sp, $sp, -4
  sw   $ra, ($sp)
  addi $sp, $sp, -4
  sw   $s0, ($sp)
  addi $sp, $sp, -4
  sw   $s1, ($sp)
  # body
  bne $a0, $0, IF_NULL_END
  li $v0, -1
  j MAX_EPI
  IF_NULL_END:
  lw $s0, 0($a0) # <- max
  move $s1, $a0 # <- curr
  WHILE_START:
    beq $s1, $0, WHILE_END
    lw $t0, 0($s1)
    bge    $s0, $t0, IF_UPDATE_MAX_END  # if $s0 >= $t0 then IF_UPDATE_MAX_END
      move $s0, $t0
    IF_UPDATE_MAX_END:
    lw $s1, 4($s1)
    j WHILE_START
  WHILE_END:
    move $v0, $s0
  # epilogue
  MAX_EPI:
  lw   $s1, ($sp)
  addi $sp, $sp, 4
  lw   $s0, ($sp)
  addi $sp, $sp, 4
  lw   $ra, ($sp)
  addi $sp, $sp, 4
  lw   $fp, ($sp)
  addi $sp, $sp, 4
  jr   $ra
