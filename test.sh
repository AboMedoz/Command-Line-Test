makeDatabase(){
    if [ ! -f Database.txt ]; then
    touch Database.txt
    echo "Username || Password" >> Database.txt
    else
    echo "File Exists"
    fi
}
makeDatabase