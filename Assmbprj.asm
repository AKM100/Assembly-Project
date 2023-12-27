.model small
.data
    num1 db ?
    num2 db ?
    result db ?
    operator db ?
    msg1 db 10,'Enter first number: $'
    msg2 db 10,'Enter operator (+, -, *, /): $'
    msg3 db 10,'Enter second number: $'
    msg4 db 10,'Result: $'

.code
main proc
    .startup
    

    ; Input first number
    lea dx, msg1
    mov ah, 9
    int 21h
    mov ah, 1
    int 21h
    sub al, 30h
    mov num1, al

    ; Input operator
    lea dx, msg2
    mov ah, 9
    int 21h
    mov ah, 1
    int 21h
    mov operator, al

    ; Input second number
    lea dx, msg3
    mov ah, 9
    int 21h
    mov ah, 1
    int 21h
    sub al, 30h
    mov num2, al

    ; Perform operation based on the operator
    mov al, num1
    mov bl, num2
    cmp operator, '+'
    je add_numbers
    cmp operator, '-'
    je subtract_numbers
    cmp operator, '*'
    je multiply_numbers
    cmp operator, '/'
    je divide_numbers

add_numbers:
    add al, bl
    jmp display_result

subtract_numbers:
    sub al, bl
    jmp display_result

multiply_numbers:
    imul bl ; Use 'imul' with one operand to multiply AL by BL
    jmp display_result

divide_numbers:
    mov ah, 0 ; clear ah to avoid issues with idiv
    idiv bl

display_result:
    mov result, al

    ; Display result
    lea dx, msg4
    mov ah, 9
    int 21h

    add result, 30h
    mov dl, result
    mov ah, 2
    int 21h

    mov ah, 4Ch
    int 21h
main endp

end main
