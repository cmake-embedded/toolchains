include(${CMAKE_CURRENT_LIST_DIR}/cortex-mx.cmake)
add_compile_options(-mcpu=cortex-m0)
add_link_options(-mcpu=cortex-m0)
