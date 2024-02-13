#!/bin/bash
declare -i RES=1000
declare -i NUM=1000
declare -a NUMS

touch temp.txt
INFO="temp.txt"

while getopts "o:n:d" opt; do
    case $opt in
        o)
            case $OPTARG in
                "+"|"-"|"*"|"/"|"%")
                    OP=$OPTARG
                    ;;
                *)
                    echo "Incorrect Operation"
                    ;;
            esac
            ;;
        n)
            NUMS+=("$OPTARG")
            ;;
        d)
            echo "USER: $(whoami)" >> $INFO
            echo "SCRIPT: $0" >> $INFO
            echo "OPERATION: $OP" >> $INFO
            echo "NUMBERS: ${NUMS[*]}" >> $INFO
            ;;
    esac
done

case $OP in
    "+"|"-")
        RES=0
        ;;
    "*"|"/")
        RES=1
        ;;
    '%')
        RES=${NUMS[0]}
        ;;
    *)
        RES=500
        ;;
esac

RES=${NUMS[0]}
flag=0

for NUM in "${NUMS[@]}"; do
    if [ $flag -eq 0 ]; then
        flag=1
        continue
    fi

    case $OP in
        "+")
            RES=$((RES + NUM))
            ;;
        "-")
            RES=$((RES - NUM))
            ;;
        "/")
            RES=$((RES / NUM))
            ;;
        "*")
            RES=$((RES * NUM))
            ;;
        "%")
            RES=$((RES % NUM))
            ;;
    esac
done

echo "Result: $RES"
if [ -f $INFO ]; then
    cat $INFO
fi
rm temp.txt
