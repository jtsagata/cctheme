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
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with ctheme.  If not, see <http://www.gnu.org/licenses/>.
//

#include "colors.h"
#include <cstddef>
#include <fmt/format.h>
#include <string>

std::string svg_rect_helper(int number, const std::string &color) { // TODO: Convert to function
    auto col = (number - 1) % 4;
    uint8_t row = (number - 1) / 4;

    static const int height = 60;
    static const int width = 80;
    static const int gap = 6;
    static const int underline = 6;
    static const int top = 80;

    auto box = fmt::format(
        R"lit(<rect id="#box-{id}" x="{x_coord}" y="{y_coord}"  width="{width}" height="{height}" fill= "{fill}" stroke="{stroke}" stroke-width="1px" />)lit",
        fmt::arg("id", number), fmt::arg("width", width - gap), fmt::arg("height", height - gap),
        fmt::arg("fill", color), fmt::arg("stroke", color), fmt::arg("x_coord", 5 + row * width),
        fmt::arg("y_coord", top + 5 + col * height));

    auto underline_color = darken(rgb_color(color), 0.1).hex();
    auto box_2_y_coord = top + 5 + col * height - underline - gap + height;
    auto box_2 = fmt::format(
        R"lit(<rect id="#box-{id}" x="{x_coord}" y="{y_coord}"  width="{width}" height="{height}" fill= "{fill}" stroke="{stroke}" stroke-width="1px" />)lit",
        fmt::arg("id", number), fmt::arg("width", width - gap), fmt::arg("height", underline),
        fmt::arg("fill", underline_color), fmt::arg("stroke", underline_color),
        fmt::arg("x_coord", 5 + row * width), fmt::arg("y_coord", box_2_y_coord));

    auto name = fmt::format(
        R"(<text id="#box-text-{id}" x="{x_coord}" y="{y_coord}" fill="{color}" font-size="12" font-family="{family}">{text}</text>)",
        fmt::arg("text", color), fmt::arg("family", "Droid Sans Mono, Times, serif"),
        fmt::arg("color", complement(rgb_color(color)).hex()), fmt::arg("id", number),
        fmt::arg("x_coord", 15 + row * width),
        fmt::arg("y_coord", top + height - 14 + col * height));

    auto name_2 = fmt::format(
        R"(<text id="#box-text-{id}" x="{x_coord}" y="{y_coord}" fill="{color}" font-size="18" font-family="{family}">{text}</text>)",
        fmt::arg("text", number), fmt::arg("family", "Droid Sans Mono, Times, serif"),
        fmt::arg("color", complement(rgb_color(color)).hex()), fmt::arg("id", number),
        fmt::arg("x_coord", 35 + row * width),
        fmt::arg("y_coord", top + height - 32 + col * height));

    auto res = fmt::format("{}{}{}{}", box, box_2, name, name_2);
    return res;
}
