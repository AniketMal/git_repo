#!/bin/bash
name="Shree Swami"
othername="Shree Swami"

if [[ -n ${name} ]]
then
    echo "length of string is non zero"
    echo "String Name:- ${name}"

else
    echo "length of string is zero"
fi

if [[ -z ${name} ]]
then
    echo "length of string is zero -two"
else
    echo "length of string is non zero. = two"
fi

if [[ ${name} == ${othername} ]]
then
    echo "both string are equals - three"
else
    echo "both string are not equals. - three"
fi

if [[ ${name} != ${othername} ]]
then
    echo "both string are not equals -four"
else
    echo "both strings are equals -four"
fi

echo "I am Here"
