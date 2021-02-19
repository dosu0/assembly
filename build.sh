#!/bin/sh

if [ ! -d 'bin' ]; then
    mkdir bin
fi

if [ ! -d 'src/x64/.deps' ]; then
    mkdir src/x64/.deps
fi

if [ ! -d 'src/x86/.deps' ]; then
    mkdir src/x86/.deps
fi

# idk. maybe i should have a build script?
if [ $(command -v tput) ]; then
    RED=`tput setaf 1`
    GREEN=`tput setaf 2`
    YELLOW=`tput setaf 3`
    BOLD=`tput bold`
    CLR=`tput sgr0`
fi

FATAL="${RED}${BOLD}[FATAL]:"
GOOD=${GREEN}${BOLD}
WARN="${YELLOW}${BOLD}[WARNING]"
case `uname -s` in
    Linux)
        INSTALL='sudo apt-get install'
        break
        ;;
    Darwin) 
        INSTALL='brew install'
        break
        ;;
    * ) echo $FATAL unkwown system; exit;;
esac

if ! [ $(command -v make) ]; then
    echo $WARN make is required

    while true; do
        read -p "Do you wish to install gcc (for make and ld)" yn
        case $yn in
            [Yy]* ) $INSTALL gcc; break;;
            [Nn]* ) echo $FATAL make is required exit;;
            * ) echo "Please answer yes or no.";;
        esac
    done
    echo "sudo apt-get install gcc"
    exit 1
fi

echo $GOOD[START BUILD]: $(date) $CLR

starttime=$(date "+%s")
make
if [ $? != 0 ]; then
    echo $FATAL build was not successful $CLR
    exit 1
fi
endtime=$(date "+%s")
echo $GOOD[END BUILD]: $(date)
echo $GOOD[BUILD TIME]: $(expr  $endtime - $starttime)