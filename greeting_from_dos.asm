; Greeting from MS-DOS console  
; This Program  use  MS-DOS  interupt function call  
; Author Umar Ba <jUmarB@protonmail.com> <github/Jukoo> 
;-------------------------------------------------------

bits 16            ;    Using  16 bit mode  
org 0x100          ;   .COM starting address this is specific to MS-DOS   

mov si,  gll_greetings_mesg  
xor ax, ax
print_each_char: 
mov dl , [si]
or  dl , dl 
jz end_print_each_char
mov ah, 02h 
int 021h 
inc si 
jmp print_each_char 

end_print_each_char: 
ret 

gll_greetings_mesg: db "Welcome and Greetings to Galsen Low Level",0ah,00h 
