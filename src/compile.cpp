#include <filesystem>
#include <inja.hpp>

#include "config.h"
#include "tty_colors.h"
#include "utils.h"

using json = nlohmann::json;
using path = std::filesystem::path;
using perms = std::filesystem::perms;

using std::filesystem::directory_iterator;
using std::filesystem::permissions;

bool compile_template(const path &json_file, const path &template_file, const path &theme_out_dir,
                      bool do_force, bool do_verbose);

bool compile_theme(const std::string &theme, bool do_force, bool do_verbose) {
    printInfoVerbose(do_verbose, "Compiling  theme '{theme:s}'.\n", "theme"_a = theme);

    path scheme_file_name;
    if (file_exists(theme)) {
        scheme_file_name = theme;
    } else {
        auto file_name = theme + ".json";
        scheme_file_name = path{DataSchemeDir} / file_name;
        if (!file_exists(scheme_file_name)) {
            printError("Json file '{}' the generate theme  not found.\n", scheme_file_name);
            return false;
        }
    }

    {
        std::ifstream my_file(scheme_file_name);
        if (!my_file.good()) {
            auto canonical_path = std::filesystem::canonical(scheme_file_name);
            printError("File '{path:s}' is not readable.\n", "path"_a = canonical_path);
            return false;
        }
    }

    // Theme path now contains a valid json path name.
    auto stem = scheme_file_name.stem();

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
    for (const auto &template_file : directory_iterator(templates_path)) {
        compile_template(scheme_file_name, template_file, script_path, do_force, do_verbose);
    }

    return true;
}

bool compile_template(const path &json_file, const path &template_file, const path &theme_out_dir,
                      bool do_force, bool do_verbose) {

    inja::Environment env;
    path result_file = theme_out_dir / template_file.filename();
    env.write_with_json_file(template_file, json_file, result_file);

    // Make it executable
    if (result_file.has_extension() && result_file.extension() == ".sh") {
        permissions(result_file, perms::owner_all | perms::others_exec);
    }

    printInfoVerbose(do_verbose, "Processing template '{}' -> '{}'\n", template_file, result_file);

    return true;
}
