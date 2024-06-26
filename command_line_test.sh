#!/bin/bash
echo "Command Line Test"

signIn(){
    echo -n "Username: "
    read enteredusername
    echo -n "Password: "
    read -s enterdpassword
    echo
}

makeDatabase(){
    touch Database.txt
    echo "Username || Password" >> Database.txt
}

signUp(){
    if [ ! -f Database.txt ]; then
    makeDatabase
    fi
    echo "Sign Up Screen"
    echo
    enterUsername(){
    echo -n "Please choose a Username: "
    read username 
    if  grep -wq "$username" Database.txt; then
    echo -e "\033[0;31mUsername $username already Exists!, Please choose another Username \033[0m"
    enterUsername
    fi
    }
    enterUsername
    #if the whole keyboard is alphanumeric then there isn't anything to check for
    enterPassword(){
    echo -n "Enter a Password: "
    read -s password
    echo
    if (( ${#password} < 8 )); then
    echo "Too short"
    enterPassword
    elif [[ $password != *[[:digit:]]* ]]; then
    echo "Password should contain at least one Digit"
    enterPassword  
    elif [[ $password != *[#$\&~@^]* ]]; then
    echo "Password should at least include one Symbol" 
    enterPassword 
    fi
    }
    reEnterPassword(){
    echo -e -n "Please \033[37;47m re enter \033[0m Password: "
    read -s rentered
    echo
    if [ $password != $rentered ]; then
    echo "Passwords Don't Match please re-enter"
    reEnterPassword
    fi
    }
    enterPassword
    reEnterPassword
    echo
    echo "$username || $password" >> Database.txt
    echo -n "Registeration Successful. Please enter any Key to continue. "
    read $1
}

main(){
    echo "Please chose one of the Below Options: "
    echo
    echo "1. Sign In"
    echo "2. Sign Up"
    echo "3. Exit"
    echo
    echo "Note: Script Timeout is set"
    echo -n "Please choose an Option: "
    #timeout  --kill-after=10s TODO
    read option
    if [ $option -eq 1 ]; then
    signIn
    elif [ $option -eq 2 ]; then
    signUp
    else 
    exit
    fi
}
main
