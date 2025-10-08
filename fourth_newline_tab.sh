#!/bin/bash
# owner: Gaurav
# purpose: print some echo commands
echo this is Aniket Malunjkar  # in line comment
echo 'this is our fourth                 shellscript' # one more comment 
# this is an another comment in shell script.
# echo -e "\033[0;31m fail message # here" # this is one more comment
# echo -e "\033[0;32m success message #  here"
# echo -e "\033[0;33m warning message here"
echo "my 
name 
is Aniket"

echo "
########### Script Starting ########
purpose: going to install nginx 
####################################
"
# strong quotes.
echo 'my \
name \ 
is \
Aniket'   # Escape character \ taken literally because of strong quoting.

echo " my \
name \ 
is \
Aniket \
" # Newline escaped.
echo -e "\033[0;31m this is Aniket \t Malunjkar \t test name"
echo -e "\033[0;32m this is Aniket \v Malunjkar \v test name"
echo -e "\033[0;33m this is Aniket \n Malunjkar \n test name"
