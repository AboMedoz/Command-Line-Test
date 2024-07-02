
mkdir Data
cd Data\

makeDatabase(){
    if [ ! -f Data/Database.txt ]; then
    touch Database.txt
    echo "Username || Password" >> Database.txt
    else
    echo "File Exists"
    fi
}

makeLogs(){
    if [ ! -f Data/logs.log ]; then
    touch logs.log 
    else 
    echo "File Exists"
    fi
}
makeDatabase
makeLogs
currentdate=$(date +"%Y-%m-%d %H:%M:%S")
echo $currentdate