#ifndef _COLORS_H_
#define _COLORS_H_

#include <cstdint>
#include <string>
#include <unordered_map>

#include <fmt/core.h>
#include <fmt/format.h>

struct rgb_color;
using named_colors_map = std::unordered_map<std::string, rgb_color>;
extern const named_colors_map named_colors;

struct rgb_color {
    uint8_t R, G, B, A;

    explicit rgb_color(uint8_t r = 0, uint8_t g = 0, uint8_t b = 0, uint8_t a = 255)
        : R(r)
        , G(g)
        , B(b)
        , A(a) {}

    explicit rgb_color(std::string spec);
    // Formaters
    std::string hex();
};

#endif //_COLORS_H_
