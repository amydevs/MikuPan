include(FetchContent)

FetchContent_Declare(
        spdlog
        GIT_REPOSITORY https://github.com/gabime/spdlog.git
        GIT_TAG v1.16.0
)

FetchContent_MakeAvailable(spdlog)

if(NINTENDO_SWITCH)
        if(TARGET spdlog)
                target_compile_definitions(spdlog
                                PUBLIC _POSIX_C_SOURCE=200809L _DEFAULT_SOURCE)
        endif()

        if(TARGET spdlog_header_only)
                target_compile_definitions(spdlog_header_only
                                INTERFACE _POSIX_C_SOURCE=200809L _DEFAULT_SOURCE)
        endif()
endif()