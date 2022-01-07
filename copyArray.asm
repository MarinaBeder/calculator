       
copyArray:
    mov cx,100
    cld 
    lea si,array
    lea di,arrayCopy
    rep movsW
    ret   