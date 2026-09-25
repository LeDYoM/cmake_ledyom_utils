include_guard(GLOBAL)

# Create a target to generate Doxygen documentation for the code
# param target: Base name for the target. "_docs" will be appended
# param source_dir: Directory where the source code is
# param readme: Readme file
function(build_docs target source_dir readme)
  set(DOXYGEN_GENERATE_HTML YES)
  set(DOXYGEN_USE_MDFILE_AS_MAINPAGE ${readme})

  message(DEBUG
    "build_docs. target: ${target}, directory: ${source_dir}, readme: ${readme}")

  find_package(Doxygen)

  if(Doxygen_FOUND)
    doxygen_add_docs(
      ${target}
      ${PROJECT_SOURCE_DIR}/src
      ${readme}
      COMMENT "Generate html pages for the framework"
    )
  else()
    message(WARNING "Doxygen not found!")
  endif()
endfunction()

# Create a target to generate Doxygen documentation for the code
# param target: Name for the target.
# source_dir: Directory where the source files are located
function(build_docs_standard_source target source_dir)
  build_docs(${target} ${source_dir} README.md)
endfunction()

# Create a target to generate Doxygen documentation for the code
# Use standard defaults
# param target: Base name for the target. "_docs" will be appended
function(build_docs_standard target)
  build_docs_standard_source(${target}_docs src README.md)
endfunction()
