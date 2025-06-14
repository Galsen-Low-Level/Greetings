;@file exit.S 
;@brief  exit program  

;==
;exit(exit_code) 
;exit program 


exit: 
  push ebx 
  mov  ebx , eax 
  mov  eax , 01h 
  
  int 80h 
