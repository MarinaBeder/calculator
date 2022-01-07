

org 100h

jmp joinSignup       ; jump over data declaration
msg:    db       0dh,0ah,"0-Addition",0dh,0ah,"1-Multiply",0dh,0ah,"2-Subtract",0dh,0ah,"3-Divide",0dh,0ah, "4-Power",0dh,0ah,"5-Factorial",0dh,0ah,"6-Square Root",0dh,0ah,"7-Log", 0Dh,0Ah,"8-Power Square",0dh,0ah,"9-Log10",0dh,0ah, "e-Exit",0dh,0ah,'$'
msg2:    db      0dh,0ah,"Enter First No : $"
msg3:    db      0dh,0ah,"Enter Second No : $"
msg4:    db      0dh,0ah,"Choice Error $" 
msg5:    db      0dh,0ah,"Result : $" 
msg6:    db      0dh,0ah ,'thank you for using the calculator! press any key... ', 0Dh,0Ah, '$'
msg7:    db      0dh,0ah,"Enter No: $"  
msg8:    db      0dh,0ah,"Enter basic (which can divide by it)  : $"
msg9:    db      0dh,0ah,"Enter Power : $"
msg10:    db      0dh,0ah,"enter password to signup: ",0dh,0ah,"$"
msg11:    db      0dh,0ah,"password is not correct", 0Dh,0Ah,,0dh,0ah,"please enter password again","$"     
msg12:    db      0dh,0ah,"password is correct",0dh,0ah," $"
msg13:    db     0dh,0ah, "1-sign up",0dh,0ah,"2-log in",0dh,0ah,'$'             
msg14:    db     "1-sign up",0dh,0ah,'$'     
msg15:    db     0dh,0ah,"1-log in",'$'     
msg16:    db      0dh,0ah,"enter password to login:" ,0dh,0ah,"$"
              
arrayCopy  DW   100 dup(0)  ;array declaration
array  DW   100 dup(0)
number dw ?,"$" 
 ; this options will display when user enter login correctly
start:  mov ah,9
        mov dx, offset msg ;first we will display hte first message from which he can choose the operation using int 21h
        int 21h
        mov ah,0
        int 16h ;then we will use int 16h to read a key press, to know the operation he choosed
        cmp al,30h ;the keypress will be stored in al so, we will comapre to 1 addition ..........
        je Addition
        cmp al,31h
        je Multiply
        cmp al,32h
        je Subtract
        cmp al,33h
        je Divide
        cmp al,34h
        je Power
        cmp al,35h
        je Factorial
        cmp al,36h
        je SquareRoot
        cmp al,37h
        je Log
        mov ah,09h
        cmp al,38h
        je powersquare
        mov ah,09h
        cmp al,39h
        je Log10
        mov ah,09h
        cmp al,65h
        je exit3
        mov ah,09h
        mov dx, offset msg4
        int 21h
        mov ah,0
        int 16h
        jmp start 
