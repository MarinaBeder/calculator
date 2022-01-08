


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
     
 ; when user enter the program for the first timto signup
joinSignup: 
    mov ah,9
    mov dx, offset msg14 
    int 21h
    mov ah,0                       
    int 16h 
    cmp al,31h 
    je signup 
    jmp joinSignup 
    
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
        
Addition:   mov ah,09h  ;then let us handle the case of addition operation
            mov dx, offset msg2  ;first we will display this message enter first no also using int 21h
            int 21h
            mov cx,0 ;we will call InputNo to handle our input as we will take each number seprately
            call InputNo  ;first we will move to cx 0 because we will increment on it later in InputNo
            push dx
            mov ah,9
            mov dx, offset msg3
            int 21h 
            mov cx,0
            call InputNo
            pop bx
            add dx,bx
            push dx 
            mov ah,9
            mov dx, offset msg5
            int 21h
            mov cx,10000
            pop dx
            call View 
            jmp exit 
            
InputNo:    mov ah,0
            int 16h ;then we will use int 16h to read a key press     
            mov dx,0  
            mov bx,1 
            cmp al,0dh ;the keypress will be stored in al so, we will comapre to  0d which represent the enter key, to know wheter he finished entering the number or not 
            je FormNo ;if it's the enter key then this mean we already have our number stored in the stack, so we will return it back using FormNo
            sub ax,30h ;we will subtract 30 from the the value of ax to convert the value of key press from ascii to decimal
            call ViewNo ;then call ViewNo to view the key we pressed on the screen
            mov ah,0 ;we will mov 0 to ah before we push ax to the stack bec we only need the value in al
            push ax  ;push the contents of ax to the stack
            inc cx   ;we will add 1 to cx as this represent the counter for the number of digit
            jmp InputNo ;then we will jump back to input number to either take another number or press enter          
   

;we took each number separatly so we need to form our number and store in one bit for example if our number 235
FormNo:     pop ax  
            push dx      
            mul bx
            pop dx
            add dx,ax
            mov ax,bx       
            mov bx,10
            push dx
            mul bx
            pop dx
            mov bx,ax
            dec cx
            cmp cx,0
            jne FormNo
            ret   


       
       
View:  mov ax,dx ;ax=6 , ,ax=0006
       mov dx,0       ;dx=0
       div cx   ;(dx,ax)=(dx,ax)/cx ,6/10000=0.0006,0006/1000=0.006
       call ViewNo
       mov bx,dx  ;bx=0006
       mov dx,0           ;dx=000
       mov ax,cx    ;ax=10000
       mov cx,10 ;cx=10
       div cx          ;ax=1000
       mov dx,bx    ;dx=0006
       mov cx,ax  ;cx=1000
       cmp ax,0
       jne View
       ret  
ViewNo:    push ax ;we will push ax and dx to the stack because we will change there values while viewing then we will pop them back from
           push dx ;the stack we will do these so, we don't affect their contents
           mov dx,ax ;we will mov the value to dx as interrupt 21h expect that the output is stored in it
           add dl,30h ;add 30 to its value to convert it back to ascii
           mov ah,2
           int 21h
           pop dx  
           pop ax
           ret
      
   
exit:   mov dx,offset msg6
        mov ah, 09h
        int 21h  
        mov ah, 0
        int 16h
        jmp start
        
Multiply:   mov ah,09h
            mov dx, offset msg2
            int 21h
            mov cx,0
            call InputNo
            push dx
            mov ah,9
            mov dx, offset msg3
            int 21h 
            mov cx,0
            call InputNo
            pop bx
            mov ax,dx
            mul bx 
            mov dx,ax
            push dx 
            mov ah,9
            mov dx, offset msg5
            int 21h
            mov cx,10000
            pop dx
            call View 
            jmp exit 


Subtract:   mov ah,09h
            mov dx, offset msg2
            int 21h
            mov cx,0
            call InputNo
            push dx
            mov ah,9
            mov dx, offset msg3
            int 21h 
            mov cx,0
            call InputNo
            pop bx
            sub bx,dx
            mov dx,bx
            push dx 
            mov ah,9
            mov dx, offset msg5
            int 21h
            mov cx,10000
            pop dx
            call View 
            jmp exit 
    
            
Divide:     mov ah,09h
            mov dx, offset msg2
            int 21h
            mov cx,0
            call InputNo
            push dx
            mov ah,9
            mov dx, offset msg3
            int 21h 
            mov cx,0
            call InputNo
            pop bx
            mov ax,bx
            mov cx,dx
            mov dx,0
            mov bx,0
            div cx
            mov bx,dx
            mov dx,ax
            push bx 
            push dx 
            mov ah,9
            mov dx, offset msg5
            int 21h
            mov cx,10000
            pop dx
            call View
            pop bx
            cmp bx,0 
            jmp exit                        
              
                       
