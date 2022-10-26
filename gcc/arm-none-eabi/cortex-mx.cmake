include(${CMAKE_CURRENT_LIST_DIR}/../arm-none-eabi.cmake)

# Put every function and data in its own section. Use with “--gc-sections” to reduce code size.
add_compile_options("$<$<COMPILE_LANGUAGE:C,CXX>:-ffunction-sections;-fdata-sections>")
add_compile_options($<$<COMPILE_LANGUAGE:C,CXX>:-fno-common>)
add_compile_options($<$<COMPILE_LANGUAGE:C,CXX>:-fmessage-length=0>)
# Treat a floating-point constant as single precision constant instead of implicitly converting it to double precision.
add_compile_options($<$<COMPILE_LANGUAGE:C,CXX>:-fsingle-precision-constant>)

# strip type info will save some flash
add_compile_options($<$<COMPILE_LANGUAGE:CXX>:-fno-rtti>)
# strip exception unwind code will save about 100kb flash
add_compile_options($<$<COMPILE_LANGUAGE:CXX>:-fno-exceptions>)
add_compile_options($<$<COMPILE_LANGUAGE:CXX>:-fno-unwind-tables>)
# allow register keyword to keep compatible with legacy c code
add_compile_options($<$<COMPILE_LANGUAGE:CXX>:-Wno-register>)

# Remove sections that are not used. Be careful with this option because it could also remove sections that are
# indirectly referenced. You can check linker map report to see what is removed and use KEEP() function in the linker
# script to ensure that certain data/code are not removed.
add_link_options(LINKER:--gc-sections)
# Use the Newlib-nano runtime library (introduced in version 4.7 of GNU Tools for ARM! Embedded Processors). To reduce
# code size
add_link_options(--specs=nano.specs)
