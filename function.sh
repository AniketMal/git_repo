#!bin/bash

#a=10
#b=20
echo "Enter First No:" 
read a
echo "Enter Second No:"  
read b
echo -e "First No: $a \nSecond No: $b"
echo "------------------------------------------------"
addition()
{
	echo "Executing ${FUNCNAME} --- START---"
	c=$((${a}+${b}))
	echo "Addtion is ${c}"
	echo "Executing ${FUNCNAME} --- END---"
}
addition

echo "------------------------------------------------"
substraction()
{
	c=$((${a}-${b}))
	echo "Substcation is ${c}"
	addition
}
substraction

echo "------------------------------------------------"
multiplication()
{
	c=$((${a}*${b}))
	echo "Multiplication is ${c}"
}
multiplication

echo "------------------------------------------------"


division()
{
	c=$((${a}/${b}))
	echo "Division is ${c}"
}
division

echo "------------------------------------------------"
addition
substraction
multiplication
substraction
addition
