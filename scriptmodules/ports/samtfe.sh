#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="samtfe"
rp_module_desc="SamTFE - Serious Sam Classic The First Encounter"
rp_module_licence="GPL2 https://raw.githubusercontent.com/tx00100xt/SeriousSamClassic/main/LICENSE"
rp_module_help="NEED Serious Sam Classic version of this game\nCopy all *.gro files and Help folder from the game directory to SamTSE directory. At the current time the files are:
\nHelp (folder)\nLevels (folder)\n1_00_ExtraTools.gro\n1_00_music.gro\n1_00c_Logo.gro\n1_00c.gro\n1_00c_scripts.gro\n1_04_patch.gro"
rp_module_repo="git https://github.com/tx00100xt/SeriousSamClassic.git main"
rp_module_section="exp"
rp_module_flags="!all rpi5"

function depends_samtfe() {
    depends_samtse
}

function sources_samtfe() {
    sources_samtse 
}

function build_samtfe() {
     build_samtse
}

function install_samtfe() {
    install_samtse
}

function configure_samtfe() {
    configure_samtse
}