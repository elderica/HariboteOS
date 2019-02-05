.intel_syntax noprefix
.code16

/*  FYI:
    https://teratail.com/questions/125503
    https://kernelhack.hatenablog.com/entry/20090106/1231182085
    https://stackoverflow.com/questions/14290879/disassembling-a-flat-binary-file-using-objdump
*/

/* ORG 0x7c00 */ /* see linker.ld */

.section .text
/* FAT12  header */
    jmp entry
    .byte 0x90
    .ascii "HELLOIPL"
    .word 512
    .byte 1
    .word 1
    .byte 2
    .word 224
    .word 2880
    .byte 0xf0
    .word 9
    .word 18
    .word 2
    .int 0
    .int 2880
    .byte 0
    .byte 0
    .byte 0x29
    .int 0xffffffff
    .ascii "HELLO-OS   "
    .ascii "FAT12   "
    .space 18, 0x00

/* Code */
entry:
    mov ax, 0x00
    mov ss, ax
    mov sp, 0x7c00
    mov ds, ax
    mov es, ax
.att_syntax
    movw $msg, %si /* MOV SI, msg */
.intel_syntax noprefix
putloop:
    mov al, [si]
    add si, 1
    cmp al, 0
    je fin
    mov ah, 0x0e /* putchar */
    mov bx, 15
    int 0x10
    jmp putloop
fin:
    hlt
    jmp fin

/* Data */
msg:
    .byte 0x0a, 0x0a
    .ascii "hello, world"
    .byte 0x0a
    .byte 0

    .org 0x1fe, 0 /* RESB 0x7dfe-$ */

    .byte 0x55, 0xaa

 /* Leftovers */
    .byte 0xf0, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00
    .space 4600, 0
    .byte 0xf0, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00
    .space 1469432, 0
