## Test Executable

set(COLOR_LIB_SRCS colors.h colors.cpp named_colors.cpp color_conv.cpp)

add_library(colors ${COLOR_LIB_SRCS})
target_include_directories(colors
        PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
        $<INSTALL_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
        )
target_link_libraries(colors fmt::fmt)


#Add an alias so that library can be used inside the build tree, e.g. when testing
add_library(cctheme::colors ALIAS colors)

add_executable(test_colors EXCLUDE_FROM_ALL colors-test.cpp)
target_link_libraries(test_colors colors Catch2)


ADD_TEST(colors test_colors)