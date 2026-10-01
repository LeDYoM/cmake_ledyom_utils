include_guard(GLOBAL)

macro(testing_init)
    enable_testing()
    prepareTestLibrary()
endmacro()

function (prepareTestLibrary)
    include(FetchContent)
    message(STATUS "Fetching Catch2")
    #======================================

    # Catch the previous value of BUILD_SHARED_LIBS
    # looks like it is set somewhere. Set it to off
    set(PREVIOUS_BUILD_SHARED_LIBS ${BUILD_SHARED_LIBS})
    if(BUILD_SHARED_LIBS)
      set(BUILD_SHARED_LIBS OFF)
    endif()

    set(CATCH2_COMMIT fa43b77429ba76c462b1898d6cd2f2d7a9416b14) # 3.7.1
    FetchContent_Declare(Catch2
        GIT_REPOSITORY https://github.com/catchorg/Catch2.git
        GIT_TAG ${CATCH2_COMMIT}
        CMAKE_CACHE_ARGS -DBUILD_SHARED_LIBS=OFF
    )

    FetchContent_MakeAvailable(Catch2)

    # Set the old value of BUILD_SHARED_LIBS
    set(BUILD_SHARED_LIBS ${PREVIOUS_BUILD_SHARED_LIBS})
    #======================================
    message(STATUS "Fetching Catch2 libraries done")
endfunction()

function(add_test_executable)
    cmake_parse_arguments(LC_BUILD "" "" "SOURCE_TESTS" ${ARGN})

    prepareTestLibrary()

    foreach(NAME IN LISTS LC_BUILD_SOURCE_TESTS)
      list(APPEND SOURCE_TESTS_LIST ${NAME}.test.cpp)
    endforeach()

    add_executable(${CURRENT_TARGET})
    target_sources(${CURRENT_TARGET} PRIVATE ${SOURCE_TESTS_LIST})
    target_compile_definitions(${CURRENT_TARGET} PUBLIC CATCH_CONFIG_ENABLE_BENCHMARKING)
    target_link_libraries(${CURRENT_TARGET} PUBLIC Catch2::Catch2WithMain)

    add_test(NAME ${CURRENT_TARGET} COMMAND ${CURRENT_TARGET})
endfunction()

function(addTestingDirectory dir)
  if (BUILD_TESTS)
    add_subdirectory(${dir})
  endif()
endfunction()
