;@file misc.S 
;@brief  miscelleanous 


;=== 
;count_10(void) 
;count to 10  


count_10: 
  push ecx 
  xor  ecx ,ecx 
  mov  eax , ecx 
  _c10:
  inc  ecx 
  mov  eax , ecx 
  add  eax, 48 
  call io_puts
  cmp  ecx , 10  
  je  c10_ 
  jmp _c10 
  
  c10_:
  pop ecx 
  ret  
