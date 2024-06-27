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
makeLogs
currentdate=$(date +"%Y-%m-%d %H:%M:%S")
echo $currentdate