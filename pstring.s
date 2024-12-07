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
