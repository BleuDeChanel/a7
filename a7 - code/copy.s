.pos 0x100
start:           
                 
                 ld   $stackBtm, r5       # [01] sp = address of last word of stack
                 inca r5                  # [02] sp = address of word after stack
                 # # gpc  $6, r6              # [03] ra = pc + 6

                 # # do we deca for src[2] here?
                 # deca r5                  # spot for src[0] ?
                 # ld $1, r0                # r0 = 1
                 # st r0, (r5)              # src[0] = 1
                 # ld $src, r4              # r4 = &src
                 # st r0, (r4)              # src[0] = 1

                 # deca r5                  # spot for src[1]
                 # ld $0, r0                # r0 = 0
                 # st r0, (r5)              # src[1] = 0
                 # st r0, 4(r4)             # src[1] = 0
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
                 
                 # st r0, (r5)              # i = 0
           # could we use r0 to represent i, or need to read? feel like a6 2 was 0 bc of this...
                 # ld (r5), r0              # r0 = i
 while:          ld $src, r1              # r1 = &src
                 ld (r1,r0,4), r2         # r2 = src[temp_i]

                 beq r2, end              # if s[i] == 0, done while loop
                 
                 # is index reversed in stack? (to access dst[i])
                 ld $4, r3                # r3 = 8
                 add r5, r3               # r3 = r5+8 (dst[0])
                 # mov r0, r5               # r5 = r0 = temp_i
                 # not r5
                 # inc r5                   # r5 = -i
                 st r2, (r3,r0,4)         # dst[i] = src[i]? r0 would be +... we need -
                 inc r0                    # temp_i ++
                 br while                  # next iteration


                 # ld $20, r1               # r1 = 20 (offset to s[0])
                 # add r5, r1               # r1 = r5 + 20 = &s[0]
                 # ld (r1, r0, 4), r1       # r1 = s[i]
                 # beq r1, end              # if s[i] == 0, done while loop

                 # ld $8, r2                # r2 = 8 (offset to dst[0])
                 # add r5, r2               # r2 = r5 + 8 = &dst[0]
                 # st r1, (r2, r0, 4)       # dst[i] = s[i]
                

end:
                 ld $0, r4                # r3 = 0
                 st r4, (r3, r0, 4)       # dst[i] = 0
                 st r0, (r5)              # i = temp_i
                 ld   12(r5), r6          # [19] load ra from stack
                 inca r5                  # [20] remove callee part of stack frame
                 inca r5                  # [20] remove callee part of stack frame
                 inca r5                  # [20] remove callee part of stack frame
                 inca r5                  # [20] remove callee part of stack frame
                 j    (r6)                # [21] return


.pos 0x400
src:             .long 1         # s[0]
                 # .long 0         # s[1]
                 .long 2         # s[1]
                 .long 3         # i
                 .long 0x414 # address for the virus?
                 .long 0
                 .long 0x0000ffff # set -1? idk
                 .long 0xffff0000
                 .long 0xffffffff

                 .long 0x0000ffff
                 .long 0xffff0000
                 .long 0xffffffff

                 .long 0x0000ffff
                 .long 0xffff0000
                 .long 0xffffffff

                 .long 0x0000ffff
                 .long 0xffff0000
                 .long 0xffffffff



                
.pos 0x1000
stackTop:        .long 0x00000000
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000                 
stackBtm:        .long 0x00000000
