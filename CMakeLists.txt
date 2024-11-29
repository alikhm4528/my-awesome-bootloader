# Based on Raspberry Pie Pico (rp2040) bootrom

cmake_minimum_required(FATAL_ERROR VERSION 3.15.0)
project(my-awesome-bootloader LANGUAGES C ASM VERSION 2.0.0)
# project(my-awesome-bootloader VERSION 2.0.0)

enable_language(ASM)

include(cmake_utility/function_definitions.cmake)

add_executable(${PROJECT_NAME}
    bootrom/bootrom_rt0.S
    bootrom/bootrom_main.c
)

function(target_cl_options option)
    target_compile_options(${PROJECT_NAME} PRIVATE ${option})
    target_link_options(${PROJECT_NAME} PRIVATE ${option})
endfunction()

include(gcc-toolchain.cmake)

target_cl_options("-fno-jump-tables")
target_cl_options("-g")
target_cl_options("-Os")
target_cl_options("-ffunction-sections")
target_cl_options("-fdata-sections")
target_cl_options("-flto")
target_cl_options("-nostdlib")
target_cl_options("-nodefaultlibs")

target_link_options(${PROJECT_NAME} PRIVATE "LINKER:--build-id=none")
# target_link_options(${PROJECT_NAME} PRIVATE "LINKER:--undefined=isr_irq5")
target_link_options(${PROJECT_NAME} PRIVATE "LINKER:--gc-sections")
target_link_options(${PROJECT_NAME} PRIVATE "--specs=nosys.specs")
target_link_options(${PROJECT_NAME} PRIVATE "-nostartfiles")

target_cl_options("-Wall")
target_cl_options("-Wextra")
# Have seen some awful code without this:
target_cl_options("--param")
target_cl_options("max-completely-peel-times=4")

target_compile_definitions(${PROJECT_NAME} PRIVATE
        NDEBUG
)

target_link_options(${PROJECT_NAME} PRIVATE "LINKER:--script=${CMAKE_CURRENT_LIST_DIR}/bootrom/bootrom.ld")
set_target_properties(${PROJECT_NAME} PROPERTIES LINK_DEPENDS ${CMAKE_CURRENT_LIST_DIR}/bootrom/bootrom.ld)


# add_hex_output(${PROJECT_NAME})
# add_bin_output(${PROJECT_NAME})
# add_elf_output(${PROJECT_NAME})
# add_lst_output(${PROJECT_NAME})

