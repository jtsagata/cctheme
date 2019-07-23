#include "config.h"
#include "utils.h"

#include <cxxopts.hpp>
#include <filesystem>
#include <fmt/core.h>
#include <string>

cxxopts::ParseResult parse_args(int argc, char *argv[]);

bool do_verbose = false;
bool do_force = true;
bool do_all = false;

int main(int argc, char *argv[]) {

    auto result = parse_args(argc, argv);
    std::vector<std::string> themes;

    if (!do_all) {
        themes = result["themes"].as<std::vector<std::string>>();
    } else {
        using path = std::filesystem::path;
        using std::filesystem::directory_iterator;
        auto theme_path = path{"data/schemes/"};
        for (const auto &entry : directory_iterator(theme_path)) {
            auto extension = entry.path().extension();
            if (extension == ".json") {
                auto stem = entry.path().stem();
                themes.push_back(stem);
            }
        }
    }

    int exit_status = EXIT_SUCCESS;
    for (auto &theme : themes) {
        fmt::print("{}", theme);
        auto res = compile_theme(theme, do_force, do_verbose);
        if (res != 0) {
            exit_status = res;
        }
    }
    return exit_status;
}

cxxopts::ParseResult parse_args(int argc, char *argv[]) {
    try {
        cxxopts::Options options(PROJECT_NAME, PROJECT_DESCRIPTION);

        options.add_options()("a,all", "Compile all schemes", cxxopts::value(do_all));
        options.add_options()("f,force", "Force generation", cxxopts::value(do_force));
        options.add_options()("d,debug", "Verbose output", cxxopts::value(do_verbose));
        options.add_options()("v,version", "Show program version");
        options.add_options()("h,help", "Show program help");
        options.add_options()("t,themes", "themes to compile",
                              cxxopts::value<std::vector<std::string>>());

        options.parse_positional({"themes"});
        options.positional_help("theme ...");
        auto result = options.parse(argc, argv);

        auto show_version = result["version"].as<bool>();
        if (show_version) {
            fmt::print("{} - {}\n", PROJECT_NAME, PROJECT_DESCRIPTION);
            fmt::print("Program version {}.{}.{}.\ngit hash '{}'.\n", PROJECT_VER_MAJOR,
                       PROJECT_VER_MINOR, PROJECT_VER_PATCH, GIT_REVISION);
            exit(EXIT_SUCCESS);
        }

        auto show_help = result["help"].as<bool>();
        if (show_help) {
            fmt::print(options.help());
            exit(EXIT_SUCCESS);
        }

        if (!result.count("themes") && (do_all == false)) {
            fmt::print(stderr, "Error: No themes given\n");
            exit(EXIT_FAILURE);
        }

        return result;
    } catch (const cxxopts::OptionException &e) {
        fmt::print(stderr, "Error parsing options: {}.\n", e.what());
        exit(EXIT_FAILURE);
    }
}
