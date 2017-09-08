  .data
nrows: .word 6
ncols: .word 12
flag:  .byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
       .byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
       .byte '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.'
       .byte '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.'
       .byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
       .byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
       .data
main_ret: .space 4
.text
main:
  sw $ra, main_ret

  li $s0, 0 # s0 <- row, s1 <- col
  OUTER_FOR_START:
    lw     $t0, nrows
    bge    $s0, $t0, OUTER_FOR_END  # if $s0 >= $t0 then OUTER_FOR_END
    li    $s1, 0    # $s1 = 0
    INNER_FOR_START:
      lw    $t1, ncols
      bge    $s1, $t1, INNER_FOR_END  # if $s1 >=  then INNER_FOR_END
      # inner loop body:
      mul   $t2, $s0, $t1
      add   $t2, $s1, $t2    #  =  + offset <- t2
      lb    $a0, flag($t2)    #
      li    $v0, 11    # $v0 = 11
      syscall
    INNER_FOR_STEP:
      addi  $s1, $s1, 1      # $s1 = $s1 + 1
      j INNER_FOR_START
    INNER_FOR_END:
    # Printf "\n"
    li    $a0, 10    # $a0 = '\n'
    li    $v0, 11    # $v0 = 11
    syscall

  OUTER_FOR_STEP:
    addi $s0, $s0, 1
    j OUTER_FOR_START
  OUTER_FOR_END:
  lw $ra, main_ret
  jr $ra
