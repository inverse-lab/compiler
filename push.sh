#!/bin/bash

cd $ANYKERNELDIR
nano anykernel.sh
cp "$IMGPATH/Image" "$ANYKERNELDIR" || cp  "$IMGPATH/dtb.img" "$ANYKERNELDIR" || cp  "$IMGPATH/dtbo.img" "$ANYKERNELDIR"
zip -r9 "GreenForce-main-$(date +%Y%m%d-%H%M).zip" ./*
    build_message "Compile success ❤️"
    tg_send_message --chat_id "$CHAT_ID" --text "LOL WTF' Compile Success Mate ❤️
Congratsss I'm Happy for you!!"
tg_send_document --chat_id "$CHAT_ID" --document "$SUCCESBUILD" --reply_to_message_id "$CI_MESSAGE_I$	
