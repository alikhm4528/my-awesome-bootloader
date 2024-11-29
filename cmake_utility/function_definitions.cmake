function(add_hex_output TARGET)
    set(output_path ${CMAKE_SOURCE_DIR}/build/${TARGET}.hex)
    add_custom_command(TARGET ${TARGET} POST_BUILD
        COMMAND ${CMAKE_OBJCOPY} -Oihex $<TARGET_FILE:${TARGET}> ${output_path}
    )
endfunction()

function(add_bin_output TARGET)
    set(output_path ${CMAKE_SOURCE_DIR}/build/${TARGET}.bin)
    add_custom_command(TARGET ${TARGET} POST_BUILD
        COMMAND ${CMAKE_OBJCOPY} -O binary $<TARGET_FILE:${TARGET}> ${output_path}
    )
endfunction()

function(add_elf_output TARGET)
    set(output_path ${CMAKE_SOURCE_DIR}/build/${TARGET}.elf)
    add_custom_command(TARGET ${TARGET} POST_BUILD
        COMMAND cp $<TARGET_FILE:${TARGET}> ${output_path}
    )
endfunction()

function(add_lst_output TARGET)
    set(output_path ${CMAKE_SOURCE_DIR}/build/${TARGET}.lst)
    add_custom_command(TARGET ${TARGET} POST_BUILD
        COMMAND ${CMAKE_OBJDUMP} -h -S $<TARGET_FILE:${TARGET}> > ${output_path}
    )
endfunction()
