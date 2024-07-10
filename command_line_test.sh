#!/bin/bash

currentdate=$(date +"%Y-%m-%d %H:%M:%S")
cd Data/
echo "Command Line Test"

takeTest(){
    linenumber=1
    while [ $linenumber -lt 18 ]
    do
    #TODO TIMER
    sed -n "$linenumber, $(( linenumber + 5 ))p" < QuestionBank.txt
    echo -n "Please choose an Answer: "
    read answer
    echo
    linenumber=$(( linenumber + 6 ))
    done
}

viewTest(){
    echo "TODO"
    #TODO
}

featureScreen(){
    echo 
    echo "1. Take a Test"
    echo "2. View your Test"
    echo "3. Exit"
    echo
    echo -n "Please choose an Option: "
    read featureoption 
    echo
    if [ $featureoption -eq 1 ]; then
    takeTest
    elif [ $featureoption -eq 2 ]; then 
    viewTest
    else
    exit
    fi
}

signIn(){
    usernameValidation(){
        echo -n "Username: "
        read enteredusername
        if ! grep -wq "$enteredusername" Database.txt; then 
        echo "Username is incorrect!, Please Try Again"
        usernameValidation
        fi
    }
    passwordValidation(){
        echo -n "Password: "
        read -s enteredpassword
        echo
        if ! grep -xwq "$enteredusername || $enteredpassword" Database.txt; then
        echo "Wrong Password! Please Try Again"
        passwordValidation
        fi
    }
    usernameValidation
    passwordValidation
    featureScreen 
}

makeLogs(){
    if [ ! -f logs.log ]; then
    touch logs.log
    fi
}

makeDatabase(){
    if [ ! -f Database.txt ]; then
    touch Database.txt
    echo "Username || Password" >> Database.txt
    echo "$currentdate | Database Created." >> logs.log
    fi
}

signUp(){
    makeDatabase
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
    echo "$currentdate | Script Exited " >> logs.log
    read $1
}

main(){
    makeLogs
    echo "$currentdate | Script Invoked" >> logs.log
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
    echo
    if [ $option -eq 1 ]; then
    signIn
    elif [ $option -eq 2 ]; then
    signUp
    else 
    echo "$currentdate | Script Exited " >> logs.log
    exit
    fi
}
main
