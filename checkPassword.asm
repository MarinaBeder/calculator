; when user make login check if password is correct or not
checkPassword:
        call copyArray
        cld
        lea si,arrayCopy
        mov cx,100
        again: ;to make search
        cmp cx,0 
        je error 
        LODSW;load in ax
      
        dec cx
        cmp dx,ax
        jne loop again
        
        call copyArray
        mov ah,09h  
        mov dx, offset msg12  
        int 21h 
        je start 
        ret  