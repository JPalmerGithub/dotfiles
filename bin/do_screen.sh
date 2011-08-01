#!/bin/bash
#===============================================================================
#
#          FILE:  do_screen.sh
# 
#         USAGE:  ./do_screen.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Ben Lutgens (), blutgens@mmm.com blutgens@gmail.com
#       COMPANY:  3M Unix Production Support
#       VERSION:  1.0
#       CREATED:  11/21/2007 02:26:47 PM CST
#      REVISION:  ---
#===============================================================================


# filters the screen -ls output to show the sesssions
sessions=`screen -ls | sed -ne 's/[[:space:]]//' -ne 's/\((Attached)\|(Detached)\)// p'`
res=`echo "$sessions" | wc -w`

if [[ "$res" == "0" ]]
then
        echo "  No existing SCREEN session to reattach to..."
        exit
fi

echo ''
echo "  CURRENT SESSIONS"
echo "  ------------------------"
echo "$sessions" | cat -n
echo "  ------------------------"
echo ''

#if first argument is not specified, script will ask for number of screen

if [ -z $1 ]
then
        echo -n "  Reattach to session: "
        read session
else
        session=$1
fi


#attach to specified session
linenum=0
name=`screen -ls | sed -ne 's/[[:space:]]//' -ne 's/\((Attached)\|(Detached)\)// p' |
while read line
do
 let "linenum += 1"
 if [[ "$linenum" -eq "$session" ]]
 then
        echo $line
        break
 fi
done`

if [[ "$name" != "" ]]
then
   screen -d -r "$name"
else
   echo "  Could not reattach to '$session'"
fi

