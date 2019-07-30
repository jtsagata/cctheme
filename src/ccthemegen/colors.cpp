//
// ctheme - ctheme color generator and switcher
// Copyright (C) 2019 Ioannis Tsagkatakis
//
// This file is part of ctheme.
//
// ctheme is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
//
// ctheme is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR AS PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with ctheme.  If not, see <http://www.gnu.org/licenses/>.
//

#include "colors.h"

template <typename T>
T absmod(const T &n, const T &r) {
    T m = std::fmod(n, r);
    if (m < 0.0) m += r;
    return m;
}

template <typename T>
T clip(const T &n, const T &lower, const T &upper) {
    return std::max(lower, std::min(n, upper));
}

std::string rgb_color::hex() { return fmt::format("#{:02X}{:02X}{:02X}{:02X}", r, g, b, a); }
std::string rgb_color::rgba() { return fmt::format("rgba({},{},{},{})", r, g, b, a); }
std::string rgb_color::hsl() {
    auto hsl = rgb_to_hsl(rgb_color{r, g, b});
    float h = std::get<0>(hsl);
    float s = std::get<1>(hsl);
    float l = std::get<2>(hsl);

    return fmt::format("hsl({:03.2f},{:03.2f},{:03.2f})", h, s, l);
}

rgb_color::rgb_color(std::string spec) {

    std::for_each(spec.begin(), spec.end(),
                  [](char &c) { c = ::tolower(static_cast<unsigned char>(c)); });

    r = 0, g = 0, b = 0, a = 255;
    if (spec.length() == 7 && spec.starts_with('#')) {
        int r_new, g_new, b_new;
        sscanf(spec.c_str() + 1, "%02x%02x%02x", &r_new, &g_new, &b_new);
        r = r_new, g = g_new, b = b_new, a = 255;
        return;
    }

    auto it = named_colors.find(spec);
    if (it != named_colors.end()) {
        r = it->second.r;
        g = it->second.g;
        b = it->second.b;
        a = it->second.a;
    }
}

rgb_color mix(const rgb_color &c1, const rgb_color &c2, float weight) {
    double w = 2 * weight - 1;
    double a = c1.a - c2.a;
    double w1 = (((w * a == -1) ? w : (w + a) / (1 + w * a)) + 1) / 2.0;
    double w2 = 1 - w1;

    return rgb_color{
        static_cast<uint8_t>(std::round(w1 * c1.r + w2 * c2.r)),
        static_cast<uint8_t>(std::round(w1 * c1.g + w2 * c2.g)),
        static_cast<uint8_t>(std::round(w1 * c1.b + w2 * c2.b)),
        static_cast<uint8_t>(std::round(weight * c1.a + (1 - weight) * c2.a)),
    };
}

rgb_color adjust_hue(const rgb_color &color, float degrees) {
    auto hsl = rgb_to_hsl(color);
    float h = std::get<0>(hsl);
    float s = std::get<1>(hsl);
    float l = std::get<2>(hsl);
    auto h2 = absmod(h + degrees, 360.0f);
    return hsl_to_rgb(h2, s, l);
}

rgb_color lighten(const rgb_color &color, float amount) {
    auto hsl = rgb_to_hsl(color);
    float h = std::get<0>(hsl);
    float s = std::get<1>(hsl);
    float l = std::get<2>(hsl);
    auto l2 = clip(l + amount, 0.0f, 100.0f);
    return hsl_to_rgb(h, s, l2);
}

rgb_color darken(const rgb_color &color, float amount) {
    auto hsl = rgb_to_hsl(color);
    float h = std::get<0>(hsl);
    float s = std::get<1>(hsl);
    float l = std::get<2>(hsl);
    auto l2 = clip(l - amount, 0.0f, 100.0f);
    return hsl_to_rgb(h, s, l2);
}

rgb_color saturate(const rgb_color &color, float amount) {
    auto hsl = rgb_to_hsl(color);
    float h = std::get<0>(hsl);
    float s = std::get<1>(hsl);
    float l = std::get<2>(hsl);
    auto s2 = clip(l + amount, 0.0f, 100.0f);
    return hsl_to_rgb(h, s2, l);
}

rgb_color desaturate(const rgb_color &color, float amount) {
    auto hsl = rgb_to_hsl(color);
    float h = std::get<0>(hsl);
    float s = std::get<1>(hsl);
    float l = std::get<2>(hsl);
    auto s2 = clip(l - amount, 0.0f, 100.0f);
    return hsl_to_rgb(h, s2, l);
}

rgb_color grayscale(const rgb_color &color) {
    auto hsl = rgb_to_hsl(color);
    float h = std::get<0>(hsl);
    float s = std::get<1>(hsl);
    float l = std::get<2>(hsl);
    return hsl_to_rgb(h, 0, l);
}

rgb_color complement(const rgb_color &color) {
    auto hsl = rgb_to_hsl(color);
    float h = std::get<0>(hsl);
    float s = std::get<1>(hsl);
    float l = std::get<2>(hsl);
    auto h2 = absmod(h - 180.0f, 360.0f);
    return hsl_to_rgb(h2, s, l);
}

rgb_color invert(const rgb_color &color) {
    return rgb_color(clip(255.0f - color.r, 0.0f, 255.0f), clip(255.0f - color.g, 0.0f, 255.0f),
                     clip(255.0f - color.b, 0.0f, 255.0f));
}

rgb_color fade_in(const rgb_color &color, float amount) {
    return rgb_color(color.r, color.g, color.b, clip(color.a + amount, 0.0f, 1.0f));
}

rgb_color fade_out(const rgb_color &color, float amount) {
    return rgb_color(color.r, color.g, color.b, clip(color.a - amount, 0.0f, 1.0f));
}