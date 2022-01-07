; when user exit from the program and wat to enter again
joinAgain:  
    mov ah,9
    mov dx, offset msg13 
    int 21h
    mov ah,0                       
    int 16h  
    cmp al,31h 
    je signupAgain 
    cmp al,32h
    je  login 
    mov ah,0
    int 16h
    jmp joinAgain 








   

