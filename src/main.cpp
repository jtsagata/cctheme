#include "config.h"
#include "utils.h"

#include <cxxopts.hpp>
#include <iostream>
#include <string>

cxxopts::ParseResult parse_args(int argc, char *argv[]);

bool do_verbose = false;
bool do_force = true;

int main(int argc, char *argv[]) {

    auto result = parse_args(argc, argv);
    auto themes = result["themes"].as<std::vector<std::string>>();

    int exit_status = EXIT_SUCCESS;
    for (auto &theme : themes) {
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
            // TODO: use {fmt}
            printf("program version: %s.%s.%s\n", PROJECT_VER_MAJOR, PROJECT_VER_MINOR,
                   PROJECT_VER_PATCH);
            printf("git hash: %s\n", GIT_REVISION);
            exit(EXIT_SUCCESS);
        }

        auto show_help = result["help"].as<bool>();
        if (show_help) {
            std::cout << options.help();
            exit(EXIT_SUCCESS);
        }

        if (!result.count("themes")) {
            std::cerr << "Error: No themes given\n";
            exit(EXIT_FAILURE);
        }

        return result;
    } catch (const cxxopts::OptionException &e) {
        std::cout << "error parsing options: " << e.what() << std::endl;
        exit(1);
    }
}
