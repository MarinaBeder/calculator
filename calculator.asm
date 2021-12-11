

org 100h

jmp start       ; jump over data declaration

msg:    db      "1-Add",0dh,0ah,"2-Multiply",0dh,0ah,"3-Subtract",0dh,0ah,"4-Divide", 0Dh,0Ah, '$'
msg2:    db      0dh,0ah,"Enter First No : $"
msg3:    db      0dh,0ah,"Enter Second No : $"
msg4:    db      0dh,0ah,"Choice Error $" 
msg5:    db      0dh,0ah,"Result : $" 
msg6:    db      0dh,0ah ,'thank you for using the calculator! press any key... ', 0Dh,0Ah, '$'

start:  mov ah,9
        mov dx, offset msg ;first we will display the first message from which he can choose the operation using int 21h
        int 21h
        mov ah,0                       
        int 16h  ;then we will use int 16h to read a key press, to know the operation he choosed
        cmp al,31h ;the keypress will be stored in al so, we will comapre to 1 addition ..........
        je Addition
        cmp al,32h
        je Multiply
        cmp al,33h
        je Subtract
        cmp al,34h
        je Divide
        mov ah,09h
        mov dx, offset msg4
        int 21h
        mov ah,0
        int 16h
        jmp start
        
