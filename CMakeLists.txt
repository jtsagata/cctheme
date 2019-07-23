cmake_minimum_required(VERSION 3.14)
project(cthemegen VERSION "0.0.1" DESCRIPTION "Color Scheme switcher")

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/support)
include(cotire)
include(git_revision)

add_subdirectory(src)