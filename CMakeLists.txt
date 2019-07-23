cmake_minimum_required(VERSION 3.14)
project(ct_colors)

include(ext/cotire.cmake)

add_executable(ct_colors main.cpp)
target_include_directories(ct_colors PRIVATE ext)
cotire(ct_colors)