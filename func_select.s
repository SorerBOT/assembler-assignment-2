# Alon Filler ID: 216872374

.section    .rodata
    quad_fmt:
	    .string "%ld\n"
    pstrlen_fmt:
	    .string "first pstring length: %d, second pstring length: %d\n"
    swapCase_fmt:
        .string "length: %d, string: %s\n"
    int_fmt:
        .string " %d"
    unsigned_char_fmt:
        .string " %hhu"
    invalid_option_str:
        .string "invalid option!\n"
.section    .text
.extern     printf
.extern     scanf
.extern     pstrlen
.extern     swapCase
.extern     pstrijcpy
.extern     pstrcat
.global  run_func
.type   run_func, @function
    run_func:
        # prologue
	    pushq	%rbp
	    movq	%rsp, %rbp

        cmpq    $31, %rdi
        je      option_31
        cmpq    $33, %rdi
        je      option_33
        cmpq    $34, %rdi
        je      option_34
        cmpq    $37, %rdi
        je      option_37
        jmp     invalid_option
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
            movq    %rsi, %r12 # destination [len, char[255]]
            movq    %rdx, %r13 # src
            # performing swapCase on the first string
            movq    %r12, %rdi
            call    swapCase
            leaq    1(%rdi), %rdx
            call    pstrlen
            movq    %rax, %rsi
            movq    $swapCase_fmt, %rdi
            call    printf
            # performing swapCase on the second string
            movq    %r13, %rdi
            call    swapCase
            leaq    1(%rdi), %rdx
            call    pstrlen
            movq    %rax, %rsi
            movq    $swapCase_fmt, %rdi
            call    printf
            jmp     epilogue
        option_34:
            movq    %rsi, %r12
            movq    %rdx, %r13
            # scanning for numbers (i,j)
            subq    $16, %rsp
            movq    $int_fmt, %rdi
            movq    %rsp, %rsi
            call    scanf # i

            movq    $int_fmt, %rdi
            leaq    8(%rsp), %rsi
            call    scanf # j

            # re-arranging registers
            movzbq    8(%rsp), %rcx
            movzbq    (%rsp), %rdx
            movq    %r12, %rdi
            movq    %r13, %rsi

            # restoring stack
            addq    $16, %rsp
            # resetting registers
            xorq    %r10, %r10
            xorq    %r11, %r11
            xorq    %r12, %r12
            xorq    %r13, %r13
            # calling function
            call    pstrijcpy
            # moving to temp
            movq    %rax, %r13 # destination
            movq    %rsi, %r12 # src
            # printing destination
            movq    %r13, %rdi
            call    pstrlen
            movq    %rax, %rsi
            # xor-ing rax
            xorq    %rax, %rax
            leaq    1(%r13), %rdx
            movq    $swapCase_fmt, %rdi
            call    printf
            # printing src
            movq    %r12, %rdi
            call    pstrlen
            movq    %rax, %rsi
            leaq    1(%r12), %rdx
            movq    $swapCase_fmt, %rdi
            # xor-ing rax
            xorq    %rax, %rax
            call    printf
            jmp    epilogue
        option_37:
            movq   %rsi, %rdi # dest
            movq   %rdx, %rsi # src

            call    pstrcat
            # moving to tmp
            movq    %rax, %r12 # dest
            movq    %rsi, %r13 # src
            # now getting dest string len
            movq    %r12, %rdi
            call    pstrlen
            movq    %rax, %rsi
            # printing dest
            movq    $swapCase_fmt, %rdi
            leaq    1(%r12), %rdx
            call    printf
            # getting src len
            movq    %r13, %rdi
            call    pstrlen
            movq    %rax, %rsi
            # printing src
            movq    $swapCase_fmt, %rdi
            leaq    1(%r13), %rdx
            call    printf

            jmp    epilogue

        invalid_option:
            movq    $invalid_option_str, %rdi
            call    printf
            jmp     epilogue
        # epilogue
        epilogue:
	        movq	%rbp, %rsp
	        popq	%rbp
	        ret
