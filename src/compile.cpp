#include <filesystem>
#include <inja.hpp>
#include <rang.hpp>

#include "utils.h"

using json = nlohmann::json;
using path = std::filesystem::path;
using namespace rang;

//    path base_dir = {BASE_DIR};
//
//    inja::Environment env;
//    path json_file{"../data/schemes/SolarizedDark.json"};
//    path template_file{"../data/templates/_gnome-terminal.sh"};
//    path result_file{"../data/scripts/gnome-terminal.sh"};

//    env.write_with_json_file(template_file,json_file,result_file);

bool compile_theme(std::string theme, bool force, bool verbose) {
    path theme_path;
    if (file_exists(theme)) {
        theme_path = theme;
    } else {
        auto fname = theme + ".json";
        theme_path = path{"data/schemes/"} / fname;
        if (!file_exists(theme_path)) {
            std::cerr << style::bold << fg::red << "Error:" << style::reset << fg::reset
                      << "theme not found.\n";
            return false;
        }
    }

    {
        std::ifstream my_file(theme_path);
        if (!my_file.good()) {
            auto cannonical_path = std::filesystem::canonical(theme_path);
            std::cerr << style::bold << fg::red << "Error:" << style::reset << fg::reset << " file "
                      << cannonical_path << " is not readable.\n";
            return false;
        }
    }

    // Theme path now contains a valid json path name.
    auto stem = theme_path.stem();
    std::cout << "Compiling theme " << style::bold << fg::green << stem << style::reset << fg::reset
              << ".\n";

    auto script_path = path{"data/scripts/"} / stem;
    if (!dir_exists(script_path)) {
        std::filesystem::create_directories(script_path);
    } else {
        if (force == false) {
            std::cout << "Directory exists, skipping \n";
            return false;
        }
    }

    return true;
}
