#include "stdafx.h"
using json = nlohmann::json;

using namespace inja;
using json = nlohmann::json;

int main() {
    json data;
    data["name"] = "world";

    render("Hello {{ name }}!", data); // Returns std::string "Hello world!"
    render_to(std::cout, "Hello {{ name }}!", data); // Prints "Hello world!"    return 0;
}