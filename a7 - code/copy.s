.pos 0x100
start:           
                 
                 ld   $stackBtm, r5       # [01] sp = address of last word of stack
                 inca r5                  # [02] sp = address of word after stack
                 gpc  $6, r6              # [03] ra = pc + 6
                 j    main                # [04] call copy()
                 halt
.pos 0x200
main:           
                 deca r5                # allocate on spot for the ra
                 st r6, (r5)            # store the ra
                 gpc $6, r6             # ra = pc+6
                 j copy                 # call copy()
                 ld (r5), r6            # ra for main
                 j (r6)                 # return
.pos 0x300
copy:            deca r5                  # one spot for ra
                 st   r6, (r5)            # [06] save ra on stack
                 deca r5                  # [05] allocate calle part of copy's frame (dst[1 for indexing])
                 deca r5                  # [05] allocate calle part of copy's frame (dst[0 for indexing])
                 deca r5                  # [05] allocate calle part of copy's frame (i)
                 ld $0, r0                # r0 = temp_i = 0
 while:          ld $src, r1              # r1 = &src
                 ld (r1,r0,4), r2         # r2 = src[temp_i]

                 beq r2, end              # if s[i] == 0, done while loop
                 
                 ld $4, r3                # r3 = 8
                 add r5, r3               # r3 = r5+8 (dst[0])
                 st r2, (r3,r0,4)         # dst[i] = src[i]? r0 would be +... we need -
                 inc r0                    # temp_i ++
                 br while                  # next iteration
end:
                 ld $0, r4                # r3 = 0
                 st r4, (r3, r0, 4)       # dst[i] = 0
                 st r0, (r5)              # i = temp_i
                 ld   16(r5), r6          # [19] load ra from stack
                 inca r5                  # [20] remove callee part of stack frame
                 inca r5                  # [20] remove callee part of stack frame
                 inca r5                  # [20] remove callee part of stack frame
                 inca r5                  # [20] remove callee part of stack frame
                 j    (r6)                # [21] return






.pos 0x400
src:             .long 1         # s[0]
                 .long 2         # s[1]
                 .long 3         # i
                 .long 0x102c    # overwrite ra with an address for the virus?
                 .long 0x0000ffff # set -1 for all registers then halt
                 .long 0xffff0100
                 .long 0xffffffff
                 .long 0x0200ffff
                 .long 0xffff0300
                 .long 0xffffffff
                 .long 0x0400ffff
                 .long 0xffff0500
                 .long 0xffffffff
                 .long 0x0600ffff
                 .long 0xffff0700
                 .long 0xffffffff
                 .long 0xf000ffff
.pos 0x1000
stackTop:        .long 0x00000000
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000 
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000                
stackBtm:        .long 0x00000000
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000 
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000 
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000