#include <filesystem>
#include <inja.hpp>

#include "config.h"
#include "tty_colors.h"
#include "utils.h"

using json = nlohmann::json;
using path = std::filesystem::path;
using std::filesystem::directory_iterator;

//    path base_dir = {BASE_DIR};
//
//    inja::Environment env;
//    path json_file{"../data/schemes/Solarized.dark.json"};
//    path template_file{"../data/templates/_gnome-terminal.sh"};
//    path result_file{"../data/scripts/gnome-terminal.sh"};

//    env.write_with_json_file(template_file,json_file,result_file);

bool compile_theme(const std::string &theme, bool do_force, bool do_verbose) {
    printInfoVerbose(do_verbose, "Compiling  theme '{theme:s}'.\n", "theme"_a = theme);

    path schemeFileName;
    if (file_exists(theme)) {
        schemeFileName = theme;
    } else {
        auto fName = theme + ".json";
        schemeFileName = path{DataSchemeDir} / fName;
        if (!file_exists(schemeFileName)) {
            printError("Json file '{}' the generate theme  not found.\n", schemeFileName);
            return false;
        }
    }

    {
        std::ifstream my_file(schemeFileName);
        if (!my_file.good()) {
            auto canonicalPath = std::filesystem::canonical(schemeFileName);
            printError("File '{path:s}' is not readable.\n", "path"_a = canonicalPath);
            return false;
        }
    }

    // Theme path now contains a valid json path name.
    auto stem = schemeFileName.stem();

    auto script_path = path{ThemePathDir} / stem;
    if (!dir_exists(script_path)) {
        std::filesystem::create_directories(script_path);
    } else {
        if (!do_force) {
            printInfoVerbose(do_verbose, "Directory '{dir:s}' exists, skipping \n",
                             "dir"_a = script_path);
            return false;
        }
    }

    // Theme directory now exist
    auto templates_path = path{DataTemplatesDir};

    return true;
}

// using path = std::filesystem::path;
// using std::filesystem::directory_iterator;
// auto theme_path = path{DataSchemeDir};
// for (const auto &entry : directory_iterator(theme_path)) {
// auto extension = entry.path().extension();
// if (extension == ".json") {
// auto stem = entry.path().stem();
// themes.push_back(stem);
//}
//}