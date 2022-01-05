Power:     mov ah,9 
            mov dx, offset msg7
            int 21h 
            mov cx,0
            call InputNo
            push dx
           
            mov ax,1   
           mov cx,0
           mov cx, bx
           mov ah,9
            mov dx, offset msg9
            int 21h 
            mov cx,0
            call InputNo
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