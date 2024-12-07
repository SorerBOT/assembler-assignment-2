.section    .rodata
    quad_fmt:
	    .string "%ld\n"

.section    .text
.globl  run_func
.type   run_func, @function
    run_func:
        # prologue
	    pushq	%rbp
	    movq	%rsp, %rbp

        cmpq    $31, %rdi
        je

        strlen:
            jmp    epilogue
        swapCase:
            jmp    epilogue
        strcpy:
            jmp    epilogue
        strcat:
            jmp    epilogue


        # epilogue
        epilogue:
	        movq	%rbp, %rsp
	        popq	%rbp
	        ret
