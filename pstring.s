# Alon Filler ID: 216872374

.section .rodata
    invalidInput_fmt:
        .string "invalid input!\n"
    cannot_concat_str:
        .string "cannot concatenate strings!\n"
.section    .text
.extern     printf
.global     pstrlen
.type       pstrlen, @function
.global      swapCase
.type       swapCase, @function
.global      pstrijcpy
.type       pstrijcpy, @function
.global      pstrcat
.type       pstrcat, @function

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
        movq    %r13, %rsi # not exactly return value, but abusing the register
        movq    %r12, %rax # returning destination
	    movq	%rbp, %rsp
	    popq	%rbp
	    ret

pstrcat:
    # prologue
	pushq	%rbp
	movq	%rsp, %rbp

    movq    %rdi, %r12 # dest
    movq    %rsi, %r13 # src

    # dest length
    call    pstrlen
    movq    %rax, %r10 # dest len
    # src length
    movq    %r13, %rdi
    call    pstrlen
    movq    %rax, %r11 # src len

    # adding lengths
    movq    %r10, %rdi
    movq    %r11, %rsi
    addq    %rsi, %rdi # joined length in %rdi
    movq    %rdi, %r14 # <----

    # checking for size
    cmpq    $254, %r14
    jg cannot_concatenate

    # changing the size of destination
    movb    %r14b, (%r12)
    # concatenation
    movq    $0, %r8 # %r8 will be our index
    concat_i:
        # movb    1(%r13, %r8), 1(%r12, %r10)
        movzbq    1(%r13, %r8), %r15
        movb      %r15b, 1(%r12, %r10)
        # check if the char we copied was \0, if so we finished
        cmpq    $0, 1(%r13, %r8)
        je      finished_concat
        # increment indices
        incq    %r8
        incq    %r10
        jmp     concat_i
    cannot_concatenate:
        movq    $cannot_concat_str, %rdi
        call    printf
        jmp     finished_concat
    finished_concat:
        #epilogue
        # moving the src back to %rsi so that we can use it again in the main function
        movq    %r13, %rsi
        movq    %r12, %rax
	    movq	%rbp, %rsp
	    popq	%rbp
	    ret
