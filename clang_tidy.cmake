include_guard(GLOBAL)

option(ENABLE_CLANG_TIDY "Run clang-tidy with C++ compiler" ON)

if(ENABLE_CLANG_TIDY)
    find_program(CLANG_TIDY_EXE "clang-tidy")

    if(CLANG_TIDY_EXE)
        message(STATUS "clang-tidy found: ${CLANG_TIDY_EXE}")
    else()
        message(WARNING "clang-tidy not found!")
    endif()
endif()

function(target_add_clang_tidy target options)
    if ("${options}" STREQUAL "")
        set(options -checks=*)
    endif()

    if(ENABLE_CLANG_TIDY AND CLANG_TIDY_EXE)
        set(CLANG_TIDY_COMMAND "${CLANG_TIDY_EXE} ${options}")
        message("CLANG_TIDY_COMMAND: ${CLANG_TIDY_COMMAND}")
        set_target_properties(${target} PROPERTIES CXX_CLANG_TIDY "${CLANG_TIDY_COMMAND}")
    endif()
endfunction()
