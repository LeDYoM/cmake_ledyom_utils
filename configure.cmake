include_guard(GLOBAL)

# File containing scripts to configure and bootstraps projects

function(prepare_cmake_presets)
    file(COPY_FILE
        ${CMAKE_CURRENT_FUNCTION_LIST_DIR}/cm_pr.json
        ${CMAKE_SOURCE_DIR}/CMakePresets.json
        ONLY_IF_DIFFERENT)
endfunction()

function(prepare_format_file)
    file(COPY_FILE
        ${CMAKE_CURRENT_FUNCTION_LIST_DIR}/.clang-format
        ${CMAKE_SOURCE_DIR}/.clang-format
        ONLY_IF_DIFFERENT)
endfunction()

function(prepare_all)
    prepare_cmake_presets()
    prepare_format_file()
endfunction()
