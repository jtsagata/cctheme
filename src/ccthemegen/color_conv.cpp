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

// https://en.wikipedia.org/wiki/HSL_and_HSV
// https://gist.github.com/marukrap/7c361f2c367eaf40537a8715e3fd952a

#include "colors.h"
#include <algorithm> // min, max
#include <tuple>

// HSL/HSV
// H Hue component, range: [0.f, 360.f)
// S Saturation component, range: [0.f, 1.f)
// L Lightness component, range: [0.f, 1.f)
// V Value component, range: [0.f, 1.f)

// rgb_color
// r Red component, range: [0, 255]
// g Green component, range: [0, 255]
// b Blue component, range: [0, 255]

std::tuple<float, float, float> rgb_to_hsl(const rgb_color &color) {
    auto r = static_cast<float>(color.r / 255.f); // NOLINT
    auto g = static_cast<float>(color.g / 255.f); // NOLINT
    auto b = static_cast<float>(color.b / 255.f); // NOLINT

    auto max = std::max({r, g, b});
    auto min = std::min({r, g, b});
    float chroma = max - min; // Chroma

    float h = 0.f; // Hue
    float s = 0.f; // Saturation
    float l = 0.f; // Lightness

    if (chroma != 0.f) {
        if (max == r) h = std::fmod(((g - b) / chroma), 6.f);
        else if (max == g)
            h = ((b - r) / chroma) + 2;
        else if (max == b)
            h = ((r - g) / chroma) + 4;

        h *= 60;
    }

    if (h < 0.f) h += 360;

    l += (max + min) / 2;

    if (l != 1.f && l != 0.f) s = chroma / (1 - std::fabs(2 * l - 1));

    return {h, s, l};
}

std::tuple<float, float, float> rgb_to_hsv(const rgb_color &color) {
    auto r = static_cast<float>(color.r / 255.f); // NOLINT
    auto g = static_cast<float>(color.g / 255.f); // NOLINT
    auto b = static_cast<float>(color.b / 255.f); // NOLINT

    auto max = std::max({r, g, b});
    auto min = std::min({r, g, b});
    auto chroma = max - min; // Chroma

    float h = 0.f; // Hue
    float s = 0.f; // Saturation
    float v;       // Value

    if (chroma != 0.f) {
        if (max == r) h = std::fmod(((g - b) / chroma), 6.f);
        else if (max == g)
            h = ((b - r) / chroma) + 2;
        else if (max == b)
            h = ((r - g) / chroma) + 4;

        h *= 60;
    }

    if (h < 0.f) h += 360;

    v = max;

    if (v != 0.f) s = chroma / v;

    return {h, s, v};
}

rgb_color hsl_to_rgb(float h, float s, float l) {
    float chroma = (1 - std::fabs(2 * l - 1)) * s; // Chroma
    float h_prime = h / 60;                        // h'
    float d = chroma * (1 - std::fabs(std::fmod(h_prime, 2.f) - 1));
    float m = l - chroma / 2;

    float r = 0.f;
    float g = 0.f;
    float b = 0.f;

    switch (static_cast<int>(h_prime)) {
    case 0:
        r = chroma;
        g = d;
        break; // [0, 1)
    case 1:
        r = d;
        g = chroma;
        break; // [1, 2)
    case 2:
        g = chroma;
        b = d;
        break; // [2, 3)
    case 3:
        g = d;
        b = chroma;
        break; // [3, 4)
    case 4:
        r = d;
        b = chroma;
        break; // [4, 5)
    case 5:
        r = chroma;
        b = d;
        break; // [5, 6)
    }

    r += m;
    g += m;
    b += m;

    rgb_color color;
    color.r = static_cast<uint8_t>(std::round(r * 255));
    color.g = static_cast<uint8_t>(std::round(g * 255));
    color.b = static_cast<uint8_t>(std::round(b * 255));

    return color;
}

rgb_color hsb_to_rgb(float h, float s, float v) {
    float chroma = s * v;                   // Chroma
    float h_prime = std::fmod(h / 60, 6.f); // h'
    float x = chroma * (1 - std::fabs(std::fmod(h_prime, 2.f) - 1));
    float m = v - chroma;

    float r = 0.f;
    float g = 0.f;
    float b = 0.f;

    switch (static_cast<int>(h_prime)) {
    case 0:
        r = chroma;
        g = x;
        break; // [0, 1)
    case 1:
        r = x;
        g = chroma;
        break; // [1, 2)
    case 2:
        g = chroma;
        b = x;
        break; // [2, 3)
    case 3:
        g = x;
        b = chroma;
        break; // [3, 4)
    case 4:
        r = x;
        b = chroma;
        break; // [4, 5)
    case 5:
        r = chroma;
        b = x;
        break; // [5, 6)
    }

    r += m;
    g += m;
    b += m;

    rgb_color color;
    color.r = static_cast<uint8_t>(std::round(r * 255)); // NOLINT
    color.g = static_cast<uint8_t>(std::round(g * 255)); // NOLINT
    color.b = static_cast<uint8_t>(std::round(b * 255)); // NOLINT

    return color;
}
