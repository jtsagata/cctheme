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
