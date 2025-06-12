#!/usr/bin/env bash

# This file is part of RetroPie-Extra, a supplement to RetroPie.
# For more information, please visit:
#
# https://github.com/RetroPie/RetroPie-Setup
# https://github.com/Exarkuniv/RetroPie-Extra
# https://github.com/FollyMaddy/RetroPie-Share
#
# See the LICENSE file distributed with this source and at
# https://raw.githubusercontent.com/Exarkuniv/RetroPie-Extra/master/LICENSE
#
 
rp_module_id="borked3ds"
rp_module_desc="3DS Emulator borked3ds"
rp_module_help="ROM Extension: .3ds .3dsx .elf .axf .cci ,cxi .app\n\nCopy your 3DS roms to $romdir/3ds"
rp_module_licence="GPL2 https://github.com/Borked3DS/Borked3DS/blob/master/license.txt"
rp_module_section="exp"
rp_module_flags="64bit"
 
function depends_borked3ds() {
    if compareVersions $__gcc_version lt 7; then
        md_ret_errors+=("Sorry, you need an OS with gcc 7.0 or newer to compile borked3ds")
        return 1
    fi
 
    # Additional libraries required for running
	#local depends=(build-essential cmake clang clang-format libc++-dev libsdl2-dev libssl-dev qt6-l10n-tools qt6-tools-dev qt6-tools-dev-tools  qt6-base-dev qt6-base-private-dev libxcb-cursor-dev libvulkan-dev qt6-multimedia-dev libqt6sql6 libqt6core6 libasound2-dev xorg-dev libx11-dev libxext-dev libpipewire-0.3-dev libsndio-dev libfdk-aac-dev ffmpeg libgl-dev libswscale-dev libavformat-dev libavcodec-dev libavdevice-dev libglut3.12 libglut-dev freeglut3-dev mesa-vulkan-drivers libinput-dev) 
	if isPlatform "rpi" && isPlatform "64bit"; then
		local depends=(build-essential cmake clang clang-format libc++-dev libsdl2-dev libssl-dev qt6-l10n-tools qt6-tools-dev qt6-tools-dev-tools  qt6-base-dev qt6-base-private-dev libxcb-cursor-dev libvulkan-dev qt6-multimedia-dev libqt6sql6 libqt6core6 libasound2-dev xorg-dev libx11-dev libxext-dev libpipewire-0.3-dev libsndio-dev libfdk-aac-dev ffmpeg libgl-dev  libswscale-dev libavformat-dev libavcodec-dev libavdevice-dev libglut3.12 libglut-dev freeglut3-dev mesa-vulkan-drivers robin-map-dev) 
	else
		# packages not in bookworm for x86_64 : libfdk-aac-dev
		# robin-map-dev is in the source and found when using https://github.com/rtiangha/Borked3DS.git
		local depends=(build-essential cmake clang clang-format libc++-dev libsdl2-dev libssl-dev qt6-l10n-tools qt6-tools-dev qt6-tools-dev-tools  qt6-base-dev qt6-base-private-dev libxcb-cursor-dev libvulkan-dev qt6-multimedia-dev libqt6sql6 libqt6core6 libasound2-dev xorg-dev libx11-dev libxext-dev libpipewire-0.3-dev libsndio-dev ffmpeg libgl-dev  libswscale-dev libavformat-dev libavcodec-dev libavdevice-dev libglut3.12 libglut-dev freeglut3-dev mesa-vulkan-drivers) 
	fi
	
	getDepends "${depends[@]}"
}

