include_guard(GLOBAL)

function(set_cxx_standard current_target cxx_version)
    set_target_properties(${current_target} PROPERTIES
        CXX_STANDARD ${cxx_version}
        CXX_STANDARD_REQUIRED ON
        CXX_EXTENSIONS OFF)
    message("C++ version set to ${cxx_version}")
endfunction()

function(add_pie_if_available current_target)
    message(CHECK_START "Checking for C C++ linker PIE support")

    include(CheckPIESupported)
    check_pie_supported(OUTPUT_VARIABLE output LANGUAGES C CXX)
    set_property(TARGET ${current_target} PROPERTY POSITION_INDEPENDENT_CODE TRUE)

    if(CMAKE_C_LINK_PIE_SUPPORTED AND CMAKE_CXX_LINK_PIE_SUPPORTED)
        message(CHECK_PASS "yes")
    else()
        message(CHECK_FAIL "no")
        message("PIE is not supported at link time:\n${output}"
            "PIE link options will not be passed to linker.")
    endif()
endfunction()

function(set_strict_warnings current_target)
target_compile_options(${current_target} PRIVATE
  $<$<AND:$<CXX_COMPILER_ID:MSVC>,$<NOT:$<CONFIG:Release>>>:/Wall>
  $<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:Release>>:/W4>
  $<$<NOT:$<CXX_COMPILER_ID:MSVC>>:-Wall -Wextra -pedantic -Wno-unknown-pragmas>
)

# Avoid warnings from external includes (like STL, for example)
target_compile_options(${current_target} PRIVATE
  $<$<CXX_COMPILER_ID:MSVC>:/external:anglebrackets /external:W0>
)

set_property(TARGET ${current_target} PROPERTY COMPILE_WARNING_AS_ERROR ON)
endfunction()
