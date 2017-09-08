.data
nitems: .word 0
head:   .word 0
tail:   .word 0
items:  .space 32

main_ret: .space 4
.text
main:
  sw $ra, main_ret


  lw $ra, main_ret
  jr $ra

enqueue:
  # prologue
  addi $sp, $sp, -4
  sw   $fp, ($sp)
  la   $fp, ($sp)
  addi $sp, $sp, -4
  sw   $ra, ($sp)
  # Body:
  lw $t1, nitems
  li $t0, 8
  bne    $t0, $t1, EQ_IF_FULL_END  # if  !=  then EQ_IF_FULL_END
    li $v0, -1
    j ENQUEUE_EPI
  EQ_IF_FULL_END:
    lw $t1, nitems
    bge    $0, $t1, EQ_IF_ONE_ITEM_END  # if $t1 > 1 then
    lw $t1, tail
    addi $t1, $t1, 1
    li $t0, 8
    rem $t1, $t1, $t0
    sw $t1, tail
    EQ_IF_ONE_ITEM_END:
    lw $t1, tail
    mul $t1, $t1, 4
    sw $a0, items($t1)

    lw $t1, nitems
    addi $t1, $t1, 1
    sw $t1, nitems

    li $v0, 0
  # epilogue
  ENQUEUE_EPI:
  lw   $ra, ($sp)
  addi $sp, $sp, 4
  lw   $fp, ($sp)
  addi $sp, $sp, 4
  jr   $ra


dequeue:
  # prologue
  addi $sp, $sp, -4
  sw   $fp, ($sp)
  la   $fp, ($sp)
  addi $sp, $sp, -4
  sw   $ra, ($sp)

  # epilogue
  lw   $ra, ($sp)
  addi $sp, $sp, 4
  lw   $fp, ($sp)
  addi $sp, $sp, 4
  jr   $ra
