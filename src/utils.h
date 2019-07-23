#ifndef INCLUDE_GUARD_UTILS_H
#define INCLUDE_GUARD_UTILS_H

#include <string>

bool file_exists(std::string filePath);
bool dir_exists(std::string filePath);

bool compile_theme(std::string theme, bool force=true, bool verbose=true);


#endif // INCLUDE_GUARD_