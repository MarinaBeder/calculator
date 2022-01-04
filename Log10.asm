Log10:     mov ah,9 
            mov dx, offset msg7
            int 21h 
            mov cx,0
            call InputNo
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