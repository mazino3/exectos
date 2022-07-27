# This function enables the addition of ASM compiler switches
function(add_compiler_asmflags FLAGS)
    if(NOT ${ARGC} EQUAL 1)
        message(FATAL_ERROR "Invalid number of arguments passed to add_compiler_asmflags() function")
    endif()
    set(CMAKE_ASM_FLAGS "${CMAKE_ASM_FLAGS} ${FLAGS}" PARENT_SCOPE)
endfunction()

# This function enables the addition of C compiler switches
function(add_compiler_cflags FLAGS)
    if(NOT ${ARGC} EQUAL 1)
        message(FATAL_ERROR "Invalid number of arguments passed to add_compiler_cflags() function")
    endif()
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${FLAGS}" PARENT_SCOPE)
endfunction()

# This function enables the addition of C/C++ compilers switches
function(add_compiler_ccxxflags FLAGS)
    if(NOT ${ARGC} EQUAL 1)
        message(FATAL_ERROR "Invalid number of arguments passed to add_compiler_ccxxflags() function")
    endif()
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${FLAGS}" PARENT_SCOPE)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${FLAGS}" PARENT_SCOPE)
endfunction()

# This function enables the addition of C++ compiler switches
function(add_compiler_cxxflags FLAGS)
    if(NOT ${ARGC} EQUAL 1)
        message(FATAL_ERROR "Invalid number of arguments passed to add_compiler_cxxflags() function")
    endif()
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${FLAGS}" PARENT_SCOPE)
endfunction()

# This function enables the addition of ASM/C/C++ compilers switches
function(add_compiler_flags FLAGS)
    if(NOT ${ARGC} EQUAL 1)
        message(FATAL_ERROR "Invalid number of arguments passed to add_compiler_flags() function")
    endif()
    set(CMAKE_ASM_FLAGS "${CMAKE_ASM_FLAGS} ${FLAGS}" PARENT_SCOPE)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${FLAGS}" PARENT_SCOPE)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${FLAGS}" PARENT_SCOPE)
endfunction()

# This function enables the addition of linker switches
function(add_linker_flags FLAGS)
    if(NOT ${ARGC} EQUAL 1)
        message(FATAL_ERROR "Invalid number of arguments passwd to add_linker_flags() function")
    endif()
    foreach(TYPE EXE MODULE SHARED)
        set(CMAKE_${TYPE}_LINKER_FLAGS "${CMAKE_${TYPE}_LINKER_FLAGS} ${FLAGS}" PARENT_SCOPE)
    endforeach()
endfunction()

# This function enabled the addition of linker switches for specified module
function(add_module_linker_flags MODULE FLAGS)
    if(NOT ${ARGC} EQUAL 2)
        message(FATAL_ERROR "Invalid number of arguments passwd to add_module_linker_flags() function")
    endif()
    set_module_property(${MODULE} LINK_FLAGS ${FLAGS})
endfunction()

# This function sets a property for specified module
function(set_module_property MODULE PROPERTY FLAGS)
    if(NOT ${ARGC} EQUAL 3)
        message(FATAL_ERROR "Invalid number of arguments passwd to add_module_property() function")
    endif()
    get_target_property(VAL ${MODULE} ${PROPERTY})
    if(VAL)
        set(VAL "${VAL} ${FLAGS}")
    else()
        set(VAL "${FLAGS}")
    endif()
    set_property(TARGET ${MODULE} PROPERTY ${PROPERTY} ${VAL})
endfunction()

# This function installs specified directory recursively under destination directory
function(set_install_dir DIRECTORY DESTINATION)
    install(DIRECTORY ${DIRECTORY} DESTINATION ${EXECTOS_BINARY_DIR}/output/binaries/${DESTINATION})
endfunction()

# This function installs specified file under destination directory
function(set_install_file FILENAME DESTINATION)
    install(FILES ${FILENAME} DESTINATION ${EXECTOS_BINARY_DIR}/output/binaries/${DESTINATION})
endfunction()

# This function installs specified target results under destination directory
function(set_install_target TARGET DESTINATION)
    install(TARGETS ${TARGET} DESTINATION ${EXECTOS_BINARY_DIR}/output/binaries/${DESTINATION})
endfunction()

# This function enables or disables binary ordinals export for specified module
function(set_ordinals MODULE STATE)
    if(NOT ${ARGC} EQUAL 2)
        message(FATAL_ERROR "Invalid number of arguments passed to set_ordinals() function")
    endif()
    set_module_property(${MODULE} ENABLE_EXPORTS ${STATE})
endfunction()

# This function is responsible for compiling module SPEC file
function(set_specfile SPECFILE)
    if(NOT ${ARGC} EQUAL 1)
        message(FATAL_ERROR "Invalid number of arguments passed to set_specfile() function")
    endif()
    get_filename_component(FILENAME ${SPECFILE} NAME_WE)
    add_custom_command(OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${FILENAME}.def ${CMAKE_CURRENT_BINARY_DIR}/${FILENAME}.c
                       COMMAND ${CMAKE_SPEC_COMPILER} -a=${ARCH} -d=${CMAKE_CURRENT_BINARY_DIR}/${FILENAME}.def -s=${CMAKE_CURRENT_BINARY_DIR}/${FILENAME}.c ${CMAKE_CURRENT_SOURCE_DIR}/${SPECFILE})
endfunction()

# This function sets the the qemu disk image size (in MiB)
function(set_disk_image_size SIZE)
	MATH(EXPR DISK_BLOCKS ${SIZE}*1024*1024/512)
	MATH(EXPR PART_BLOCKS ${DISK_BLOCKS}-2048)
	set(PROJECT_DISK_IMAGE_BLOCKS ${DISK_BLOCKS} CACHE INTERNAL "PROJECT_DISK_IMAGE_BLOCKS")
	set(PROJECT_PART_IMAGE_BLOCKS ${PART_BLOCKS} CACHE INTERNAL "PROJECT_PART_IMAGE_BLOCKS")
endfunction()

# This target creates a disk image
add_custom_target(diskimg
                  DEPENDS install
                  COMMAND sh -c "dd if=/dev/zero of=${EXECTOS_BINARY_DIR}/output/disk.img bs=512 count=${PROJECT_DISK_IMAGE_BLOCKS} &>/dev/null"
                  COMMAND parted ${EXECTOS_BINARY_DIR}/output/disk.img -s -a minimal mklabel gpt
                  COMMAND parted ${EXECTOS_BINARY_DIR}/output/disk.img -s -a minimal mkpart EFI FAT32 2048s ${PROJECT_PART_IMAGE_BLOCKS}s
                  COMMAND parted ${EXECTOS_BINARY_DIR}/output/disk.img -s -a minimal toggle 1 boot
                  COMMAND sh -c "dd if=/dev/zero of=${EXECTOS_BINARY_DIR}/output/part.img bs=512 count=${PROJECT_PART_IMAGE_BLOCKS} &>/dev/null"
                  COMMAND mformat -i ${EXECTOS_BINARY_DIR}/output/part.img -h32 -t32 -n64 -L32
                  COMMAND sh -c "mcopy -s -i ${EXECTOS_BINARY_DIR}/output/part.img ${EXECTOS_BINARY_DIR}/output/binaries/* ::"
                  COMMAND sh -c "dd if=${EXECTOS_BINARY_DIR}/output/part.img of=${EXECTOS_BINARY_DIR}/output/disk.img bs=512 count=${PROJECT_PART_IMAGE_BLOCKS} seek=2048 conv=notrunc &>/dev/null"
                  COMMAND rm ${EXECTOS_BINARY_DIR}/output/part.img
                  VERBATIM)