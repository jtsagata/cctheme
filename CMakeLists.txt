cmake_minimum_required(VERSION 3.2)
project(cctheme
        VERSION "0.0.1"
        LANGUAGES CXX
        HOMEPAGE_URL https://github.com/jtsagata/cctheme
        DESCRIPTION "Color Scheme switcher")

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/support)
include("support/HunterGate.cmake")

include(cotire)
include(git_revision)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)


add_subdirectory(src)