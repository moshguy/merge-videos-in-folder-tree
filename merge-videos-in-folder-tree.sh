for d in */ ;
do
    FOLDERNAME=$(echo $d | sed 's:/*$::')
    WORKINGDIR=$PWD/"$d"
    rm $WORKINGDIR.concat-list.txt >/dev/null 2>&1
    rm "${WORKINGDIR}output.mp4" >/dev/null 2>&1

    echo "Foldername: $FOLDERNAME\n"

    printf "Files to be merged: \n"
    for file in $WORKINGDIR*
    do
      printf "     $file\n"
      #echo "Processing $file file..."
      echo "file ${file##*/}" >> $WORKINGDIR.concat-list.txt
    done

    printf "Merging files into ${WORKINGDIR}output.mp4\n"
    ffmpeg -y -f concat -i $WORKINGDIR.concat-list.txt -c copy "${WORKINGDIR}output.mp4" >/dev/null

    printf "Converting file to $(pwd)/$FOLDERNAME.mp4\n"
    ffmpeg -y -i "${WORKINGDIR}output.mp4" -vcodec libx264 -acodec aac "$(pwd)/$FOLDERNAME.mp4" >/dev/null

    rm $WORKINGDIR.concat-list.txt >/dev/null 2>&1
    rm "${WORKINGDIR}output.mp4" >/dev/null 2>&1

    printf "\n ..............................................\n"



done
