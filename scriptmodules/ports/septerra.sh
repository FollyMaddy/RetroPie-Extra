#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="septerra"
rp_module_desc="SR-Septerra - Septerra Core: Legacy of the Creator port "
rp_module_help="This port requires Septerra Core v1.04.\n\nInstall files .DB, .idx, .ini, .mft, and .conf into $romdir/ports/septerra"
rp_module_repo="wget https://github.com/M-HT/SR/releases/download/septerra_v1.04.0.12/SepterraCore-Linux-armv7-gnueabihf-v1.04.0.12.tar.gz"
rp_module_section="exp"
rp_module_flags="!mali !all rpi5"

function depends_septerra() {
    getDepends build-essential git scons automake gdc llvm libsdl2-dev libmpg123-dev libquicktime-dev libjudy-dev libsdl2-mixer-dev
}

function install_bin_septerra() {
    if isPlatform "rpi5"; then
    downloadAndExtract "https://github.com/M-HT/SR/releases/download/septerra_v1.04.0.12/SepterraCore-Linux-arm-aarch64-v1.04.0.12-EXPERIMENTAL.tar.gz" "$md_inst"

    else

    downloadAndExtract "$md_repo_url" "$md_inst"

    fi
}

function configure_septerra() {
    mkRomDir "ports/$md_id"
    ln -sf "$romdir/ports/$md_id" "$md_inst"
    local script="$md_inst/$md_id.sh"
    moveConfigDir "$romdir/ports/$md_id/savedata" "$md_conf_root/$md_id/savedata"
    addPort "$md_id" "septerra" "Septerra Core - Legacy of the Creator" "$script %ROM%"

    #create buffer script for launch
    if isPlatform "rpi5"; then
    cat > "$script" << _EOF_
#!/bin/bash
pushd "$romdir/ports/$md_id"
cd $md_inst
./Septerra.sh
popd
_EOF_

    else

    cat > "$script" << _EOF_
#!/bin/bash
pushd "$romdir/ports/$md_id"
"$md_inst/SR-Septerra" \$*
popd
_EOF_

fi
    chmod +x "$script"
}