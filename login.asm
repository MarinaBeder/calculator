; when user make login
login: 
    MOV DX,0  
    mov ah,9
    mov dx, offset msg16
    int 21h 
    call InputNo;dx=password=1 
    call copyArray 
    call checkPassword
    jmp exit


