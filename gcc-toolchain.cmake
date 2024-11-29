set(CMAKE_C_COMPILER arm-none-eabi-gcc) # Specify the C compiler
set(CMAKE_CXX_COMPILER arm-none-eabi-g++) # Specify the C++ compiler
set(CMAKE_ASM_COMPILER arm-none-eabi-as) # Specify the assembler

set(CMAKE_OBJCOPY "arm-none-eabi-objcopy")
set(CMAKE_OBJDUMP "arm-none-eabi-objdump")

set(CMAKE_C_FLAGS "-mcpu=cortex-m0 -mthumb -march=armv6-m -mfloat-abi=softfp")
