cmake_minimum_required(VERSION 3.10.0)

set(kataId kata-bowlinggame)

project(${kataId} CXX)

enable_testing()

set_property(GLOBAL PROPERTY USE_FOLDERS ON)

if (NOT TARGET gtest)
	# Download and unpack googletest at configure time
	configure_file(thirdparty.gtest.in.txt googletest-download/CMakeLists.txt)
	execute_process(COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}" .
	  RESULT_VARIABLE result
	  WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/googletest-download )
	if(result)
	  message(FATAL_ERROR "CMake step for googletest failed: ${result}")
	endif()
	execute_process(COMMAND ${CMAKE_COMMAND} --build .
	  RESULT_VARIABLE result
	  WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/googletest-download )
	if(result)
	  message(FATAL_ERROR "Build step for googletest failed: ${result}")
	endif()

	# Prevent overriding the parent project's compiler/linker
	# settings on Windows
	set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)

	# Add googletest directly to our build. This defines
	# the gtest and gtest_main targets.
	add_subdirectory(${CMAKE_CURRENT_BINARY_DIR}/googletest-src
					 ${CMAKE_CURRENT_BINARY_DIR}/googletest-build
					 EXCLUDE_FROM_ALL)

	# The gtest/gtest_main targets carry header search path
	# dependencies automatically when using CMake 2.8.11 or
	# later. Otherwise we have to add them here ourselves.
	if (CMAKE_VERSION VERSION_LESS 2.8.11)
	  include_directories("${gtest_SOURCE_DIR}/include")
	endif()

   set_property(TARGET gtest PROPERTY FOLDER "Thirdparties")
   set_property(TARGET gtest_main PROPERTY FOLDER "Thirdparties")
endif()

add_library(${kataId} SHARED)

target_compile_definitions(${kataId} PRIVATE BOWLING_GAME_EXPORTS)

target_sources(${kataId}
	PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/src/production/games/bowling/BowlingGame.cpp
    PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}/include/production/games/bowling/BowlingGame.hpp
		${CMAKE_CURRENT_SOURCE_DIR}/include/production/games/bowling/config.hpp
)

target_include_directories(${kataId}
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/src
    PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}/include
)

add_executable(${kataId}-test)

target_sources(${kataId}-test
	PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/test/BowlingGameTest.cpp
)

target_include_directories(${kataId}-test
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/test
)

target_link_libraries(${kataId}-test
    PRIVATE
	    ${kataId}
        gtest_main)
		
add_test(NAME ctest-${kataId} COMMAND ${kataId}-test)

set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT ${kataId}-test)
set_property(TARGET ${kataId} PROPERTY FOLDER "Katas")
set_property(TARGET ${kataId}-test PROPERTY FOLDER "Katas")

set_property(GLOBAL PROPERTY PREDEFINED_TARGETS_FOLDER "CMake Generated")