#!/bin/bash
echo "########### Options ###############
Press 1- To create a new gpg key
Press 2- To use the current gpg key"
read input

if [[ $input -eq 1 ]]
then
    gpg --full-generate-key
    echo "Your key has been successfully generated!"
    bash signing_gpg.sh
fi

if [[ $input -eq 2 ]]
then
    gpgkey=$(gpg --list-secret-keys --keyid-format=long)
    keysize=${#gpgkey}
    if [ $keysize ]
        then
            echo "Available gpg keys are -"
        else
            echo "There are no existing gpg keys, please generate one -"
            gpg --full-generate-key
        fi
    key=$(gpg --list-secret-keys --keyid-format=long|awk '/sec/{if (length($2)>0) print $2}')
    name=$(gpg --list-secret-keys --keyid-format=long|awk '/uid/{if (length($3)>0) print $3}')
    declare -a keyA
    declare -a uidA
    n1=${#key}

    echo $n1

    j=0
    index=0

    for((i=0;i<$n1;i++));
    do
    if [[ ${key:$i:1} == "/" ]]
        then
        keyA[$j]=${key:$i+1:16}
        ((j++))
        fi
    done

    echo "Type the index of GPG key required"

    read index

    gpg --armor --export ${keyA[index]}

    newKey= ${keyA[index]}
    
else
echo "Choose a right option"
fi
bash signing_gpg.sh
