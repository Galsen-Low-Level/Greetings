;@file  io.S 
;@brief  io standard manipulation routines 


io_print: 
  push edx 
  push ecx 
  push ebx 
  push eax  

  call chrlen 

  mov edx , eax 
  pop eax 
  mov ecx ,  eax 
  mov ebx , 1 
  mov eax , 4 
  
  int 80h 
  
  pop ebx 
  pop ecx 
  pop edx 
  ret 



io_printlf: 
  call io_print  
  mov  eax , 0b1010 
  push eax  
  mov  eax , esp 
  call io_print  
  pop eax  
  ret  


;=== 
;io_putc(single_character) 
;print single character on console

io_putc: 
  push eax 
  mov eax , esp 
  call io_print  

  pop eax 
  ret  

;=====
;io_puts(string)
;like io_putc  but with linefeed 

io_puts: 
  call io_putc 
  mov  eax , 0ah
  call io_putc 
  ret  

 

io_read: 
  push ecx
  push ebx

  mov  ecx , eax 
  push eax  
  mov  ebx , 0 
  mov  eax , 3  

  int 80h  

  pop eax  
  pop ebx 
  pop ecx 
  
  ret 
