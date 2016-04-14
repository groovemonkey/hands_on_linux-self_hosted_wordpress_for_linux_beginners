Let's explore some of the power that the command line gives us.
Create your own small purpose-built 'programs' -- things you string together from existing programs and shell commands.


##################
hidden files and directories

ls
ls -alh # .EVILHACKERFILE_bwaaahahahahaaa


############################
input and output redirection
    echo "hi there" > logfile.log  # mistake! will overwrite each time
    echo "hi again" >> logfile.log

######################
we need dynamic stuff! Command substitution:
    echo "$(/bin/date) - Checking in."

#######
AND, OR
"hi there" && (AND IF THAT WORKS) echo "Done" >> success.log

boodlehoffer || echo "no such command, dude" >> failure.log
ls -alh || echo "list failed" >> failure.log


#####
grep - search for stuff and only print out matching lines

grep "addr" /etc/network/interfaces


######
pipes -- tie together multiple commands
got a command? Want to refine, sort, or continue doing stuff to its output? Use a pipe (or multiple pipes!)

grep "addr" /etc/network/interfaces | grep 192




