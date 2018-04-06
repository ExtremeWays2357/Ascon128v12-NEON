.fpu neon
.text
.align 4
.global permutation
.global permutation
.type permutation STT_FUNC
.type permutation STT_FUNC
permutation:
permutation:

VLDM.64 r0, {d1-d5}
VREV64.8 d1, d1
VREV64.8 q1, q1
VREV64.8 q2, q2
MOV r3, #0xf
VMOV.I8 d0, #0

add r2, r1, r2 

VPUSH {q4,q5,q6,q7}

._looptop:
sub r12, r3, r1 
LSL r12, r12, #4
orr r12, r12, r1  
#########################
# START OF substitution #
#########################
VEOR d14, d1, d5
VEXT.64 d6, d2, d2, #0
VMOV d0[0], r12
VEOR d8, d3, d0
VEXT.64 d7, d4, d4, #0
VMVN d2, d14
VEXT.64 d9, d5, d5, #0 
VEOR q4, q4, q3
VMVN q5, q4
VEXT.64 d15, d8, d8, #0
VMVN q6, q3
VEXT.64 d3, d10, d10, #0
VAND q6, q6, q4
VAND d11, d11, d14
VAND q1, q1, q3
VEXT.64 d10, d3, d3, #0
VEOR q7, q7, q6
VEOR q3, q3, q5
VMVN d3, d15
VEOR d5, d9, d2
VEOR q3, q3, q7
VEXT.64 d4, d7, d7, #0
VSHR.U64 d13,d3,#6
VSHL.I64 d15,d3,#58
VEOR d1, d14, d5 
VEXT.64 d2, d6, d6, #0

######################
# START OF DIFFUSION #
######################
VSHR.U64 d12,d3,#1
VSHL.I64 d14,d3,#63

VSHR.U64 d24,d2,#61
VSHL.I64 d25,d2,#3
VEOR q6, q6, q7
VSHR.U64 d26,d2,#39
VSHL.I64 d27,d2,#25

VSHR.U64 d28,d1,#19
VSHL.I64 d29,d1,#45
VEOR q12, q12, q13
VSHR.U64 d30,d1,#28
VSHL.I64 d31,d1,#36
VEXT.64 d7, d12, d12, #0

VSHR.U64 d16,d4,#10
VSHL.I64 d18,d4,#54
VEXT.64 d9, d13, d13, #0
VSHR.U64 d17,d4,#17
VSHL.I64 d19,d4,#47
VEXT.64 d6, d24, d24, #0

VSHR.U64 d20,d5,#7
VSHL.I64 d22,d5,#57
VSHR.U64 d21,d5,#41
VEXT.64 d8, d25, d25, #0
VSHL.I64 d23,d5,#23

VEOR q14, q14, q15
VEOR q12, q12, q13
VEOR q10, q10, q11
VEOR q8, q8, q9
VEOR q3, q4, q3
VEOR d26, d28, d29
VEOR d30,d16,d17
VEOR d31,d20,d21
VEOR d1,d1,d26
VEOR q1,q1,q3
VEOR q2, q2, q15


add r1, r1, #1
CMP r1, r2
bne ._looptop
VREV64.8 d1, d1
VREV64.8 q1, q1
VREV64.8 q2, q2
VPOP {q4,q5,q6,q7}
VSTM.64 r0, {d1-d5}
# return with the link register
bx lr
