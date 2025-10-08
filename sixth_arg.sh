#!/bin/bash

read -p "Please enter your name " name
read -p "Enter your Age " age
echo ${name}
echo ${age}
read -p "Enter your Password" -s pass
echo "Your Password is :- ${pass}"

