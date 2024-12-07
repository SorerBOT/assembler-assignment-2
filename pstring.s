.section    .text
.global      pstrlen
.type       pstrlen, @function
.globl      swapCase
.type       swapCase, @function
.globl      strcpy
.type       strcpy, @function
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

strcpy:
    # prologue
	pushq	%rbp
	movq	%rsp, %rbp



    #epilogue
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
