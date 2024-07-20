#!/bin/bash

echo "Command Line Test"
currentdate=$(date +"%Y-%m-%d %H:%M:%S")
cd Data/

makeAnswerFile(){
    if [  -f AnswerFile.txt ]; then
    rm -rf AnswerFile.txt
    touch AnswerFile.txt
    echo "$currentdate | Created AnswerFile.txt" >> logs.log
    else
    touch AnswerFile.txt
    fi
}

takeTest(){
    question=1
    lines=("1" "7" "13")
    alines=("2" "8" "14")
    blines=("3" "9" "15")
    clines=("4" "10" "16")
    dlines=("5" "11" "17")
    idx=0
    makeAnswerFile
    while [ $question -le 3 ];do
        timer=10
        randidx=$((RANDOM%${#lines[@]}))
        current=${lines[$randidx]}
        unset lines[$randidx]
        lines=("${lines[@]}")
        seds=`sed -n "$current, $((current + 5))p" < QuestionBank.txt`
        while [ $timer -gt 0 ];do
            clear
            echo "Time Remaining: ${timer} Seconds"
            echo
            echo -n "$question. "
            sed -n "$current, $((current + 5))p" < QuestionBank.txt
            echo -n "Please Choose an Option: "
            read -t 1 -n 1 answer && break
            duration=$((10 - $timer))
            (( timer-- ))
        done
        (( question++ ))
        echo $seds >> AnswerFile.txt
        sed -i 's/\s\+\[\+/\n[/g' AnswerFile.txt
        echo >> AnswerFile.txt
        if [ $answer == "a" ]; then
        sed -i "${alines[$idx]}s/$/ -> You Answered this Question in $duration Seconds/" AnswerFile.txt
        elif [ $answer == "b" ]; then
        sed -i "${blines[$idx]}s/$/ -> You Answered this Question in $duration Seconds/" AnswerFile.txt
        elif [ $answer == "c" ]; then
        sed -i "${clines[$idx]}s/$/ -> You Answered this Question in $duration Seconds/" AnswerFile.txt
        elif [ $answer == "d" ]; then
        sed -i "${dlines[$idx]}s/$/ -> You Answered this Question in $duration Seconds/" AnswerFile.txt
        fi
        (( idx++ ))
    done
    echo
    echo
    echo "Test Done you will be Logged Off shortly."
    sleep 3
    clear
    exit
}

viewTest(){
    cat AnswerFile.txt
}

featureScreen(){
    echo "My Command Line Test"
    echo 
    echo "1. Take a Test"
    echo "2. View your Test"
    echo "3. Exit"
    echo
    echo -n "Please choose an Option: "
    read featureoption 
    clear
    if [ $featureoption -eq 1 ]; then
    takeTest
    elif [ $featureoption -eq 2 ]; then 
    viewTest
    else
    exit
    fi
}

signIn(){
    echo "My Command Line Test"
    echo
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
    clear
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
    echo 'My Command Line Test'
    echo
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
    clear
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
    echo
    echo -n "Please choose an Option: "
    read -t 10 option 
    clear
    if [ -z $option ];then
    echo "$currentdate || Script Exited" >> logs.log
    exit
    fi
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
