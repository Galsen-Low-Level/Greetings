; Greeting from MS-DOS console  
; This Program  use BIOS/MS-DOS  interupt function call  
; Author Umar Ba <jUmarB@protonmail.com> <github/Jukoo> 
;-------------------------------------------------------

bits 16             ;    Using  16 bit mode  
org 0x100           ;   .COM starting address this is specific to MS-DOS   

xor si , si  
xor bx ,bx

;Set MS-DOS Video mode   
;mov al , 013h      ; Graphical mode. 40x25. 256 colors. 320x200 pixels. 1 page. 
;mov ah ,0 
;int 010h  

mov ah,03h         ;  Get cursor position   
int 010h 

mov cx , 01h       
print_char:
mov al , [gll_greetings_mesg+si]
cmp al , 0        
jz _print_char     
cmp al , 0ah       ; Testing '\n' char to make linefeed 
je linefeed
cmp al  ,0dh       ; Testing 'enter' 13 
je linefeed  

set_cursor_pos: 
mov  ah, 02h 
int  010h  

mov ah, 09h 
mov bl, dl  
int 010h 

inc si 
inc dl 
jmp print_char 

_print_char: 
ret 

linefeed: 
inc dh             ; next line 
xor dl,dl          ; reset column 
jmp set_cursor_pos

gll_greetings_mesg: db "Welcome and Greetings to Galsen Low Level",0ah,00h 
