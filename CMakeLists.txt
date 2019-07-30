cmake_minimum_required(VERSION 3.2)

project(cctheme
        VERSION "0.0.1"
        LANGUAGES CXX
        HOMEPAGE_URL https://github.com/jtsagata/cctheme
        DESCRIPTION "Color Scheme switcher")

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include(support/cmake/cotire.cmake)
include(support/cmake/git_revision.cmake)
include(support/cmake/CPM.cmake)

CPMAddPackage(
        NAME cxxopts
        GITHUB_REPOSITORY jarro2783/cxxopts
        SOURCE_DIR "${CMAKE_SOURCE_DIR}/ext/cxxopts"
        VERSION 2.2.0
        OPTIONS
        "CXXOPTS_BUILD_EXAMPLES Off"
        "CXXOPTS_BUILD_TESTS Off"
)

CPMAddPackage(
        NAME fmt
        GIT_TAG 5.3.0
        GITHUB_REPOSITORY fmtlib/fmt
        SOURCE_DIR "${CMAKE_SOURCE_DIR}/ext/fmt"
        OPTIONS
        "FMT_TEST Off"
        "FMT_ Off"
        "FMT_DOC Off"
)

CPMAddPackage(
        NAME inja
        VERSION 2.1.0
        GITHUB_REPOSITORY pantor/inja
        SOURCE_DIR "${CMAKE_SOURCE_DIR}/ext/inja"
        OPTIONS
        "BUILD_BENCHMARK Off"
        "BUILD_TESTING Off"
)

if (inja_ADDED)
  # add_library(inja INTERFACE )
  # target_include_directories(inja INTERFACE ${inja_SOURCE_DIR}/include/inja)
endif()


add_subdirectory(src/ccthemegen)