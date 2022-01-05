CalcPowerSquare:
        mul	bx     
	      
	    dec cx
	    cmp cx,0
	    jne CalcPowerSquare        
	    
	    
	     	 
	    
	   
	    ret              
            
PowerSquare:    
             mov ah,9 
            mov dx, offset msg7
            int 21h 
            mov cx,0
            mov ax,1
            call InputNo
             mov ax,1
            push dx
            pop bx
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