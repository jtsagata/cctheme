/* * ctheme - ctheme color generator and switcher
 * Copyright (C) 2019 Ioannis Tsagkatakis
 *
 * This file is part of ctheme.
 *
 * ctheme is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * ctheme is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with ctheme.  If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef CTHEMEGEN_TTY_COLORS_H
#define CTHEMEGEN_TTY_COLORS_H

#include <fmt/color.h>
#include <fmt/core.h>

#include <filesystem>
#include <set>
#include <string>
#include <unistd.h>

namespace fmt {
    template <>
    struct formatter<std::filesystem::path> : formatter<std::string> {};
} // namespace fmt

using namespace fmt::literals;

inline bool isColorTerm() {
    using stringSet = std::set<std::string>;
    static const stringSet terms = {"xterm", "xterm-256", "xterm-256color", "vt100",
                                    "color", "ansi",      "cygwin",         "linux"};

    auto term = std::getenv("TERM");
    if (term) {
        return !(terms.find(term) == terms.end());
    } else {
        return false;
    }
}

template <typename S, typename H, typename... Args>
inline void printHeader(std::FILE *f, const fmt::text_style &ts, const H &header,
                        const S &format_str, const Args &... args) {
    if (isatty(fileno(f)) && isColorTerm()) {
        fmt::print(f, ts, header);
    } else {
        fmt::print(f, header);
    }
    fmt::print(f, format_str, args...);
}

template <typename S, typename... Args>
inline void printInfo(std::FILE *f, const S &format_str, const Args &... args) {
    printHeader(f, fmt::emphasis::bold | fg(fmt::color::yellow), "Info: ", format_str, args...);
}

template <typename S, typename... Args>
void printInfo(const S &format_str, const Args &... args) {
    printInfo(stdout, format_str, args...);
}

template <typename S, typename... Args>
void printInfoVerbose(bool cond, const S &format_str, const Args &... args) {
    if (cond) printInfo(stdout, format_str, args...);
}

template <typename S, typename... Args>
inline void printError(std::FILE *f, const S &format_str, const Args &... args) {
    printHeader(f, fmt::emphasis::bold | fg(fmt::color::red), "Error: ", format_str, args...);
}

template <typename S, typename... Args>
void printError(const S &format_str, const Args &... args) {
    printError(stderr, format_str, args...);
}

#endif // CTHEMEGEN_TTY_COLORS_H
