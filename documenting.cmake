include_guard(GLOBAL)

function(build_docs directory readme)
  set(DOXYGEN_GENERATE_HTML YES)
  set(DOXYGEN_USE_MDFILE_AS_MAINPAGE ${readme})

  find_package(Doxygen)

  if (Doxygen_FOUND)
    doxygen_add_docs(
        docs
        ${PROJECT_SOURCE_DIR}/src
        COMMENT "Generate html pages for the framework"
    )
  else()
    message("Doxygen not found!")
  endif()
endfunction()

function(build_docs_standard)
  build_docs(${PROJECT_SOURCE_DIR}/src README.md)
endfunction()
