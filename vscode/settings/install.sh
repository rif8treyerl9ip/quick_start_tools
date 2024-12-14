#!/bin/zsh

# ex. for curso
while IFS= read -r ext; do
   echo "$ext"
   cursor --install-extension "$ext"
done < extensions.txt

# ex. for code
# while IFS= read -r ext; do
#    echo "$ext"
#    code --install-extension "$ext"
# done < extensions.txt
