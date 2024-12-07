.section    .text
.globl      strlen
.type       strlen, @function
    strlen:
        # prologue
	    pushq	%rbp
	    movq	%rsp, %rbp



        #epilogue
	    movq	%rbp, %rsp
	    popq	%rbp
	    ret