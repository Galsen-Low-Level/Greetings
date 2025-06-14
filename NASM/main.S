[BITS 32]

%include "exit.S"
%include "io.S"
%include "chr.S"
%include "misc.S"

SEGMENT .data
mesg db "User Login : ",00h

;TODO : Faire un algorithm qui permet de remplacer 
;     '?' par quelques choses d'autre  comme un nom
welcom_mesg  db  "Hi ? Nice to meet you",00h




SEGMENT .bss
ulogin: resb  255 


SEGMENT .TEXT 
  global _start 

_start:

  pop ecx 
  
  _argloop: 
  or ecx ,ecx 
  jz argloop_ 
  pop eax 
  call io_printlf 
  dec ecx 
  jmp _argloop 

  argloop_: 
  mov eax , '!' 
  call io_putc 
  ; count to 10  

  
  call count_10 
  

  mov eax ,mesg 
  call io_printlf 

  mov edx , 0ffh 
  mov eax , ulogin 
  call io_read 

  call io_print


  call exit
