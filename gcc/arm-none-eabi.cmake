if(NOT ARM_NONE_EABI_CONFIGURED)
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)
set(CMAKE_SYSTEM_VERSION 1)

# specify cross compilers and tools
set(CMAKE_C_COMPILER arm-none-eabi-gcc)
set(CMAKE_CXX_COMPILER arm-none-eabi-g++)
# intended to use "gcc" instead of "as" to recognize more options such as optimization option "-Ox"
set(CMAKE_ASM_COMPILER arm-none-eabi-gcc)
set(CMAKE_AR arm-none-eabi-ar)
set(CMAKE_OBJCOPY arm-none-eabi-objcopy)
set(CMAKE_OBJDUMP arm-none-eabi-objdump)
set(SIZE arm-none-eabi-size)
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

function(target_linker_script target script)
    get_target_property(target_type ${target} TYPE)
    if(target_type STREQUAL "EXECUTABLE")
        target_link_options(${target} PRIVATE "LINKER:-T,${script}")
        set_target_properties(${target} PROPERTIES LINK_DEPENDS ${script})
    else()
        target_link_options(${target} INTERFACE "LINKER:-T,${script}")
        set_target_properties(${target} PROPERTIES INTERFACE_LINK_DEPENDS ${script})
    endif()
endfunction()

function(target_print_memory_usage target)
    target_link_options(${target} PRIVATE "LINKER:--print-memory-usage,-Map=$<TARGET_FILE:${target}>.map")
endfunction()

function(target_export_hex TARGET)
add_custom_command(TARGET ${TARGET} POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} -Oihex $<TARGET_FILE:${TARGET}> $<TARGET_FILE:${TARGET}>.hex
    COMMAND ${CMAKE_COMMAND} -E echo "Exporting $<TARGET_FILE:${TARGET}>.hex"
    )
endfunction()

function(target_export_bin TARGET)
add_custom_command(TARGET ${TARGET} POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} -Obinary $<TARGET_FILE:${TARGET}> $<TARGET_FILE:${TARGET}>.bin
    COMMAND ${CMAKE_COMMAND} -E echo "Exporting $<TARGET_FILE:${TARGET}>.bin"
    )
endfunction()
set(ARM_NONE_EABI_CONFIGURED TRUE)
endif()
