# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.22

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/ngocdai/lidar_ws/src/xsens_library

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/ngocdai/lidar_ws/build/xsens_library

# Include any dependencies generated for this target.
include CMakeFiles/xdpchandler.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/xdpchandler.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/xdpchandler.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/xdpchandler.dir/flags.make

CMakeFiles/xdpchandler.dir/src/xdpchandler.cpp.o: CMakeFiles/xdpchandler.dir/flags.make
CMakeFiles/xdpchandler.dir/src/xdpchandler.cpp.o: /home/ngocdai/lidar_ws/src/xsens_library/src/xdpchandler.cpp
CMakeFiles/xdpchandler.dir/src/xdpchandler.cpp.o: CMakeFiles/xdpchandler.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/ngocdai/lidar_ws/build/xsens_library/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/xdpchandler.dir/src/xdpchandler.cpp.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/xdpchandler.dir/src/xdpchandler.cpp.o -MF CMakeFiles/xdpchandler.dir/src/xdpchandler.cpp.o.d -o CMakeFiles/xdpchandler.dir/src/xdpchandler.cpp.o -c /home/ngocdai/lidar_ws/src/xsens_library/src/xdpchandler.cpp

CMakeFiles/xdpchandler.dir/src/xdpchandler.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/xdpchandler.dir/src/xdpchandler.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/ngocdai/lidar_ws/src/xsens_library/src/xdpchandler.cpp > CMakeFiles/xdpchandler.dir/src/xdpchandler.cpp.i

CMakeFiles/xdpchandler.dir/src/xdpchandler.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/xdpchandler.dir/src/xdpchandler.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/ngocdai/lidar_ws/src/xsens_library/src/xdpchandler.cpp -o CMakeFiles/xdpchandler.dir/src/xdpchandler.cpp.s

# Object files for target xdpchandler
xdpchandler_OBJECTS = \
"CMakeFiles/xdpchandler.dir/src/xdpchandler.cpp.o"

# External object files for target xdpchandler
xdpchandler_EXTERNAL_OBJECTS =

libxdpchandler.a: CMakeFiles/xdpchandler.dir/src/xdpchandler.cpp.o
libxdpchandler.a: CMakeFiles/xdpchandler.dir/build.make
libxdpchandler.a: CMakeFiles/xdpchandler.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/ngocdai/lidar_ws/build/xsens_library/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX static library libxdpchandler.a"
	$(CMAKE_COMMAND) -P CMakeFiles/xdpchandler.dir/cmake_clean_target.cmake
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/xdpchandler.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/xdpchandler.dir/build: libxdpchandler.a
.PHONY : CMakeFiles/xdpchandler.dir/build

CMakeFiles/xdpchandler.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/xdpchandler.dir/cmake_clean.cmake
.PHONY : CMakeFiles/xdpchandler.dir/clean

CMakeFiles/xdpchandler.dir/depend:
	cd /home/ngocdai/lidar_ws/build/xsens_library && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/ngocdai/lidar_ws/src/xsens_library /home/ngocdai/lidar_ws/src/xsens_library /home/ngocdai/lidar_ws/build/xsens_library /home/ngocdai/lidar_ws/build/xsens_library /home/ngocdai/lidar_ws/build/xsens_library/CMakeFiles/xdpchandler.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/xdpchandler.dir/depend

