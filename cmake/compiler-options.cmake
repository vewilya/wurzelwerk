add_compile_options(-Wall -Wextra -Wpedantic)

if(ENABLE_SANITIZERS)
  add_compile_options(-fsanitize=address,undefined -fno-omit-frame-pointer)
  add_link_options(-fsanitize=address,undefined)
endif()

if(ENABLE_COVERAGE)
  if(NOT CMAKE_CXX_COMPILER_ID MATCHES "Clang")
    message(FATAL_ERROR "Coverage needs clang (the default compiler on macOS).")
  endif()
  add_compile_options(-fprofile-instr-generate -fcoverage-mapping)
  add_link_options(-fprofile-instr-generate)
endif()

if(ENABLE_CLANG_TIDY)
  find_program(CLANG_TIDY_EXE clang-tidy
    HINTS /opt/homebrew/opt/llvm/bin /usr/local/opt/llvm/bin
    REQUIRED)
  set(clang_tidy_command "${CLANG_TIDY_EXE}")
  if(APPLE)
    execute_process(COMMAND xcrun --show-sdk-path
      OUTPUT_VARIABLE macos_sdk_path
      OUTPUT_STRIP_TRAILING_WHITESPACE)
    list(APPEND clang_tidy_command "--extra-arg=-isysroot${macos_sdk_path}")
  endif()
endif()
