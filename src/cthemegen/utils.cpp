//
// ctheme - ctheme color generator and switcher
// Copyright (C) 2019 Ioannis Tsagkatakis
//
// This file is part of ctheme.
//
// ctheme is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
//
// ctheme is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with ctheme.  If not, see <http://www.gnu.org/licenses/>.
//

#include <filesystem>
#include <iostream>
#include <set>
#include <unistd.h>

#include "utils.h"

namespace filesys = std::filesystem;

bool file_exists(const std::string &file_path) {
    try {
        filesys::path path_obj(file_path);
        if (filesys::exists(path_obj) && filesys::is_regular_file(path_obj)) return true;
    } catch (filesys::filesystem_error &e) {
        std::cerr << e.what() << std::endl;
    }
    return false;
}

bool dir_exists(const std::string &file_path) {
    try {
        // Create a Path object from given path string
        filesys::path path_obj(file_path);
        // Check if path exists and is of a directory file
        if (filesys::exists(path_obj) && filesys::is_directory(path_obj)) return true;
    } catch (filesys::filesystem_error &e) {
        std::cerr << e.what() << std::endl;
    }
    return false;
}
