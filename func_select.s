.section    .rodata
    quad_fmt:
	    .string "%ld\n"
    pstrlen_fmt:
	    .string "first pstring length: %d, second pstring length: %d\n"

.section    .text
.extern     pstrlen
.globl  run_func
.type   run_func, @function
    run_func:
        # prologue
	    pushq	%rbp
	    movq	%rsp, %rbp

        cmpq    $31, %rdi
        je      option_31

        option_31:
            movq    %rsi, %rdi
            call    pstrlen

            movq    %rax, %rsi
            movq    %rdx, %rdi
            call    pstrlen

            movq    $pstrlen_fmt, %rdi
            movq    %rax, %rdx
            call    printf

            jmp    epilogue
        option_33:
            jmp    epilogue
        option_34:
            jmp    epilogue
        option_37:
            jmp    epilogue

        # epilogue
        epilogue:
            movq     $60, %rax
            xorq     %rdi, %rdi
            syscall
