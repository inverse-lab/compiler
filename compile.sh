#!/bin/bash

cd ${KERNEL_ROOTDIR}
rm -rf out
export ARCH=arm64
export CC=clang
mkdir -p O=out
make O=out clean
make $KERNEL_DEFCONFIG O=out
make menuconfig O=out
     
build_message "Compile Started 👹  !!1!️"

make -j$(nproc --all) ARCH=arm64 O=out \
        CC=${CLANG_ROOTDIR}/bin/clang \
        CLANG_TRIPLE=aarch64-linux-gnu \
        CROSS_COMPILE=${CLANG_ROOTDIR}/bin/aarch64-linux-gnu- \
        CROSS_COMPILE_ARM32=${CLANG_ROOTDIR}/bin/arm-linux-gnueabi-
if ! [[ -f "$IMG_PATH/Image.gz-dtb" || -f "$IMG_PATH/Image" ]]; then
     tg_send_message --chat_id "$CHAT_ID" --text "   ====== Compile Aborted 😓 ======
   👿   Please Check the eror   👿"
     echo "Compile failed, please check build log and fix it!"
    exit 1
else
     echo "Compile Complete, find kernel image in $IMG_PATH"
fi
cd $ANYKERNELDIR
nano anykernel.sh
cp "$IMGPATH/Image" "$ANYKERNELDIR" || cp  "$IMGPATH/Image.gz-dtb" "$ANYKERNELDIR"
zip -r9 "GreenForce-main-${DATE}.zip" ./*
    build_message "Compile success ❤️"
    tg_send_message --chat_id "$CHAT_ID" --text "LOL WTF' Compile Success Mate ❤️
Congratsss I'm Happy for you!!"
tg_send_document --chat_id "$CHAT_ID" --document "$SUCCESBUILD" --reply_to_message_id "$CI_MESSAGE_I$	
