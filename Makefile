#  Makfile   
#  Author Umar Ba <jUmarB@protonmail.com>  <github/Jukoo> 
#  The compilation rely  Nasm  to be installed  
ASM:=nasm  

DOS_FILE:= gll.com 
MBR_FILE:= gll.bin  

#By  default  it use  qemy-system-i386  
Qemu_system_default:=i386 

all: ms-dos  boot-mbr 

# For MS-DOS application   
ms-dos: greeting_from_dos.asm
	$(info  Generating  MS-DOS .COM $(DOS_FILE))  
	@$(ASM)  $^ -o  $(DOS_FILE) 

boot-mbr: greeting_from_bootloader.asm
	$(info Generating MBR $(MBR_FILE))
	@$(ASM)  $^ -o  $(MBR_FILE)  

launch-dosbox: ms-dos  
	$(info launching dosbox application) 
	dosbox  $(DOS_FILE)

run-qemu:  boot-mbr 
	$(info lauching  qemu-system) 
	qemu-system-$(Qemu_system_default)   $(MBR_FILE) 


clean:  
	$(info cleaning ) 
	@rm  $(MBR_FILE) $(DOS_FILE) 

.PHONY: all clean  


