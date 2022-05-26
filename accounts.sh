#!/bin/bash

# this is a comment

echo 'hey!'

echo "HEY"

# variables

NAME='var abd'

echo $NAME

echo "${NAME} is expanded within string"

#username
id -un

whoami

echo $UID

#store command output to a var
USERNAME=$(id -un)

USERNAME=`id -un`

echo "$USERNAME is me"

if [[ "$USERNAME" = 'abdalmassi' ]] #space around `=` is important! 
then
    echo 'eq'
else
    echo 'not eq'
fi

chmod -R 755 .
chmod -R +x .


# ${?} holds exit status of the last executed command

if [[ "${?}" -eq 0 ]] 
then
    echo "last command succeeded!"
    exit 1
    elif [[${?} = 1]] 
    then
        echo "falied!" >&2 #redirect to stderr
fi

#if `==` is used inside `if`, the RHS operand is apattern
#while with `=`, it's exact matching. However, some ppl use it just like in programming langs


#read input from user with -p prompt -c comment -m/--create-home create user's home directory
read -p "Enter something: " INPUT
echo $INPUT


#add user with -comment -create-home-directory
sudo useradd abd -c -m #or --create-home

#take pwd from pipe
echo $P{PASSWORD} | passwd --stdin ${USERNAME}

#change pwd -expire 
passwd -e ${USERNAME}

#switch user - dash is for login shell
sudo su - abd #or
sudo su -l abd

#process table - all procs
ps -ef

#predefined vars
echo ${PATH} ${HOME} ${TERM} ${PWD}

#hash dates to creater pwds
#pipe turns preceding command output into std input of the following one
date +%s | sha256sum #pass unix epoch/timestamp to checksum

#print first line/char of input (file, pipe, etc.)
echo "testing" | head n1
echo "testing" | head c1

PASSWORD=$(date +%s%N${RANDOM} | sha256sum | head -c48)


#better passwd with chars

SYMBOLS="@$%^&*!()_+"
echo "${SYMBOLS}" | fold -w1 | shuf | head c1

#positional params
echo "you executed this command: ${0}, with first param ${1}"

#clear/remove hash table of commands paths
hash -r

basename ${HOME}/Desktop/test.txt

dirname .

#for loop
for VAR in Me You Them
do
    echo "Hi ${VAR}!"
done

#while loop
VAR1=1
while [[ $VAR1 -eq 1 ]]
do
    echo 'a'
    VAR1=2
done


#variable for list of passed params
${@}

#keyword true returns 0 success status
true

#sleep for 1 second
sleep 1

#sleep for 1 min and 5.5 seconds
sleep 1m 5.5s

#shift positional params by two positions
shift 2

#stdin comes from/to a file
FILE="/tmp/data"
head n1 /etc/passwd > ${FILE} #create or overwrite
head n1 /etc/passwd >> ${FILE} #append

#pipes and output redirection
date | sha256sum | head -c10 >> passwordFile

#file descriptors (pointers to sources of data): everything in linux is a file: keyboard, screen, etc.
# FD0 => stdin
# FD1 => stdout
# FD2 => stderr

read X < /etc/passwd #by default stdin is assumed 0
#is equivalent to
read X 0< /etc/passwd

echo "test" > file #by default stdout is assumed 1
#is equivalent to
echo "test" 1> file

#redirect stderror to a file
head -n1 /etc/passwd /fakefile 2> error_log.txt # 2 is stderr

head -n1 /etc/passwd /fakefile > output_log.txt 2>> error_log.txt #redirect errors and output to different files

#send both stdout and stderr to the same file
head -n1 /etc/passwd /etc/hosts /fakefile > both_log 2>&1 # &1 represents stdout and 2>&1 appends stderr to stdout
#or equivalently:
head -n1 /etc/passwd /etc/hosts /fakefile &> both_log

#stderr with pipes
head -n1 /etc/passwd /fakefile |& cat -n

#discard stdout (using null device)
head -n1 /etc/passwd /fakefile > /dev/null

#discard stderr
head -n1 /etc/passwd /fakefile 2> /dev/null

#discard both
head -n1 /etc/passwd /fakefile &> /dev/null



case $VAR in
    1) echo 1
    ;;
    2|3) echo 2 or 3
    ;;
    stat*) echo state or status or ...
    ;;
    *) echo default
    ;;
esac


#line continuation with backslash
./mybash.sh arg1\


#functions
function myfunc
{
    #set of commands...
    local FILE="${1}"
    if [[-f "${FILE}"]] #check file exists
    then
        exit 1
    fi
}

#or shorter

log() {
    local MSG="${@}" #local to function

    echo ${MSG}
    return 0 #use "return" in funcs because "exit" exists the whole script
}

#call the function
readonly VAR='Hi!' #const vars preferred in global scope
myfunc "${VAR}"
if [["${?}" -eq '0']] 
then
    log 'succeeded'
fi

#syslog (supports remote network logging)
logger -t mytag "${MSG}" #logs to /var/log/messages


#getopts








#stop execution with status(0 => successful, non-zero => failure)
exit 0

