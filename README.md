# Wurzelwerk

[![CI](https://github.com/vewilya/wurzelwerk/actions/workflows/ci.yml/badge.svg)](https://github.com/vewilya/wurzelwerk/actions/workflows/ci.yml)

Exercises in C: data structures, design patterns and more. Each one tested, benchmarked and documented.

## Katas

| Topic | Code |
|---|---|
| Stack | [`include/stack/stack.h`](include/stack/stack.h), [`src/stack.c`](src/stack.c) |

## Setup

```bash
# macOS
brew install cmake googletest google-benchmark llvm clang-format doxygen
# Ubuntu: see .github/workflows/ci.yml
```

## Commands

| Task | Command |
|---|---|
| Build and test (debug, sanitizers) | `cmake --preset dev && cmake --build --preset dev && ctest --preset dev` |
| Run the app | `./build/dev/wurzelwerk` |
| Benchmarks (optimized) | `cmake --preset release && cmake --build --preset release && ./build/release/stack_benchmarks` |
| Coverage report | `cmake --preset coverage && cmake --build --preset coverage --target coverage` |
| Format code | `cmake --build --preset dev --target format` |
| Docs | `cmake --build --preset dev --target docs` → `build/dev/docs/html/index.html` |
