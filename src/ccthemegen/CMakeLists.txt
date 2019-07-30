# configure header file
configure_file(
        config.h.in
        ${CMAKE_CURRENT_BINARY_DIR}/config.h
        @ONLY
)
set(CMAKE_INCLUDE_CURRENT_DIR ON)

# The scheme generator
set(cthemegen_src
        ccthemegen.cpp
        utils.cpp utils.h
        compile.cpp
        tty_colors.h
        colors.h colors.cpp
        named_colors.cpp color_conv.cpp)

set(ERROR_FLAGS "-Wall -Wextra -Wshadow")

add_executable(ccthemegen ${cthemegen_src})
target_include_directories(ccthemegen PRIVATE ../ext)

target_link_libraries(ccthemegen fmt::fmt)
set_target_properties(ccthemegen
        PROPERTIES
        COMPILE_FLAGS ${ERROR_FLAGS}
        RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}
        )
cotire(ccthemegen)

## TODO: Proper testing framework like gtest
## Test Executable
add_executable(test_colors EXCLUDE_FROM_ALL colors-test.cpp
        colors.h colors.cpp named_colors.cpp color_conv.cpp)
target_link_libraries(test_colors fmt::fmt)
