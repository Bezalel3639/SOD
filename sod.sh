echo "Git Bash version: ${BASH_VERSION}..." >> log.txt
echo "$(LC_ALL=en.US.utf8 date +"%b. %d, %Y %H:%M:%S")" >> log.txt

function getSoD {
    linefound=$1	
    n="$(expr index "$linefound" '>')"
    subsr=${linefound:$n} #<a href='/3444'>3444</a>
    sod=`echo "$subsr" | sed 's/<\/\?[^>]\+>//g'` #OK, 3444

    if [ "$sod" = 5184 ]; then
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

function LogProgress {
    echo "Number: $1, Time: $(LC_ALL=en.US.utf8 date +"%H:%M:%S")" >> log.txt
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
                NUMBER="$DIGIT1$DIGIT2$DIGIT3$DIGIT4"

                echo "The number: $NUMBER"
                getWebData "$NUMBER"
                findLine "$NUMBER"
                
                if [ "$NUMBER" = 1000 ]; then 
                    LogProgress 1000
                fi
                if [ "$NUMBER" = 2000 ]; then 
                    LogProgress 2000
                fi
                if [ "$NUMBER" = 3000 ]; then 
                    LogProgress 3000
                fi
                if [ "$NUMBER" = 4000 ]; then 
                    LogProgress 4000
                fi
                if [ "$NUMBER" = 5000 ]; then 
                    LogProgress 5000
                fi
                if [ "$NUMBER" = 6000 ]; then 
                    LogProgress 6000
                fi
                if [ "$NUMBER" = 7000 ]; then 
                    LogProgress 7000
                fi
                if [ "$NUMBER" = 8000 ]; then 
                    LogProgress 8000
                fi
                if [ "$NUMBER" = 9999 ]; then 
                    LogProgress 9999
                fi
            done
        done
    done
done