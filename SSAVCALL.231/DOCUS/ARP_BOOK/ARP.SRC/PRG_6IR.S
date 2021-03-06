 ; Program Name: PRG_6IR.S
 ;      Version: 1.001

 ; Function:

 ;    Illustrate the manner in which numbers are placed in the stack.

 ; Assembly Instruction:

 ;    Assemble in Relocatable mode, go to the debugger and click on the
 ; relocate button.

 ; Execution Instructions:

 ;    In the debugger, use the Single step button to execute only the
 ; instructions which load a stack address into register A7 and those which
 ; store values into the stack.  Move the PC cursor manually to jump over
 ; the stack space declarations.

 text
push_word_1:
 lea       stack_1, sp
 move.w    #5, -(sp)
           ds.l  1
stack_1:   ds.l  0

 text
push_longword_1:
 lea       stack_2, sp
 move.l    #5, -(sp)
           ds.l  2
stack_2:   ds.l  0

 text
push_word_2:
 lea       stack_3, sp
 move.w    #1770, -(sp)
           ds.l  1
stack_3:   ds.l  0

 text
push_longword_2:
 lea       stack_4, sp
 move.l    #1234567890, -(sp)
           ds.l  2
stack_4:   ds.l  0
 end


 