include(FetchContent)

set(SDLIMAGE_AVIF OFF)	# disable formats we don't use to make the build faster and smaller.
set(SDLIMAGE_BMP OFF)
set(SDLIMAGE_JPG OFF)
set(SDLIMAGE_WEBP OFF)
set(SDLIMAGE_PNG ON)
set(SDLIMAGE_DEPS_SHARED OFF)
set(SDLIMAGE_BUILD_SHARED_LIBS OFF)

FetchContent_Declare(
        sdl_image
        GIT_REPOSITORY https://github.com/libsdl-org/SDL_image.git
        GIT_TAG release-3.2.0
)

FetchContent_MakeAvailable(sdl_image)
