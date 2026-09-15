include_guard(GLOBAL)

function(build_docs target_list)
  set(DOXYGEN_GENERATE_HTML YES)
#  set(DOXYGEN_EXCLUDE build;tests)
  set(DOXYGEN_EXCLUDE_PATTERNS
    */.git/*
    */build/*
  */tests/*)
  set(DOXYGEN_USE_MDFILE_AS_MAINPAGE README.md)

  find_package(Doxygen)

  if (Doxygen_FOUND)
    doxygen_add_docs(
        docs
        ${PROJECT_SOURCE_DIR}/src
        README.md
        COMMENT "Generate html pages for the framework"
    )
  else()
    message("Doxygen not found!")
  endif()
endfunction()
