.data
x    .space 8
y    .space 4
...
# scanf("%d", &y);
li   $v0, 5
syscall
sw   $v0, y

...
# $t0 <- y + 2000
lw   $t0, y
addi $t0, $t0, 2000

# $t1 <- y + 3000
lw   $t1, y
addi $t1, $t1, 3000

mult $t0, $t1 # (HI, LO) <- $t0 * $t1

  # assume little endian
  mfhi $t0
  sw   $t0, (x + 4)

  mflo $t0
  sw   $t0, x

  # assume big endian
  mfhi $t0
  sw   $t0, x

  mflo $t0
  sw   $t0, (x + 4)


# if (x > y) {
# } else if() {
# } else {
# }

IF_START:
brge $t1, $t0, ELSE_IF_BRANCH
....
j IF_END
ELSE_IF_BRANCH:
brge $sfasfs, ELSE_BRANCH
....
j IF_END
ELSE_BRANCH:
...
j IF_END
IF_END:

# while(x > y) {
# ....
# }

WHILE_START:
brge $t1, $t0, WHILE_END
...
j WHILE_START
WHILE_END:

# WEEK5 FUN:
main_ret_addr: .word 0
main_tmp_save: .space 40
main:
  sw $ra, main_ret_addr
  
  li $t0, 100
  ...
  # Save tmp before fun call if you need to use it again
  sw $t0, main_tmp_save
  jal FUN
  lw $t0, main_tmp_save
  
  # Load back RA
  lw $ra, main_ret_addr
  jr $ra

  
.data
  fun_ret_addr: .word 0
  fun_saved_reg: .space 40
  # $s0
FUN:
  sw $ra, fun_ret_addr
  sw $s0, fun_saved_reg
  sw $s1, (fun_saved_reg + 4)
  ... Save all $sX registers you use
  # ... do other stuff
FUN_END:
  ...
  lw $s1, 4(fun_saved_reg)
  lw $s0, (fun_saved_reg)
  lw $ra, fun_ret_addr
  jr $ra
  
