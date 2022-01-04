Factorial:    mov ah,9 
            mov dx, offset msg7
            int 21h 
            mov cx,0
            call InputNo
             mov cx,dx
            
            mov ax,1   
          
          	
	        call  CalcFactorial
	     
	        mov dx, ax
           
            push dx 
            mov ah,9
            mov dx, offset msg5
            int 21h
            mov cx,10000
            pop dx
            call View 
            jmp exit  




