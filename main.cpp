#include <iostream>
#include <inja.hpp>
using json = nlohmann::json;

int main() {
    json data;
    data["color"] = "#FA00DD";

    inja::render_to(std::cout, "HTML name  {{ color }}", data); // Prints "Hello world!"    return 0;
}