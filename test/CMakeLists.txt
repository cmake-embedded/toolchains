cmake_minimum_required(VERSION 3.19)

project(firmware C CXX ASM)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_EXTENSIONS ON)
set(CMAKE_C_STANDARD 11)

if (CMAKE_CROSSCOMPILING)
    add_executable(firmware)
    target_sources(firmware PRIVATE main.cpp startup.s)
    target_print_memory_usage(firmware)
    target_linker_script(firmware ${CMAKE_CURRENT_LIST_DIR}/flash.ld)
    target_export_bin(firmware)
    target_export_hex(firmware)
endif ()
