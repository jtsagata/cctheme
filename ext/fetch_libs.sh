#!/usr/bin/env bash
dir=$(dirname "$0")

curl -Ls https://github.com/pantor/inja/releases/download/v2.1.0/inja.hpp    -o "${dir}/inja.hpp"
curl -Ls https://github.com/nlohmann/json/releases/download/v3.6.1/json.hpp  -o "${dir}/json.hpp"

sed  -i "s|#include <nlohmann/json.hpp>|#include <json.hpp>|g" "${dir}/inja.hpp"

curl -Ls https://raw.githubusercontent.com/sakra/cotire/master/CMake/cotire.cmake -o "${dir}/cotire.cmake"