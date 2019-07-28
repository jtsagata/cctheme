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

#include <fmt/format.h>

int main(int argc, char *argv[]) {
    auto color1 = rgb_color("#6495ED");
    auto color2 = rgb_color("CornflowerBlue");

    fmt::print("Color 1, hex: {}\n", color1.hex());
    fmt::print("Color 2, hex: {}\n", color2.hex());
}