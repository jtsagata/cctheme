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

void debug_print(rgb_color &color, const std::string &name = "var") {
    fmt::print("{}, hex: {}, {}, {}\n", name, color.hex(), color.rgba(), color.hsl());
}

int main(int argc, char *argv[]) {
    auto color1 = rgb_color("#6495ED");
    debug_print(color1, "#6495ED");
    auto color2 = rgb_color("CornflowerBlue");
    auto color3 = rgb_color(100, 60, 10, 10);

    fmt::print("Color 1, hex: {}, {}\n", color1.hex(), color1.rgba());
    fmt::print("Color 2, hex: {}, {}\n", color2.hex(), color2.rgba());
    debug_print(color3, "Color 3");

    // @debug mix(#036, #d2e1dd); // #698aa2
    // @debug mix(#036, #d2e1dd, 75%); // #355f84
    // @debug mix(#036, #d2e1dd, 25%); // #9eb6bf
    // @debug mix(rgba(242, 236, 228, 0.5), #6b717f); // rgba(141, 144, 152, 0.75)
    auto mix1 = mix(rgb_color("#003366"), rgb_color("#d2e1dd"));
    fmt::print("Mix1, hex: {}, {}\n", mix1.hex(), mix1.rgba());
    assert(mix1.hex() == "#698AA2FF");

    // Hue 222deg becomes 282deg.
    //@debug adjust-hue(#6b717f, 60deg); // #796b7f
    // Hue 164deg becomes 104deg.
    //@debug adjust-hue(#d2e1dd, -60deg); // #d6e1d2
    // Hue 210deg becomes 255deg.
    //@debug adjust-hue(#036, 45); // #1a0066
    auto c = rgb_color("#6B717F");
    auto adhue = adjust_hue(c, 60);
    debug_print(c, "adhue-before #6b717f");
    debug_print(adhue, "adhue-after");
    assert(adhue.hex() == "#796B7FFF");
}
