cmake_minimum_required(VERSION 3.25)
project(wurzelwerk VERSION 0.1.0 LANGUAGES C CXX)

set(CMAKE_C_STANDARD 17)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

option(BUILD_TESTS "Build unit tests (GoogleTest)" ON)
option(BUILD_BENCHMARKS "Build benchmarks (Google Benchmark)" OFF)
option(ENABLE_SANITIZERS "Build with address and undefined-behavior sanitizers" OFF)
option(ENABLE_COVERAGE "Build with clang source-based coverage" OFF)
option(ENABLE_CLANG_TIDY "Run clang-tidy on the library and app while compiling" OFF)

include(cmake/compiler-options.cmake)

add_library(stack_lib src/stack.c)
target_include_directories(stack_lib PUBLIC include)

add_executable(wurzelwerk app/main.c)
target_link_libraries(wurzelwerk PRIVATE stack_lib)

if(ENABLE_CLANG_TIDY)
  set_target_properties(stack_lib wurzelwerk PROPERTIES
    C_CLANG_TIDY "${clang_tidy_command}"
    CXX_CLANG_TIDY "${clang_tidy_command}")
endif()

if(BUILD_TESTS)
  enable_testing()
  find_package(GTest REQUIRED)
  include(GoogleTest)
  add_executable(stack_tests tests/stack_test.cpp)
  target_link_libraries(stack_tests PRIVATE stack_lib GTest::gtest_main)
  gtest_discover_tests(stack_tests)
endif()

if(BUILD_BENCHMARKS)
  find_package(benchmark REQUIRED)
  add_executable(stack_benchmarks benchmarks/stack_benchmark.cpp)
  target_link_libraries(stack_benchmarks PRIVATE stack_lib benchmark::benchmark_main)
endif()

include(cmake/developer-targets.cmake)
