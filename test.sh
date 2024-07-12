cd Data\

makeDatabase(){
    if [ ! -f Database.txt ]; then
    touch Database.txt
    echo "Username || Password" >> Database.txt
    else
    echo "File Exists"
    fi
}

makeLogs(){
    if [ ! -f logs.log ]; then
    touch logs.log 
    else 
    echo "File Exists"
    fi
}

arrayRandom(){
    lines=("1" "7" "13")
    echo ${lines[@]}
    echo ${!lines[@]}
    rand=$((RANDOM%${#lines[@]}))
    echo $rand
    unset lines[$rand]
    lines=("${lines[@]}")
    echo ${lines[@]}
    echo ${!lines[@]}
}

randomQuestion(){
    question=1
    lines=( 1 7 13 )
    while [ $question -le 3 ]; do
        timer=10
        rand=$((RANDOM%${#lines[@]}))
        current="${lines[$rand]}"
        unset lines[$rand]
        lines=("${lines[@]}")
        while [ $timer -gt 0 ]; do
            clear
            echo "Time Remaining: ${timer} Seconds"
            echo
            echo -n "$question. "
            sed -n "$current, $((current + 5))p" < QuestionBank.txt 
            read -t 1 -n 1 answer  && break
            echo
            (( timer-- ))
        done
        question=$(( question + 1 ))
    done
}

makeDatabase
makeLogs
currentdate=$(date +"%Y-%m-%d %H:%M:%S")
echo $currentdate
arrayRandom
randomQuestion