include_guard(GLOBAL)

# File containing scripts to configure and bootstraps projects

function(prepare_cmake_presets)
    file(COPY_FILE
        ${CMAKE_CURRENT_FUNCTION_LIST_DIR}/cm_pr.json
        ${CMAKE_SOURCE_DIR}/CMakePresets.json
        ONLY_IF_DIFFERENT)
endfunction()
