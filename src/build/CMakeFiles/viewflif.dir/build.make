# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.10

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
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
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/turpentine/Documents/sources/FLIF/src

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/turpentine/Documents/sources/FLIF/src/build

# Include any dependencies generated for this target.
include CMakeFiles/viewflif.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/viewflif.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/viewflif.dir/flags.make

CMakeFiles/viewflif.dir/viewflif.c.o: CMakeFiles/viewflif.dir/flags.make
CMakeFiles/viewflif.dir/viewflif.c.o: ../viewflif.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/turpentine/Documents/sources/FLIF/src/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/viewflif.dir/viewflif.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/viewflif.dir/viewflif.c.o   -c /home/turpentine/Documents/sources/FLIF/src/viewflif.c

CMakeFiles/viewflif.dir/viewflif.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/viewflif.dir/viewflif.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/turpentine/Documents/sources/FLIF/src/viewflif.c > CMakeFiles/viewflif.dir/viewflif.c.i

CMakeFiles/viewflif.dir/viewflif.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/viewflif.dir/viewflif.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/turpentine/Documents/sources/FLIF/src/viewflif.c -o CMakeFiles/viewflif.dir/viewflif.c.s

CMakeFiles/viewflif.dir/viewflif.c.o.requires:

.PHONY : CMakeFiles/viewflif.dir/viewflif.c.o.requires

CMakeFiles/viewflif.dir/viewflif.c.o.provides: CMakeFiles/viewflif.dir/viewflif.c.o.requires
	$(MAKE) -f CMakeFiles/viewflif.dir/build.make CMakeFiles/viewflif.dir/viewflif.c.o.provides.build
.PHONY : CMakeFiles/viewflif.dir/viewflif.c.o.provides

CMakeFiles/viewflif.dir/viewflif.c.o.provides.build: CMakeFiles/viewflif.dir/viewflif.c.o


# Object files for target viewflif
viewflif_OBJECTS = \
"CMakeFiles/viewflif.dir/viewflif.c.o"

# External object files for target viewflif
viewflif_EXTERNAL_OBJECTS =

viewflif: CMakeFiles/viewflif.dir/viewflif.c.o
viewflif: CMakeFiles/viewflif.dir/build.make
viewflif: libflif_dec.so.0
viewflif: /usr/lib/x86_64-linux-gnu/libpng.so
viewflif: CMakeFiles/viewflif.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/turpentine/Documents/sources/FLIF/src/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable viewflif"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/viewflif.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/viewflif.dir/build: viewflif

.PHONY : CMakeFiles/viewflif.dir/build

CMakeFiles/viewflif.dir/requires: CMakeFiles/viewflif.dir/viewflif.c.o.requires

.PHONY : CMakeFiles/viewflif.dir/requires

CMakeFiles/viewflif.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/viewflif.dir/cmake_clean.cmake
.PHONY : CMakeFiles/viewflif.dir/clean

CMakeFiles/viewflif.dir/depend:
	cd /home/turpentine/Documents/sources/FLIF/src/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/turpentine/Documents/sources/FLIF/src /home/turpentine/Documents/sources/FLIF/src /home/turpentine/Documents/sources/FLIF/src/build /home/turpentine/Documents/sources/FLIF/src/build /home/turpentine/Documents/sources/FLIF/src/build/CMakeFiles/viewflif.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/viewflif.dir/depend

