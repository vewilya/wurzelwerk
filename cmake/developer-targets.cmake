find_package(Doxygen)
if(DOXYGEN_FOUND)
  set(DOXYGEN_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/docs")
  set(DOXYGEN_USE_MDFILE_AS_MAINPAGE "${PROJECT_SOURCE_DIR}/README.md")
  set(DOXYGEN_EXTRACT_ALL YES)
  doxygen_add_docs(docs include src README.md
    WORKING_DIRECTORY "${PROJECT_SOURCE_DIR}")
endif()

find_program(CLANG_FORMAT_EXE clang-format)
if(CLANG_FORMAT_EXE)
  file(GLOB_RECURSE formattable_files CONFIGURE_DEPENDS
    "${PROJECT_SOURCE_DIR}/include/*.[ch]*"
    "${PROJECT_SOURCE_DIR}/src/*.[ch]*"
    "${PROJECT_SOURCE_DIR}/app/*.[ch]*"
    "${PROJECT_SOURCE_DIR}/tests/*.[ch]*"
    "${PROJECT_SOURCE_DIR}/benchmarks/*.[ch]*")
  add_custom_target(format
    COMMAND "${CLANG_FORMAT_EXE}" -i ${formattable_files})
  add_custom_target(format-check
    COMMAND "${CLANG_FORMAT_EXE}" --dry-run --Werror ${formattable_files})
endif()

if(ENABLE_COVERAGE AND BUILD_TESTS)
  if(APPLE)
    set(llvm_tool_prefix xcrun)
  endif()
  set(raw_profile "${CMAKE_BINARY_DIR}/coverage.profraw")
  set(merged_profile "${CMAKE_BINARY_DIR}/coverage.profdata")
  set(covered_sources "${PROJECT_SOURCE_DIR}/src" "${PROJECT_SOURCE_DIR}/include")
  add_custom_target(coverage
    COMMAND ${CMAKE_COMMAND} -E env "LLVM_PROFILE_FILE=${raw_profile}" $<TARGET_FILE:stack_tests>
    COMMAND ${llvm_tool_prefix} llvm-profdata merge -sparse "${raw_profile}" -o "${merged_profile}"
    COMMAND ${llvm_tool_prefix} llvm-cov report $<TARGET_FILE:stack_tests>
      "-instr-profile=${merged_profile}" ${covered_sources}
    COMMAND ${llvm_tool_prefix} llvm-cov show $<TARGET_FILE:stack_tests>
      "-instr-profile=${merged_profile}" -format=html
      "-output-dir=${CMAKE_BINARY_DIR}/coverage-html" ${covered_sources}
    VERBATIM)
  add_dependencies(coverage stack_tests)
endif()
