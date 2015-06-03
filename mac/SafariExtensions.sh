#!/bin/bash
set -u
extFolder=$HOME/Safari
if ! [ -e $extFolder ]; then
    mkdir $extFolder
fi

extName[0]=adblockplussafari.safariextz
extUrl[0]=https://update.adblockplus.org/latest/adblockplussafari.safariextz
extName[1]=autopagerize_for_safari.safariextz
extUrl[1]=http://autopagerize.net/files/autopagerize_for_safari.safariextz
extName[2]=SearchPreview-1.1.safariextz
extUrl[2]=https://searchpreview.de/Safari/SearchPreview-1.1.safariextz
extName[3]=shortly.safariextz
extUrl[3]=http://zzhc.org/shortly/shortly.safariextz

for i in "${!extName[@]}"
do
    echo ${extName[$i]}
    if ! [ -f $extFolder/${extName[$i]} ]; then
        wget ${extUrl[$i]} -P $extFolder
        echo "Extension $extFolder/${extName[$i]} downloaded."
    else
        echo "Extension $extFolder/${extName[$i]} exists."
    fi
done

url=https://github.com/rs/SafariTabSwitching/releases/download/1.2.7
name=Safari.Tab.Switching-1.2.7.zip
if ! [ -e $extFolder/Safari\ Tab\ Switching-1.2.7.pkg ]; then
    wget $url/$name -P $extFolder
    unzip $extFolder/Safari.Tab.Switching-1.2.7.zip -d $extFolder\
          -x "__MACOSX/*"
    rm $extFolder/$name
else
    echo "Safari Tab Switching wasn't downloaded because it already exists."
fi
echo "Extension TabSwitching downloaded in $extFolder"

echo "All extensions are stored in $extFolder"
echo "Install them if you want, then delete the folder."
