# Wurzelwerk

## Setup (once)

```bash
brew install cmake googletest google-benchmark llvm clang-format doxygen
```

## Daily commands

| Task | Command |
|---|---|
| Build and test (debug, sanitizers) | `cmake --preset dev && cmake --build --preset dev && ctest --preset dev` |
| Run the app | `./build/dev/wurzelwerk` |
| Run benchmarks (optimized) | `cmake --preset release && cmake --build --preset release && ./build/release/stack_benchmarks` |
| Coverage report | `cmake --preset coverage && cmake --build --preset coverage --target coverage` |
| Format code | `cmake --build --preset dev --target format` |
| Build docs | `cmake --build --preset dev --target docs`, then open `build/dev/docs/html/index.html` |
