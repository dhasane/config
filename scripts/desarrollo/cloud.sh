#!/bin/sh

# echo $TERMINAL
# ini="$TERMINAL -e"
# if [[ $DISPLAY ]]; then
#     ini=$TERM
#     # ini="st -e "
# fi

if [ "$1" != "" ]; then

    proyecto="$1"
    $ini gcloud beta compute --project "$proyecto" ssh --zone "us-central1-f" "general-purpose-cloud-vm-1-vm"
else
    echo "falta el parametro del nombre del proyecto"
fi

