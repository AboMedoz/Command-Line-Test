#!/bin/bash
echo "Command Line Test"

signIn(){
    echo "TODO"
    #TODO
}

signUp(){
    echo "Sign Up Screen"
    echo
    echo -n "Please choose a Username: "
    read username 
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
    fi
    }
    reEnterPassword(){
    echo -e -n "Please \033[37;47m re enter \033[0m Password: "
    read -s rentered
    echo
    }
    enterPassword
    reEnterPassword
    if [ $password != $rentered ]; then
    echo "Passwords Don't Match please re-enter"
    reEnterPassword
    fi
    echo -n "Registeration Successful. Please enter any Key to continue. "
    read $1
    #save the data to a file maybe json? TODO 
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
    Exit
    fi
}
main
