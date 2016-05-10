# Slightly More Advanced Basic Bash

Let's explore some of the power that the command line gives us.
Create your own small purpose-built 'programs' -- things you string together from existing programs and shell commands.


## Hidden files and directories

    ls
    ls -alh # .EVILHACKERFILE_bwaaahahahahaaa


## Input and Output redirection
    echo "hi there" > logfile.log  # mistake! will overwrite each time
    echo "hi again" >> logfile.log

## We need dynamic stuff! Command substitution:
    echo "$(/bin/date) - Checking in."

## AND, OR
    # AND (&&)
    "hi there" && (AND IF THAT WORKS) echo "Done" >> success.log

    # OR (||)
    boodlehoffer || echo "no such command, dude" >> failure.log
    ls -alh || echo "list failed" >> failure.log


## grep
search for stuff and only print out matching lines

    grep "addr" /etc/network/interfaces


## Pipes -- tie together multiple commands
Got a command? Want to refine, sort, or continue doing stuff to its output? Use a pipe (or multiple pipes!)

    grep "addr" /etc/network/interfaces | grep 192




