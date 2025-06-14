;@file chr.S 
;@brief character manipulation 
 

;==
;chrlen(source_string) 
;Calculate the lenght of the string 

chrlen:  
  push ebx 
  mov  ebx, eax 
  
  _iter: 
  or  byte[eax], 00h 
  jz  iter_ 
  inc eax 
  jmp _iter 

  iter_: 
  sub eax , ebx 
  pop ebx 
  ret  
