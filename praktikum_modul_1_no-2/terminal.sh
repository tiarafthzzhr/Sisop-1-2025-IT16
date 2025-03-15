#!/bin/bash

printf " /__\  (  _ \ / __)  /__\  ( ___)  /__\                         \n"
printf "/(__)\  )   /( (__  /(__)\  )__)  /(__)\                        \n"
printf "(__)(__)(_)\_) \___)(__)(__)(____)(__)(__)                      \n"
printf "Hello there!, wonderful people\n"
printf "\n"

echo "Welcome to the jungle!"

CRON_JOBS="/scripts"

echo "1. Sign up (Creating new credentials for player)"
echo "2. Already have an account? Log in here"
echo "3. So, have you played the game and are you cooked? Exit here.."

read -p "Enter the option [1-3]: " option

case "$option" in
	1)
		./register.sh
		;;
	2)
		./login.sh
		;;
	3)
		echo "Leaving this world... hope you are satisfied, see you soon!"
		exit 0
		;;
	*)
		echo "Invalid option. Please enter a valid number (1-3)."
		;;
esac 

