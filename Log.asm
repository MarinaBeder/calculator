CalcLog:    
      div bx
      inc cx
      cmp ax,1
      jne CalcLog         
      ret              
            
Log: mov ah,9 
     mov dx, offset msg7
     int 21h 
     mov cx,0
     call InputNo
     push dx      
     mov ax,1   
     mov cx,0
     mov cx, bx
     mov ah,9
     mov dx, offset msg8
     int 21h 
     mov cx,0
     call InputNo
     pop ax
     mov bx,dx
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