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
include CMakeFiles/pixbufloader-flif-static.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/pixbufloader-flif-static.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/pixbufloader-flif-static.dir/flags.make

CMakeFiles/pixbufloader-flif-static.dir/flif-pixbuf-loader.c.o: CMakeFiles/pixbufloader-flif-static.dir/flags.make
CMakeFiles/pixbufloader-flif-static.dir/flif-pixbuf-loader.c.o: ../flif-pixbuf-loader.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/turpentine/Documents/sources/FLIF/src/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/pixbufloader-flif-static.dir/flif-pixbuf-loader.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/pixbufloader-flif-static.dir/flif-pixbuf-loader.c.o   -c /home/turpentine/Documents/sources/FLIF/src/flif-pixbuf-loader.c

CMakeFiles/pixbufloader-flif-static.dir/flif-pixbuf-loader.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/pixbufloader-flif-static.dir/flif-pixbuf-loader.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/turpentine/Documents/sources/FLIF/src/flif-pixbuf-loader.c > CMakeFiles/pixbufloader-flif-static.dir/flif-pixbuf-loader.c.i

CMakeFiles/pixbufloader-flif-static.dir/flif-pixbuf-loader.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/pixbufloader-flif-static.dir/flif-pixbuf-loader.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/turpentine/Documents/sources/FLIF/src/flif-pixbuf-loader.c -o CMakeFiles/pixbufloader-flif-static.dir/flif-pixbuf-loader.c.s

CMakeFiles/pixbufloader-flif-static.dir/flif-pixbuf-loader.c.o.requires:

.PHONY : CMakeFiles/pixbufloader-flif-static.dir/flif-pixbuf-loader.c.o.requires

CMakeFiles/pixbufloader-flif-static.dir/flif-pixbuf-loader.c.o.provides: CMakeFiles/pixbufloader-flif-static.dir/flif-pixbuf-loader.c.o.requires
	$(MAKE) -f CMakeFiles/pixbufloader-flif-static.dir/build.make CMakeFiles/pixbufloader-flif-static.dir/flif-pixbuf-loader.c.o.provides.build
.PHONY : CMakeFiles/pixbufloader-flif-static.dir/flif-pixbuf-loader.c.o.provides

CMakeFiles/pixbufloader-flif-static.dir/flif-pixbuf-loader.c.o.provides.build: CMakeFiles/pixbufloader-flif-static.dir/flif-pixbuf-loader.c.o


# Object files for target pixbufloader-flif-static
pixbufloader__flif__static_OBJECTS = \
"CMakeFiles/pixbufloader-flif-static.dir/flif-pixbuf-loader.c.o"

# External object files for target pixbufloader-flif-static
pixbufloader__flif__static_EXTERNAL_OBJECTS =

libpixbufloader-flif.a: CMakeFiles/pixbufloader-flif-static.dir/flif-pixbuf-loader.c.o
libpixbufloader-flif.a: CMakeFiles/pixbufloader-flif-static.dir/build.make
libpixbufloader-flif.a: CMakeFiles/pixbufloader-flif-static.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/turpentine/Documents/sources/FLIF/src/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C static library libpixbufloader-flif.a"
	$(CMAKE_COMMAND) -P CMakeFiles/pixbufloader-flif-static.dir/cmake_clean_target.cmake
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/pixbufloader-flif-static.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/pixbufloader-flif-static.dir/build: libpixbufloader-flif.a

.PHONY : CMakeFiles/pixbufloader-flif-static.dir/build

CMakeFiles/pixbufloader-flif-static.dir/requires: CMakeFiles/pixbufloader-flif-static.dir/flif-pixbuf-loader.c.o.requires

.PHONY : CMakeFiles/pixbufloader-flif-static.dir/requires

CMakeFiles/pixbufloader-flif-static.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/pixbufloader-flif-static.dir/cmake_clean.cmake
.PHONY : CMakeFiles/pixbufloader-flif-static.dir/clean

CMakeFiles/pixbufloader-flif-static.dir/depend:
	cd /home/turpentine/Documents/sources/FLIF/src/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/turpentine/Documents/sources/FLIF/src /home/turpentine/Documents/sources/FLIF/src /home/turpentine/Documents/sources/FLIF/src/build /home/turpentine/Documents/sources/FLIF/src/build /home/turpentine/Documents/sources/FLIF/src/build/CMakeFiles/pixbufloader-flif-static.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/pixbufloader-flif-static.dir/depend

