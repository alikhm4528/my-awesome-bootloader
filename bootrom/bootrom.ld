MEMORY {
    ROM(rx) : ORIGIN = 0x00000000, LENGTH = 8K
    SRAM(rwx) : ORIGIN = 0x20000000, LENGTH = 4K
}

SECTIONS {
    . = ORIGIN(ROM);
    .text : {
        KEEP(*(.vectors))
        *(.text*)
        end_of_text = .;
        . = ALIGN(LENGTH(ROM));
    } >ROM =0x00be

     /* Leave room above the stack for stage 2 load, so that stage 2
       can image SRAM from its beginning */
    _stacktop = ORIGIN(SRAM) + LENGTH(SRAM);
}
