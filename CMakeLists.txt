cmake_minimum_required(VERSION 3.1)

project(CLINGOCEXAMPLE VERSION "1.0" LANGUAGES C CXX)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Clingo REQUIRED)
add_subdirectory(src)
