 ; Program Name: PRG_6AP.S
 ;      Version: 1.002

 ; Assembly Instructions:

 ;     Assemble in PC-relative mode and save with a TOS extension.

 ; Program Function:

 ;    This is a LSR program that installs custom trap #11, which is invoked
 ; by PRG_6BP.TOS.  This program uses traps installed by CUSTOM.PRG.

program_start:                  ; Calculate program size and retain result.
 lea        program_end, a3     ; Fetch program end address.
 suba.l     4(a7), a3           ; Subtract basepage address.

enter_supervisor_mode:
 trap       #0                  ; Sets bit 13 of status register to 1.

install_trap_11_routine:        ; Note: pointer = vector = pointer.
 lea        trap_11_routine, a0 ; Fetch address of trap #11 routine.
 move.l     a0, $AC             ; Store trap address at pointer address.
 
enter_user_mode:
 andi.w     #$DFFF, SR          ; Sets bit 13 of status register to 0.

relinquish_processor_control:   ; Maintain memory residency.
 move.w     #0, -(sp)           ; Exit code.
 move.l     a3, -(sp)           ; Program size.
 move.w     #$31, -(sp)         ; Function = ptermres = GEMDOS $31.
 trap       #1

trap_11_routine:

 ; When trap #11 is invoked, the CPU pushes the calling program's return
 ; address onto the supervisor stack, then it pushes the calling program's
 ; status register contents onto the supervisor stack.

 ; This custom trap #11 handler sets bit #13 of the calling program's status
 ; register.  The bset instruction can be used to set a bit in the first
 ; byte of the word on the top of the stack.  Bit #13 of the status register
 ; is bit #5 of that byte.  Note: to set a bit means to make it equal to 1.

 ; When the rte instruction is executed, the CPU will return to the calling
 ; program with the altered copy of its status register, and the calling
 ; program will now be executing in supervisor mode.

 ; Register A7 will contain the address of the supervisor stack.  The calling
 ; program now has complete control of the system.  But a decision about
 ; which stack is to be used must be made. 

 ; The calling program can choose to continue with A7 pointing to the 
 ; supervisor stack, or it can save the contents of A7 = SSP and load the
 ; address of a user stack into A7.  Processing can continue in that manner
 ; until it is necessary to return to user mode.  The return to user mode
 ; can be accomplished by reloading A7 with the SSP, then by resetting bit
 ; #13 of the status register.  Note: resetting a bit means to make it equal
 ; to 0.
 
print_current_SSP:              ; SSP = address of supervisor stack.
 lea        header_1, a0
 bsr.s      print_string
 move.l     a7, d1              ; Convert to ASCII hexadecimal.
 trap       #5
 bsr.s      print_string
 bsr.s      print_newline
 bset       #5, (sp)            ; The invoking program will be executing in 
 rte                            ; supervisor mode upon return.

 ;
 ; SUBROUTINES
 ;

print_string:         
 pea        (a0)
 move.w     #9, -(sp) 
 trap       #1        
 addq.l     #6, sp    
 rts

print_newline:
 lea        newline, a0
 bsr.s      print_string
 rts

 data
newline:     dc.b $D,$A,0
header_1:    dc.b '    During trap 11 invocation:  ',0
 bss
 align
program_end: ds.l 0
 end
 