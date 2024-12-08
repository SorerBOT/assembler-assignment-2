.section .rodata
    invalidInput_fmt:
        .string "invalid input!\n"

.section    .text
.global      pstrlen
.type       pstrlen, @function
.globl      swapCase
.type       swapCase, @function
.globl      pstrijcpy
.type       pstrijcpy, @function
.globl      strcat
.type       strcat, @function

pstrlen:
    # prologue
	pushq	%rbp
	movq	%rsp, %rbp

    movzbq  (%rdi), %rax

    #epilogue
	movq	%rbp, %rsp
	popq	%rbp
	ret


swapCase:
    # prologue
	pushq	%rbp
	movq	%rsp, %rbp

    xorq    %r10, %r10
    xorq    %r11, %r11

    iteration:
        lea 1(%rdi, %r10), %rax

        movzbq  (%rax), %r11

        # increment index
        incq    %r10
        # checking if we have reached the null-terminator
        cmpq  $0, %r11
        je    finishedLoop
        # checking whether %r11 is in the range: [a-z]
        cmpq    $97, %r11
        jge     transformToUpperCase
        cmpq    $65, %r11
        jge     transformToLowerCase
        jmp     iteration
        transformToUpperCase:
            cmpq    $122, %r11
            jg      iteration
            subq    $32, %r11
            movb    %r11b, (%rax)
            jmp     iteration
        transformToLowerCase:
            cmpq    $90, %r11
            jg      iteration
            addq    $32, %r11
            movb    %r11b, (%rax)
            jmp     iteration

    finishedLoop:
        #epilogue
	    movq	%rbp, %rsp
	    popq	%rbp
	    ret

pstrijcpy:
    # prologue
	pushq	%rbp
	movq	%rsp, %rbp

    # temps
    movq    %rdi, %r12 # destination
    movq    %rsi, %r13 # src
    xorq    %r8, %r8

    # validating input
    # if j < i
    cmpq    %rdx, %rcx
    jl      invalidInput
    # if i < 0
    cmpq    $0, %rdx
    jl      invalidInput
    # checking for the length of destination
    movq    %r12, %rdi
    call    pstrlen
    movq    %rax, %r11
    # checking for the length of src
    movq    %r13, %rdi
    call    pstrlen
    movq    %rax, %r10
    # if j >= src.length
    cmpq    %rcx, %r10
    jle     invalidInput
    # if j >= destination.length
    cmpq    %rcx, %r11
    jle     invalidInput
    jmp     cpy_iteration

    invalidInput:
        movq    $invalidInput_fmt, %rdi
        call    printf
        jmp     finishedCpy

    # the cpy function
    cpy_iteration:
        # if j < i
        cmpq    %rdx, %rcx
        jl      finishedCpy
        # copying the i'th char from src
        movzbq  1(%r13, %rdx), %r8
        # moving it to destination
        movb    %r8b, 1(%r12, %rdx)
        # increment i
        incq     %rdx
        jmp     cpy_iteration

    finishedCpy:
        #epilogue
        movq    %r12, %rax # returning destination
	    movq	%rbp, %rsp
	    popq	%rbp
	    ret

strcat:
    # prologue
	pushq	%rbp
	movq	%rsp, %rbp



    #epilogue
	movq	%rbp, %rsp
	popq	%rbp
	ret
