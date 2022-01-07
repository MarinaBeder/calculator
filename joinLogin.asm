; when user enter the program for the first timto login
 ;1-login
joinLogin: 
    mov ah,9
    mov dx, offset msg15
    int 21h
    mov ah,0                       
    int 16h  
    cmp al,31h;check if user enter 1
    je  login 
    jmp joinlogin



