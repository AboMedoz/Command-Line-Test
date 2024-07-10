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

readFile(){
    linenumber=1
    while  [ $linenumber -lt 18 ]; do
        sed -n "$linenumber, $((linenumber + 5))p" < QuestionBank.txt
        read answer
        echo
        linenumber=$((linenumber + 6))
    done
}

makeDatabase
makeLogs
currentdate=$(date +"%Y-%m-%d %H:%M:%S")
echo $currentdate
readFile
