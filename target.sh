#!/bin/bash

KERNEL_ROOTDIR=/home/runner/work/Ubuntu-SSHY/Ubuntu-SSHY/gf
KERNEL_DEFCONFIG=vendor/juice-perf_defconfig
CLANG_ROOTDIR=/home/runner/work/Ubuntu-SSHY/Ubuntu-SSHY/clang
ANYKERNELDIR=/home/runner/work/Ubuntu-SSHY/Ubuntu-SSHY/Anykernel
IMGPATH=${KERNEL_ROOTDIR}/out/arch/arm64/boot
export KBUILD_BUILD_USER=zaidan
export KBUILD_BUILD_HOST=zaidan
export DIR=$(pwd)
export TG_TOKEN=5897356168:AAFmBbQ2ZPbKsUuL6xrkIq6GhXPbjHkalTM
export CHAT_ID=1724535418
export DATE=$(date)
export KERNELNAME=(GreenForce)
export KERNELBRANCH=(main)
export COMPILE=(Proton-Clang)
export DEVICE=(Juice)

