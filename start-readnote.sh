#!/bin/bash

LOCFILE="/tmp/crypted-block.loc"

# Mount command
if [ ! -e $LOCFILE ]; then
    touch $LOCFILE

    MYPAS=$(Xdialog --password --inputbox password 15 50 2>&1)
    #echo "My pass wass: $MYPAS"
    if [ -z "$MYPASS" ]; then
        ERROR=$(echo $MYPAS | encfs -S ~/.rednotebook/.data ~/.rednotebook/data)
        if [ $? -eq 0 ]
        then
            /usr/bin/rednotebook
            fusermount -u /home/$USER/.rednotebook/data
        else
            rm $LOCFILE
            echo "Error: $ERROR"
            Xdialog --msgbox "$ERROR" 15 70
            exit 2
        fi
    else
        echo "Eamty password string"
        Xdialog --msgbox "Eamty password" 15 45
        rm $LOCFILE
        exit 1
    fi
    rm $LOCFILE
else
    echo "Scripts is running"
fi
