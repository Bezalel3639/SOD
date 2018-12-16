echo "Git Bash version: ${BASH_VERSION}..."

function getSoD {
    linefound=$1	
    n="$(expr index "$linefound" '>')"
    subsr=${linefound:$n} #<a href='/3444'>3444</a>
    sod=`echo "$subsr" | sed 's/<\/\?[^>]\+>//g'` #OK, 3444

    if [ "$sod" = 3168 ]; then
        echo "Number: $2, SoD: $sod" >> results.txt
    fi
}

function findLine {
    while read LINE; 
    do
    ((count++))
    if [[ "$LINE" =~ "Sum of divisors" ]]; then 
        focusLineNumber=$((count + 1)) 
    fi

    if [ "$count" = "$focusLineNumber" ]; then 
        getSoD "$LINE" "$1"
    fi
    done < fpage
}

function getWebData {
    wget -O fpage "http://www.numberempire.com/$1"
}

for DIGIT1 in {0..9} 
do
    for DIGIT2 in {0..9} 
    do
        for DIGIT3 in {0..9} 
        do
            for DIGIT4 in {0..9} 
            do
                echo "The number: $DIGIT1$DIGIT2$DIGIT3$DIGIT4"
                getWebData "$DIGIT1$DIGIT2$DIGIT3$DIGIT4"
                findLine "$DIGIT1$DIGIT2$DIGIT3$DIGIT4"
            done
        done
    done
done