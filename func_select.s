.section    .rodata
    quad_fmt:
	    .string "%ld\n"
    pstrlen_fmt:
	    .string "first pstring length: %d, second pstring length: %d\n"
    swapCase_fmt:
        .string "length: %d, string: %s\n"
.section    .text
.extern     pstrlen
.extern     swapCase
.globl  run_func
.type   run_func, @function
    run_func:
        # prologue
	    pushq	%rbp
	    movq	%rsp, %rbp

        cmpq    $31, %rdi
        je      option_31
        cmpq    $33, %rdi
        je      option_33
        jmp     epilogue
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
            movq    %rsi, %r12
            movq    %rdx, %r13
            # performing swapCase on the first string
            movq    %r12, %rdi
            call    swapCase
            movq    %rdi, %rdx
            call    pstrlen
            movq    %rax, %rsi
            movq    $swapCase_fmt, %rdi
            call    printf
            # performing swapCase on the second string
            movq    %r13, %rdi
            call    swapCase
            movq    %rdi, %rdx
            call    pstrlen
            movq    %rax, %rsi
            movq    $swapCase_fmt, %rdi
            call    printf
            jmp     epilogue
        option_34:
            jmp    epilogue
        option_37:
            jmp    epilogue

        # epilogue
        epilogue:
            movq     $60, %rax
            xorq     %rdi, %rdi
            syscall
