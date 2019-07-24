#ifndef INCLUDE_GUARD_UTILS_H
#define INCLUDE_GUARD_UTILS_H

#include <cstdlib>
#include <fmt/color.h>
#include <fmt/core.h>
#include <fmt/format.h>
#include <iostream>
#include <string>

bool file_exists(const std::string &filePath);
bool dir_exists(const std::string &filePath);

bool compile_theme(const std::string &theme, bool do_force = true, bool do_verbose = true);

#endif // INCLUDE_GUARD_