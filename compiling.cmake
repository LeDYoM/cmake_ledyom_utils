include_guard(GLOBAL)

# Set properties related to C++ standard. Basically, the version required.
# param current_target: the target to apply the properties to
# param cxx_version: the C++ version to set. Must be supported by the compiler
function(set_cxx_standard targets cxx_version)
    set_target_properties(${targets} PROPERTIES
        CXX_STANDARD ${cxx_version}
        CXX_STANDARD_REQUIRED ON
        CXX_EXTENSIONS OFF)
    message(DEBUG "C++ version for ${target} set to ${cxx_version}")
endfunction()

# Set the target as position independent code. It should be done for at least
# all libraries.
# param current_target: the target to apply the properties to
function(add_pie_if_available current_target)
    set_property(TARGET ${current_target} PROPERTY POSITION_INDEPENDENT_CODE TRUE)

    include(CheckPIESupported)
    check_pie_supported(OUTPUT_VARIABLE output LANGUAGES CXX)

    if(CMAKE_C_LINK_PIE_SUPPORTED AND CMAKE_CXX_LINK_PIE_SUPPORTED)
        message(DEBUG "PIE linker support")
    else()
        message(DEBUG "no PIE linker support: PIE not supported at"
            "link time: ${output}")
    endif()
endfunction()

# Set higher possible warning level for a compiler and set warnings as erros
# if possible.
# param current_target: the target to apply the properties to
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

# Shortcut to set the cxx standard, pie and strict warnings in one go
# param current_target: the target to apply the properties to
# param cxx_version: the C++ version to set. Must be supported by the compiler
function(set_my_standards_cxx_options targets version)
    foreach(target ${targets})
        set_cxx_standard(${target} ${version})
        add_pie_if_available(${target})
        set_strict_warnings(${target})
    endforeach()
endfunction()
