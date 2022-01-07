signupAgain:
    mov di,number
    mov ah,9
    mov dx, offset msg10
    int 21h 
    call InputNo ;dx
    mov ax,dx
    cld
    stosw
    mov number,di
    jmp joinAgain