; Greeting from MS-DOS console  
; This Program  use BIOS/MS-DOS  interupt function call  
; Author Umar Ba <jUmarB@protonmail.com> <github/Jukoo> 
;-------------------------------------------------------

[BITS 16]     ;    Using  16 bit mode  
[ORG  0100h]  ;   .COM starting address this is specific to MS-DOS   


mov ah , 00h 
mov al , 02h
int 010h 

mov si , bootmesg
call print_console

mov si , login_username
call print_console

mov si , bootmesg

call username_login_prompt

push si
mov  si ,  greeting_mesg_to_user
call print_console

pop si
mov si , bootmesg
call print_console

call linefeed

mov si , linedraw
mov byte[si+49] , 00h
call print_console
call linefeed

mov ah , 03h
int 010h

inc dh
xor dl ,dl

mov ah , 02h
int 010h

mov si , shellmesg
call print_console


ret


username_login_prompt:
  push ax
  push bx
  push cx
  push dx

  mov  ah , 03h
  int 10h

  xor bx , bx
  mov cx , 01h


  __listen_kb_stroke:
  mov ah , 01h
  int  016h
  jz __listen_kb_stroke

  mov ah , 00h   ; Reading stdin buffer
  int 016h

  mov [si], al
  inc si
  cmp al ,0dh
  je  listen_kb_stroke__

  mov ah , 09h
  mov bl , dl   ; NOTE for color attribute solid white replace the dl by 0111b
  int 010h

  inc dl
  mov ah , 02h
  int 010h

  jmp __listen_kb_stroke


  listen_kb_stroke__:
  mov byte[si], 00h
  call linefeed
  mov  ah , 02h
  int  010h

  pop dx
  pop cx
  pop bx
  pop ax
  ret


linefeed:
  inc dh
  xor dl , dl
  ret

print_console:
  push dx
  push bx
  push ax
  push cx


  mov  ah , 03h
  int  010h

  xor bx, bx

  __printer:
  mov cx , 01h

  mov  al , [si]
  or   al , al
  jz printer__

  cmp  al , 0dh
  je   jump_next_line

  cmp  al , 0ah
  je   jump_next_line


  move_cursor_forward:
  mov  ah , 02h
  int  010h
  cmp cx , 0h
  je  incr

  mov  ah , 09h
  mov  bl , 0111b
  int 010h


  incr:
  inc si
  inc dl

  jmp __printer

  jump_next_line:
  call linefeed
  mov  cx , 00h
  jmp  move_cursor_forward

  printer__:
  pop  cx
  pop  ax
  pop  bx
  pop  dx
  ret


bootmesg : db ">> Marginal Boot System <<",0dh,"Welcome and Greeting to GLL",0ah ,00h
login_username : db "User Login: ", 00h
greeting_mesg_to_user : db "Welcome to GLL : " , 00h
shellmesg : db "WARNING:No Shell Available  At This moment...",0dh,"Stay Tuned",0dh,"Appreciate Computers At All Level!",0ah,00h
linedraw :times  50 db 0x2d
