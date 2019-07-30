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

#ifndef _COLORS_H_
#define _COLORS_H_

#include <cmath>
#include <cstdint>
#include <string>
#include <unordered_map>

#include <fmt/core.h>
#include <fmt/format.h>

struct rgb_color;
using named_colors_map = std::unordered_map<std::string, rgb_color>;
extern const named_colors_map named_colors;

struct rgb_color {
    uint8_t r, g, b, a;

    explicit rgb_color(uint8_t r = 0, uint8_t g = 0, uint8_t b = 0, uint8_t a = 255)
        : r(r)
        , g(g)
        , b(b)
        , a(a) {}

    explicit rgb_color(std::string spec);

    // Formatters
    std::string hexa();
    std::string hex();
    std::string rgba();
    std::string rgb();
    std::string hsl();
};

std::tuple<float, float, float> rgb_to_hsl(const rgb_color &color);
std::tuple<float, float, float> rgb_to_hsv(const rgb_color &color);

rgb_color hsl_to_rgb(float h, float s, float l);
rgb_color hsb_to_rgb(float h, float s, float v);

// Functions
// @debug mix(#036, #d2e1dd); // #698aa2
// @debug mix(#036, #d2e1dd, 75%); // #355f84
// @debug mix(#036, #d2e1dd, 25%); // #9eb6bf
// @debug mix(rgba(242, 236, 228, 0.5), #6b717f); // rgba(141, 144, 152, 0.75)
rgb_color mix(const rgb_color &c1, const rgb_color &c2, float weight = 0.5);
rgb_color adjust_hue(const rgb_color &color, float degrees);
rgb_color lighten(const rgb_color &color, float amount);
rgb_color darken(const rgb_color &color, float amount);
rgb_color saturate(const rgb_color &color, float amount);
rgb_color desaturate(const rgb_color &color, float amount);
rgb_color grayscale(const rgb_color &color);
rgb_color complement(const rgb_color &color);
rgb_color invert(const rgb_color &color);
rgb_color fade_in(const rgb_color &color, float amount);
rgb_color fade_out(const rgb_color &color, float amount);

#endif //_COLORS_H_