CalcSquareRoot: 
          
        inc cx     ;cx =1,2,3
        mov ax, cx ;ax=1    , 2     ,3
        mul cx     ;ax=1*1 , 2*2=4 , 3*3=9
        cmp ax, bx 
        jne  CalcSquareRoot
        ret   
        
        
;square root(9)          
SquareRoot:
        mov ah,9 
        mov dx, offset msg7
        int 21h 
        call InputNo;dx=9
        mov bx,dx
        mov ax,0   
        mov cx,0
        call CalcSquareRoot
        mov dx, cx
        push dx 
        mov ah,9
        mov dx, offset msg5
        int 21h
        mov cx,10000
        pop dx
        call View 
        jmp exit 
        
        
CalcFactorial: 

    mul cx   ;ax=ax*cx=3 ,ax=3*2
    dec cx              ;cx=2,cx=1
    cmp cx,1   
    jne  CalcFactorial
    ret   
    
        
        
Factorial:  
        mov ah,9 
        mov dx, offset msg7
        int 21h 
        mov cx,0
        call InputNo ;dx=1234
        mov cx,dx ;cx=1234
        mov ax,1
        call  CalcFactorial
        mov dx, ax
        push dx 
        mov ah,9
        mov dx, offset msg5
        int 21h
        mov cx,10000 ;cx=10000
        pop dx
        call View 
        jmp exit  
CalcLog:
        div bx;8/2=4
        inc cx      ;cx=1
        cmp ax,1
        jne CalcLog 
        ret              
            


 Log:                     
        mov ah,9 
        mov dx, offset msg7
        int 21h 
        mov cx,0
        call InputNo ;dx=8
        push dx
       ; mov ax,1   
        ;mov cx,0
       ; mov cx, bx
        mov ah,9
        mov dx, offset msg8
        int 21h 
        mov cx,0
        call InputNo ;dx=2
        pop ax;ax=8
        mov bx,dx;bx=2
        mov cx,0 
        mov dx,0
        call CalcLog
        mov dx, cx
        push dx 
        mov ah,9
        mov dx, offset msg5
        int 21h
        mov cx,10000
        pop dx
        call View 
        jmp exit 
        
        
CalcLog10: 
        div bx;100/10=10,10/10=1
        inc cx   ;cx=1  ,2
        cmp ax,1
        jne CalcLog10
        ret              
        
;log [100]->10,100/10=10,10/10=1  result=2
Log10:    
        mov ah,9 
        mov dx, offset msg7
        int 21h 
        mov cx,0
        call InputNo ;result=dx
        push dx 
        pop ax
        mov bx,10
        mov cx,0 
        mov dx,0
        call CalcLog10
        mov dx, cx
        push dx 
        mov ah,9
        mov dx, offset msg5
        int 21h
        mov cx,10000
        pop dx
        call View 
        jmp exit 
        


CalcPower:
        mul bx
        dec cx
        cmp cx,0
        jne  CalcPower
        ret              
            
Power:    
        mov ah,9 
        mov dx, offset msg7
        int 21h 
        mov cx,0
        call InputNo ;enter number
        push dx
        mov ax,1   
        mov cx,0
        mov cx, bx
        mov ah,9
        mov dx, offset msg9
        int 21h 
        mov cx,0
        call InputNo ;enter power
        pop bx
        mov cx,dx
        mov ax,1 
        call CalcPower
        mov dx, ax
        push dx 
        mov ah,9  
        mov dx, offset msg5
        int 21h
        mov cx,10000
        pop dx
        call View 
        jmp exit 
        
        
CalcPowerSquare:
        mul bx ;ax*bx=ax,8*1=8,8*8=64
        dec cx     ;cx=1,0
        cmp cx,0
        jne CalcPowerSquare 
        ret  
          
 ;8,8*8    
 
PowerSquare:    
        mov ah,9 
        mov dx, offset msg7
        int 21h 
        mov cx,0
       ; mov ax,1
        call InputNo;dx=8
        mov ax,1
        mov bx,dx;bx=8
        mov cx,2
        call  CalcPowerSquare
        mov dx, ax
        push dx 
        mov ah,9
        mov dx, offset msg5
        int 21h
        mov cx,10000
        pop dx
        call View 
        jmp exit               
            
            
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
    

;when user enter the program for the first tim to signup
signup:
    lea di,array  ;di=1000 
    ;make es point to offset ds because (di) in string instruction point to es and we want data segment 
    mov bx,ds
    mov es,bx  
    mov dx,0 
    mov ah,9
    mov dx, offset msg10
    int 21h 
    call InputNo  ;dx
    mov ax,dx
    cld
    stosW  ;di=di+2byte,1002
    mov number,di ;number=1002
    jmp joinLogin 
     
; when user exit from the program and want to enter again
signupAgain:
    lea di,array
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
    


copyArray:
    mov cx,100
    cld 
    lea si,array
    lea di,arrayCopy
    rep movsW
    ret   
     ;array 1,2,3
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
 
 
        














   

