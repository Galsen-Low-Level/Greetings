; Greeting from the bootloader  
; This Program  use  BIOS  interupt function call  
; This file produce  a simple   Master Boot Record boot sector 
; Author Umar Ba <jUmarB@protonmail.com> <github/Jukoo>  
;-------------------------------------------------------

bits 16     ; Using  16 bit mode 

org 0x7C00  ; Boot Sector Startup point  

_start: 
   mov si , gll_greetings_boot_mesg 
   mov ah , 03h   ; Get the cursor position 
   int 10h  
   
   mov cx, 01h      

   print_char:
   mov al , [si]
   or  al , al 
   jz  end_print_char 

   mov ah ,02h   ;  Set the cursor position 
   int 010h 
   
   mov ah , 0ah 
   int 010h  

   inc si 
   inc dl        ; Move the cursor forward  
   jmp print_char  

   end_print_char:
   ret 

   hlt 

  
gll_greetings_boot_mesg: db "Greetings and Welcome to Galsen Low Level",0ah,00h   

           
times 510 - ($-$$) db 0    ; Fill with 0 
dw  0AA55h                 ; boot signature   

