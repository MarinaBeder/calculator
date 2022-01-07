;when user press e to exit
exit3: 
    jmp joinAgain
    mov dx,offset msg6
    mov ah, 09h
    int 21h  
    mov ah, 0
    int 16h
    jmp joinAgain
    ret







   

