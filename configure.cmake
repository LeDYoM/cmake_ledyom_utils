include_guard(GLOBAL)

function(prepare_cmake_presets)
    file(
        COPY cm_prj.json
        DESTINATION "${CMAKE_SOURCE_DIR}/CMakePresets.json"
        ONLY_IF_DIFFERENT)
endfunction()
