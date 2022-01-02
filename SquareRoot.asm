
CalcSquareRoot:           
    	 inc cx 
	    mov	ax, cx	
	    mul	cx         
	    cmp	ax, bx	
	    jne  CalcSquareRoot
	    
	     	 
	    
	   
	    ret   
	    
	   
	   
	    		    
    SquareRoot:
            mov ah,9 
            mov dx, offset msg7
            int 21h 
            mov cx,0
            call InputNo
             push dx
            pop bx
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




