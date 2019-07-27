#ifndef _UTILS_H_
#define _UTILS_H_

#include <cstdlib>
#include <fmt/color.h>
#include <fmt/core.h>
#include <fmt/format.h>
#include <iostream>
#include <string>

bool file_exists(const std::string &file_path);
bool dir_exists(const std::string &file_path);

bool compile_theme(const std::string &theme, bool do_force = true, bool do_verbose = true);

#endif // INCLUDE_GUARD_