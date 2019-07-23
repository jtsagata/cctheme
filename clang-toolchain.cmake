SET(CMAKE_SYSTEM_NAME Linux)

# Specify the cross compiler.
SET(CMAKE_C_COMPILER clang CACHE STRING "C compiler" FORCE)
SET(CMAKE_CXX_COMPILER clang++ CACHE STRING "C++ compiler" FORCE)
set(CMAKE_CXX_COMPILER_LAUNCHER ccache CACHE STRING "C/C++ build cacher" FORCE)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libc++")

set(CMAKE_CXX_STANDARD 20 CACHE STRING "C++ Standard (toolchain)" FORCE)
set(CMAKE_CXX_STANDARD_REQUIRED YES CACHE BOOL "C++ Standard required" FORCE)
set(CMAKE_CXX_EXTENSIONS NO CACHE BOOL "C++ Standard extensions" FORCE)
