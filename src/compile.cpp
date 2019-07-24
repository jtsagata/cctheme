#include <filesystem>
#include <inja.hpp>

#include "tty_colors.h"
#include "utils.h"

using json = nlohmann::json;
using path = std::filesystem::path;

//    path base_dir = {BASE_DIR};
//
//    inja::Environment env;
//    path json_file{"../data/schemes/SolarizedDark.json"};
//    path template_file{"../data/templates/_gnome-terminal.sh"};
//    path result_file{"../data/scripts/gnome-terminal.sh"};

//    env.write_with_json_file(template_file,json_file,result_file);

bool compile_theme(const std::string &theme, bool do_force, bool do_verbose) {
    path theme_path;
    if (file_exists(theme)) {
        theme_path = theme;
    } else {
        auto fName = theme + ".json";
        theme_path = path{"data/schemes/"} / fName;
        if (!file_exists(theme_path)) {
            printError("Theme not found.");
            return false;
        }
    }

    {
        std::ifstream my_file(theme_path);
        if (!my_file.good()) {
            auto canonicalPath = std::filesystem::canonical(theme_path);
            printError("file '{}' is not readable.{}\n", canonicalPath.c_str());
            return false;
        }
    }

    // Theme path now contains a valid json path name.
    auto stem = theme_path.stem();

    auto script_path = path{"data/scripts/"} / stem;
    if (!dir_exists(script_path)) {
        std::filesystem::create_directories(script_path);
    } else {
        if (!do_force) {
            printInfoVerbose(do_verbose, "Directory '{}' exists, skipping \n", script_path.c_str());
            return false;
        }
    }

    return true;
}
