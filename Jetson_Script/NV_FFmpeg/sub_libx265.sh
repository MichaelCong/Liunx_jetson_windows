#!/bin/sh

# sudo apt install -y libx265-dev
# Setting up libx265-dev:arm64 (2.6-3) ...

pkg-config --list-all | grep x26
# x264 - H.264 (MPEG4 AVC) encoder library
# x265 - H.265/HEVC video encoder

# ERROR: x265 not found using pkg-config
exit

cd `dirname $0`
pwd
SCRIPT_DIR=$(pwd)
echo $SCRIPT_DIR


# ===
# ===
if [ -d ./x265 ]; then
  echo "Already Exists Directory"
  exit 0
fi


# ===
# ===
# libx265 x265 HEVC Encoder
# ubuntu packages:
# sudo apt-get install mercurial cmake cmake-curses-gui build-essential yasm
sudo apt-get -y install mercurial build-essential yasm nasm

# Note: if the packaged yasm is older than 1.2, you must download yasm (1.3 recommended) and build it
# If you are compiling off the default branch after release of v2.6, you must have nasm (2.13 or newer) installed and added to your path

# Release_3.4 2020‑05‑30
# hg clone https://bitbucket.org/multicoreware/x265 -r 1 -b Release_3.4

# 2020/09
# ffmpeg --enable-libx265
# ERROR: x265 not found using pkg-config
# Release_3.4 NG
# Release_3.5 NG
git clone https://bitbucket.org/multicoreware/x265_git.git x265 -b Release_3.5 --depth 1
cd x265/build/linux
./make-Makefiles.bash


# time make -j4
time make -j$(nproc)
# real    1m30.326s
# user    3m42.940s
# sys     0m7.984s

sudo make install

