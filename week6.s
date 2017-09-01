# x * x
lw $t0, x
mul $t1, $t0, $t0
# y * y
lw $v0, y
mul $t2, $v0, $v0
# t1 <- (x * x) + y * y
add $t1, $t1, $t2
# x * y
mul $t2, $t0, $v0
# t1 <- t0 - x * y
sub $t1, $t1, $t2
# v0 <- t1 * z
lw $t0, z
mul $v0, $t0, $t1

# $t0 <- x
lw $t0, x
# $t1 <- x * x
mul $t1, $t0, $t0
# $v0 <- y
lw $v0, y
# $t0 <- x * y
mul $t0, $t0, $v0
# $t0 <- x * x - x * y
sub $t0, $t1, $t0
# $v0 <- y * y
mul $v0, $v0, $v0
# $v0 <- $t0 + $v0
add $v0, $t0, $v0
# $t0 <- z
lw $t0, z
# #v0 <- $v0 * $t0
mul $v0, $v0, $t0






# WHILE LOOP:

start_of_loop:
# bgt -> if(a > b) goto something
if (*s == '\0')
    goto end_of_loop
-> lw $t0, ($s0)
-> beq $t0, $0, end_of_loop
if (*s != ' ')
    goto end_of_loop
-> li $t1, ' '
-> bne $t0, $t1, end_of_loop
    s = s + 1;
-> addi $s0, $s0, 1
    goto start_of_loop
-> j    start_of_loop
end_of_loop:



# IF STATEMENT
if ((x != 0 && 100 / x > 5) || y < x) {
if (x != 0) -> goto next_test
-> bne $s0, $0, next_test
if (y < x) -> jump to if body otherwise jump to else branch
-> blt $s1, $s0, if_body
-> j else_branch
next_test: if (100 / x > 5) jump to if body otherwise jump to else
next_test:
 li $t0, 100
 divu $t0, $t0, $s0
 li $t1, 5
 bgt $t0, $t1, if_body
if_body:
    s1;
j if_end
else:
}else {
    -> s2;
}
if_end:



# FUN CALL
# calling prod(1,2,3,4,5,6)
main:
    li $a0, 1
    li $a1, 2
    li $a2, 3
    li $a3, 4
    li $t0, 6
    addi $sp, $sp, -4
    sw $t0, ($sp)
    addi $sp, $sp, -4
    li $t0, 5 # argument4
    sw $t0, ($sp)
    jal prod
    addi $sp, $sp, 8
    move $s0, $v0

prod:
    # prologue
    addi $sp, $sp, -4
    sw   $fp, ($sp)
    move $fp, $sp
    addi $sp, $sp, -4
    sw   $ra, ($sp)

    #fun body
    mul $v0, $a0, $a1
    mul $v0, $a2, $v0
    mul $v0, $a3, $v0
    lw  $t0, 4($fp)
    mul $v0, $t0, $v0
    lw  $t0, 8($fp)
    mul $v0, $t0, $v0

    #epilogue
    lw   $ra, ($sp)
    addi $sp, $sp, 4
    lw   $fp, ($sp)
    addi $sp, $sp, 4
    jr   $ra


# https://courses.cs.washington.edu/courses/cse410/09sp/examples/MIPSCallingConventionsSummary.pdf
