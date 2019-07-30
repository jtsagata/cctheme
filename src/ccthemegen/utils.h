/* * ctheme - ctheme color generator and switcher
 * Copyright (C) 2019 Ioannis Tsagkatakis
 *
 * This file is part of ctheme.
 *
 * ctheme is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * ctheme is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with ctheme.  If not, see <http://www.gnu.org/licenses/>.
 */

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