#include "colors.h"

std::string rgb_color::hex() { return fmt::format("rgba #{:02X}{:02X}{:02X}{:02X}", R, G, B, A); }

rgb_color::rgb_color(std::string spec) {

    std::for_each(spec.begin(), spec.end(),
                  [](char &c) { c = ::tolower(static_cast<unsigned char>(c)); });

    R = 0, G = 0, B = 0, A = 255;
    if (spec.length() == 7 && spec.starts_with('#')) {
        int r, g, b;
        sscanf(spec.c_str() + 1, "%02x%02x%02x", &r, &g, &b);
        R = r, G = g, B = b, A = 255;
        return;
    }

    auto it = named_colors.find(spec);
    if (it != named_colors.end()) {
        R = it->second.R;
        G = it->second.G;
        B = it->second.B;
        A = it->second.A;
    }
}
