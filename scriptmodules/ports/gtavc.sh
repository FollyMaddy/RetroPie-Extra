#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="gtavc"
rp_module_desc="Grand Theft Auto Vice City"
rp_module_help="you will need original all data files from the game"
rp_module_repo="file https://github.com/Exarkuniv/Rpi-pikiss-binary/raw/Master/gtavc-bin-rpi.tar.gz"
rp_module_section="exp"
rp_module_flags="!armv6 rpi5 !rpi4"

function depends_gtavc() {
    getDepends xorg libopenal1 libsndfile1 libmpg123-0
}

function sources_gtavc() {
    downloadAndExtract "$md_repo_url" "$md_build" "--strip-components=1"
}

function install_gtavc() {
    md_ret_files=('userfiles'
		'neo'
		'data'
		'models'
		'TEXT'
		'reVC.sh'
		'reVC_arm64'
		'files_required.txt'
		'reVC'
		'reVC.ini'
		'gamecontrollerdb.txt'
		'readMe.txt'
		'gtavc.ico'
		'installscript.vdf'
    )
}

function configure_gtavc() {
    mkRomDir "ports/gtavc"
    # Create symlinks from installation directory to roms directory
    ln -sf "$md_inst/reVC_arm64" "$romdir/ports/gtavc/reVC_arm64"
    ln -sf "$md_inst/reVC.ini" "$romdir/ports/gtavc/reVC.ini"
    ln -sf "$md_inst/gamecontrollerdb.txt" "$romdir/ports/gtavc/gamecontrollerdb.txt"

    # Copy game data files to roms directory
    cp -Rv "$md_inst/data" "$romdir/ports/$md_id/"
    cp -Rv "$md_inst/models" "$romdir/ports/$md_id/"
    cp -Rv "$md_inst/TEXT" "$romdir/ports/$md_id/"
    cp -Rv "$md_inst/neo" "$romdir/ports/$md_id/"
    cp -Rv "$md_inst/userfiles" "$romdir/ports/$md_id/"

    local script="$md_id.sh"
    cat > "$script" << _EOF_
#!/bin/bash
cd $romdir/ports/gtavc/
./reVC_arm64
_EOF_

    chmod +x "$script"
    chown -R $user:$user "$romdir/ports/$md_id"

    addPort "$md_id" "gtavc" "Grand Theft Auto Vice City" "XINIT: $md_inst/$script"
}