function sources_borked3ds() {
#backup of all forks, replace in if function when needed
#gitPullOrClone "$md_build" https://github.com/rtiangha/Borked3DS.git vk-regression 
#gitPullOrClone "$md_build" https://github.com/borked3ds/Borked3DS.git
#gitPullOrClone "$md_build" https://github.com/rtiangha/Borked3DS.git vulkan-validation
#gitPullOrClone "$md_build" https://github.com/rtiangha/Borked3DS.git mobile-gpus
#gitPullOrClone "$md_build" https://github.com/rtiangha/Borked3DS.git gpu-revert
#gitPullOrClone "$md_build" https://github.com/rtiangha/Borked3DS.git opengles-dev
#gitPullOrClone "$md_build" https://github.com/rtiangha/Borked3DS.git opengles-dev
#gitPullOrClone "$md_build" https://github.com/rtiangha/Borked3DS.git vk-revert
#gitPullOrClone "$md_build" https://github.com/rtiangha/Borked3DS.git
#gitPullOrClone "$md_build" https://github.com/rtiangha/Borked3DS.git vk-revert-mem-alloc
#gitPullOrClone "$md_build" https://github.com/rtiangha/Borked3DS.git vk-revert-0
#gitPullOrClone "$md_build" https://github.com/rtiangha/Borked3DS.git vk-revert-1
#gitPullOrClone "$md_build" https://github.com/rtiangha/Borked3DS.git vk-revert-2
#gitPullOrClone "$md_build" https://github.com/rtiangha/Borked3DS.git vk-revert-3
#gitPullOrClone "$md_build" https://github.com/Borked3DS/Borked3DS.git
#gitPullOrClone "$md_build" https://github.com/rtiangha/Borked3DS.git opengles-dev-v2
#gitPullOrClone "$md_build" https://github.com/rtiangha/Borked3DS.git fix-gcc12
#gitPullOrClone "$md_build" https://github.com/gvx64/Borked3DS-rpi.git

	#Borked3DS requires a cmake 3.5 as minimum, we will use the 4.0.2 binary
	#find the files on "https://cmake.org/files/v4.0/" (cmake-4.0.2.tar.gz is source only)
	
	if isPlatform "aarch64"; then
		gitPullOrClone "$md_build" https://github.com/gvx64/Borked3DS-rpi.git
		downloadAndExtract https://cmake.org/files/v4.0/cmake--linux-aarch64.tar.gz "$md_build"
		mv cmake-4.0.2* cmake-4.0.2
	else
		gitPullOrClone "$md_build" https://github.com/rtiangha/Borked3DS.git
		downloadAndExtract https://cmake.org/files/v4.0/cmake-4.0.2-linux-x86_64.tar.gz "$md_build"
		mv cmake-4.0.2* cmake-4.0.2
	fi	
}
 
function build_borked3ds() {
	mkdir build
	cd build
	$md_build/cmake-4.0.2/bin/cmake .. -DCMAKE_BUILD_TYPE=Release
	$md_build/cmake-4.0.2/bin/cmake --build . -- -j"$(nproc)"
	md_ret_require="$md_build/build/bin"
}
 
function install_borked3ds() {
	md_ret_files=(
	'build/bin/Release/borked3ds'
	#'build/bin/Release/borked3ds-cli'
	#'build/bin/Release/borked3ds-room'
	#'build/bin/Release/tests'
	)
}
 
function configure_borked3ds() {
    mkRomDir "3ds"
    ensureSystemretroconfig "3ds"
    local launch_prefix
    isPlatform "kms" && launch_prefix="XINIT-WMC:"
	addEmulator 0 "$md_id-ui" "3ds" "$launch_prefix$md_inst/borked3ds"
	addEmulator 1 "$md_id-roms" "3ds" "$launch_prefix$md_inst/borked3ds %ROM%"
	#addEmulator 1 "$md_id-room" "3ds" "$launch_prefix$md_inst/borked3ds-room"
	#addEmulator 2 "$md_id-cli" "3ds" "$launch_prefix$md_inst/borked3ds-cli"
	#addEmulator 3 "$md_id-tests" "3ds" "$launch_prefix$md_inst/tests"
	addSystem "3ds" "3ds" ".3ds .3dsx .elf .axf .cci ,cxi .app" 
}
