if(NOT NINTENDO_SWITCH)
    return()
endif()

option(MIKUPAN_SWITCH_NRO
    "Build Nintendo Switch .nro package from the MikuPan ELF output."
    ON)

if(NOT MIKUPAN_SWITCH_NRO)
    return()
endif()

if(NOT sdl3_SOURCE_DIR)
    message(FATAL_ERROR
            "MIKUPAN_SWITCH_NRO requires SDL3 to be provided by cmake/sdl3.cmake.")
endif()

find_program(NACPTOOL_BIN
    NAMES nacptool)
find_program(ELF2NRO_BIN
    NAMES elf2nro)

foreach(tool NACPTOOL_BIN ELF2NRO_BIN)
    if(NOT ${tool} OR NOT EXISTS "${${tool}}")
        message(FATAL_ERROR "Required Switch packaging tool not found: ${tool}")
    endif()
endforeach()

set(MIKUPAN_SWITCH_INTERMEDIATES_DIR "${CMAKE_BINARY_DIR}/intermediates")
set(MIKUPAN_SWITCH_NACP
    "${MIKUPAN_SWITCH_INTERMEDIATES_DIR}/MikuPan.nacp")

add_custom_command(
    OUTPUT "${MIKUPAN_SWITCH_NACP}"
    COMMAND "${NACPTOOL_BIN}"
    --create
    "MikuPan"
    "Mikompilation"
    "${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}.0"
    "${MIKUPAN_SWITCH_NACP}"
    VERBATIM
)

add_custom_target(MikuPan-nacp
        DEPENDS "${MIKUPAN_SWITCH_NACP}")

add_custom_command(
    OUTPUT "${CMAKE_BINARY_DIR}/MikuPan.nro"
    COMMAND "${ELF2NRO_BIN}"
        "$<TARGET_FILE:MikuPan>"
        "${CMAKE_BINARY_DIR}/MikuPan.nro"
        "--nacp=${MIKUPAN_SWITCH_NACP}"
    DEPENDS MikuPan "${MIKUPAN_SWITCH_NACP}"
    VERBATIM
)

add_custom_target(MikuPan-nro
        DEPENDS "${CMAKE_BINARY_DIR}/MikuPan.nro")
