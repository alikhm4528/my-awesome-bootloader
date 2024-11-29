
// Bootrom v2.0.0

.cpu cortex-m0
.thumb
.section .vectors
.balign 2

.global __vectors
__vectors:
.word _stacktop // MSP
.word _start    // Reset

.global _magic
_magic:
# magic
.byte 'M', 'u'
# compatibility version (change if function table is incompatible, or functions are backwards incompatible)
.byte 1
# ROM version
.byte 3

.global _well_known
_well_known:
.hword function_table
.hword 0 // pad

function_table:
# function table
.byte 'D', 'T'
.hword debug_trampoline + 1
.byte 'D', 'E'
.hword debug_trampoline_end + 1
.byte 'J', 'P'
.hword just_a_printf + 1
# end of function table marker
.hword 0

// ----------------------------------------------------------------------------
// Entry point for both cores
// ----------------------------------------------------------------------------

.global _start
.type _start,%function
.thumb_func
_start:
    bl main

// ----------------------------------------------------------------------------
// Simple debugger trampoline for break-on-return
// ----------------------------------------------------------------------------
// This is handy for the debugger calling ROM routines without setting hardware
// breakpoints, mainly useful for flash programming.
// Set function address in r7, pass args through r0...r3 as per ABI,
// then jump to this trampoline.

.global debug_trampoline
.type debug_trampoline,%function
.thumb_func
debug_trampoline:
    // Ensure the LSB is set (Thumb Mode) to avoid hardfault
    mov r6, #1
    orr r7, r7, r6
    blx r7
debug_trampoline_end:
    bkpt #0
    b debug_trampoline
