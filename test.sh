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

makeAnswer(){
    if [ -f AnswerFile.txt ]; then 
    rm -rf AnswerFile.txt
    touch AnswerFile.txt
    else
    touch AnswerFile.txt
    fi
}

randomQuestion(){
    question=1
    lines=( 1 7 13 )
    alines=(2 8 14)
    blines=(3 9 15)
    clines=(4 10 16)
    dlines=(5 11 17)
    i=0
    makeAnswer
    while [ $question -le 3 ]; do
        timer=10
        sec=$SECONDS
        rand=$((RANDOM%${#lines[@]}))
        current="${lines[$rand]}"
        unset lines[$rand]
        lines=("${lines[@]}")
        seds=`sed -n "$current, $((current + 5))p" < QuestionBank.txt`
        while [ $timer -gt 0 ]; do
            clear
            echo "Time Remaining: ${timer} Seconds"
            echo
            echo -n "$question. "
            sed -n "$current, $((current + 5))p" < QuestionBank.txt 
            read -t 1 -n 1 answer  && break
            duration=$((10 - $sec))
            (( timer-- ))
        done
        question=$(( question + 1 ))
        echo $seds >> AnswerFile.txt 
        sed -i 's/\s\+\[\+/\n[/g' AnswerFile.txt
        echo >> AnswerFile.txt
        if [ $answer == "a" ]; then
        sed -i "${alines[$i]}s/$/ -> You Answered this Question in $duration Seconds/" AnswerFile.txt
        elif [ $answer == "b" ]; then
        sed -i "${blines[$i]}s/$/ -> You Answered this Question in $duration Seconds/" AnswerFile.txt
        elif [ $answer == "c" ]; then
        sed -i "${clines[$i]}s/$/ -> You Answered this Question in $duration Seconds/" AnswerFile.txt
        elif [ $answer == "d" ]; then
        sed -i "${dlines[$i]}s/$/ -> You Answered this Question in $duration Seconds/" AnswerFile.txt
        fi
        (( i++ ))
    done
}

makeDatabase
makeLogs
currentdate=$(date +"%Y-%m-%d %H:%M:%S")
echo $currentdate
arrayRandom
randomQuestion