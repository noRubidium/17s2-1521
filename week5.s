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

mfhi $t0
sw   $t0, (x + 4) # assume little endian

mflo $t0
sw   $t0, x


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
