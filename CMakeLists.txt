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
        DOWNLOAD_ONLY True
)

if(cxxopts_ADDED)
    add_library(cxxopts INTERFACE IMPORTED)
    target_include_directories(cxxopts INTERFACE "${cxxopts_SOURCE_DIR}/include")
endif()


CPMAddPackage(
        NAME fmt
        GIT_TAG 5.3.0
        GITHUB_REPOSITORY fmtlib/fmt
        SOURCE_DIR "${CMAKE_SOURCE_DIR}/ext/fmt"
        OPTIONS
        "FMT_TEST Off"
        "FMT_DOC Off"
)


CPMAddPackage(
        NAME inja
        VERSION 2.1.0
        GITHUB_REPOSITORY pantor/inja
        SOURCE_DIR "${CMAKE_SOURCE_DIR}/ext/inja"
        DOWNLOAD_ONLY True
)

if(inja_ADDED)
    add_library(inja INTERFACE IMPORTED)
    target_include_directories(inja INTERFACE "${inja_SOURCE_DIR}/include")
endif()

CPMAddPackage(
        NAME range-v3
        GITHUB_REPOSITORY ericniebler/range-v3
        GIT_TAG origin/master
        SOURCE_DIR "${CMAKE_SOURCE_DIR}/ext/ranges"
        DOWNLOAD_ONLY True
)

if(range-v3_ADDED)
    add_library(range-v3 INTERFACE IMPORTED)
    target_include_directories(range-v3 INTERFACE "${range-v3_SOURCE_DIR}/include")
endif()

CPMAddPackage(
        NAME nlohmann_json
        VERSION 3.6.1
        SOURCE_DIR "${CMAKE_SOURCE_DIR}/ext/nlohmann"
        # not using the repo as it takes forever to clone
        URL https://github.com/nlohmann/json/releases/download/v3.6.1/include.zip
        URL_HASH SHA256=69cc88207ce91347ea530b227ff0776db82dcb8de6704e1a3d74f4841bc651cf
)

if(nlohmann_json_ADDED)
    add_library(nlohmann_json INTERFACE)
    target_include_directories(nlohmann_json INTERFACE ${nlohmann_json_SOURCE_DIR})
endif()

CPMAddPackage(
        NAME Catch2
        GITHUB_REPOSITORY catchorg/Catch2
        VERSION 2.5.0
        SOURCE_DIR "${CMAKE_SOURCE_DIR}/ext/catch2"
)

add_subdirectory(src/ccthemegen)