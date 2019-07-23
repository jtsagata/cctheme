#include "utils.h"
#include <filesystem>
#include <iostream>

namespace filesys = std::filesystem;

bool file_exists(std::string filePath) {
    try {
        filesys::path pathObj(filePath);
        if (filesys::exists(pathObj) && filesys::is_regular_file(pathObj)) return true;
    } catch (filesys::filesystem_error &e) {
        std::cerr << e.what() << std::endl;
    }
    return false;
}

bool dir_exists(std::string filePath) {
    try {
        // Create a Path object from given path string
        filesys::path pathObj(filePath);
        // Check if path exists and is of a directory file
        if (filesys::exists(pathObj) && filesys::is_directory(pathObj))
            return true;
    }
    catch (filesys::filesystem_error & e)
    {
        std::cerr << e.what() << std::endl;
    }
    return false;
}
