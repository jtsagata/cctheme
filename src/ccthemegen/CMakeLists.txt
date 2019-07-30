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
        )

set(ERROR_FLAGS "-Wall -Wextra -Wshadow")

add_executable(ccthemegen ${cthemegen_src})
target_link_libraries(ccthemegen
        cxxopts inja
        nlohmann_json
        cctheme::colors)

set_target_properties(ccthemegen
        PROPERTIES
        COMPILE_FLAGS ${ERROR_FLAGS}
        RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}
        )
cotire(ccthemegen)


