;when user enter password incorrect
error: mov ah,09h  ;then let us handle the case of addition operation
        mov dx, offset msg11  ;first we will display this message enter first no also using int 21h
        int 21h 
        mov ah,9
        mov dx, offset msg16
        int 21h 
        call InputNo
        call checkPassword
        ret  