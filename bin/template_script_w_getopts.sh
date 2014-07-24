#!/bin/bash
# This file is a boilerplate template for creating a bash script
# using getopts to process commandline options.
# from: http://rsalveti.wordpress.com/2007/04/03/bash-parsing-arguments-with-getopts/

# Argument = -t test -r server -p password -v

usage()
{
cat << EOF
usage: $0 options

This script runs either test1 or test2 over a machine.

OPTIONS:
   -h   Show this message
   -t   Test type, can be ‘test1′ or ‘test2′
   -r   Server address
   -p   Server root password
   -v   Verbose
EOF
}

TEST=
SERVER=
PASSWD=
VERBOSE=
while getopts “ht:r:p:v” OPTION
do
    case $OPTION in
        h)
            usage
            exit 1
            ;;
        t)
            TEST=$OPTARG
            ;;
        r)
            SERVER=$OPTARG
            ;;
        p)
            PASSWD=$OPTARG
            ;;
        v)
            VERBOSE=1
            ;;
        ?)
            usage
            exit
            ;;
    esac
done

# Test that we've got all the parameters we need
if [[ -z $TEST ]] || [[ -z $SERVER ]] || [[ -z $PASSWD ]]
then
    usage
    exit 1
fi
