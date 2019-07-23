#include <filesystem>
#include <inja.hpp>
#include <rang.hpp>

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

void compile_theme(std::string theme) {
    std::cout << "Compiling theme " << style::bold << fg::green << theme << style::reset
              << fg::reset <<  ".\n";
}
