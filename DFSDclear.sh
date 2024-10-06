#!/bin/bash
run () {
xdotool search --name 'Firestone' windowactivate sleep 0.1
WID=$(xdotool getactivewindow)
    reps=$1           
    startingServer=$2
    lvl=$3           
    guardianNo=$4   
    
    IFS=';' read -r alchemyDB alchemyDust alchemyCoins <<< "$5"

    IFS=';' read -r fsTree fs1 fs2 <<< "$6"
     
    switchingServer=$7
    

for (( i=1; i<=reps; i++ ))
do
    SECONDS=0
    reset
    xdotool sleep 0.1
    guardian "$guardianNo"
    xdotool sleep 0.1
    mapFinish
    xdotool sleep 0.1
    mapStart
    xdotool sleep 0.1
    
    if [ "$lvl" -ge 50 ]; then
        xdotool sleep 0.1
        campaignLoot
        xdotool sleep 0.1
        engi
    fi
    
    if [ "$lvl" -ge 200 ]; then
        xdotool sleep 0.1
        oracle
        xdotool sleep 0.1
    fi
    
    if [ "$lvl" -ge 120 ]; then
        xdotool sleep 0.1
        alchemy "$alchemyDB" "$alchemyDust" "$alchemyCoins"
        xdotool sleep 0.1
    fi
    
    if [ "$lvl" -ge 15 ]; then
        tavern
        xdotool sleep 0.1
    fi
    
    if [ "$lvl" -ge 10 ]; then
        exped
        xdotool sleep 0.1
	if [ "$fsTree" -ne 0 ]; then
        	lib "$fsTree" "$fs1" "$fs2"
        	xdotool sleep 0.1
	fi
    fi
    xdotool sleep 0.1
    if [ "$switchingServer" -ne 0 ]; then
        switchingLvl=$8           
        switchingGuardian=$9   
        IFS=';' read -r switchingAlchemyDB switchingAlchemyDust switchingAlchemyCoins <<< "$10"
        IFS=';' read -r switchingFsTree switchingFs1 switchingFs2 <<< "$11"
    	serverSwap "$switchingServer"

        xdotool sleep 0.1
	guardian "$switchingGuardian"
        xdotool sleep 0.1
	mapFinish
        xdotool sleep 0.1
	mapStart
        xdotool sleep 0.1
	if [ "$switchingLvl" -ge 50 ]; then
	    xdotool sleep 0.1
            campaignLoot
            xdotool sleep 0.1
            engi
            xdotool sleep 0.1
        fi
    
        if [ "$switchingLvl" -ge 200 ]; then
            xdotool sleep 0.1
            oracle
            xdotool sleep 0.1
        fi
    
        if [ "$switchingLvl" -ge 120 ]; then
            xdotool sleep 0.1
            alchemy "$switchingAlchemyDB" "$switchingAlchemyDust" "$switchingAlchemyCoins"
            xdotool sleep 0.1
	fi
    
	if [ "$switchingLvl" -ge 15 ]; then
            xdotool sleep 0.1
            tavern
            xdotool sleep 0.1
	fi
    
	if [ "$switchingLvl" -ge 10 ]; then
            xdotool sleep 0.1
            exped
            xdotool sleep 0.1
            lib "$switchingFsTree" "$switchingFs1" "$switchingFs2"
            xdotool sleep 0.1
	fi
    
        serverSwap "$startingServer"
    fi
done

echo "$SECONDS"

}

alchemy () {
if [ $(($1+$2+$3)) -ne 0 ]; then
	xdotool key --window "$WID" a sleep 0.4
	if [ "$1" -eq 1 ]; then
		xdotool mousemove --window "$WID" 950 800 sleep 0.2 click --window "$WID" 1 sleep 0.1
	fi
	if [ "$2" -eq 1 ]; then
		xdotool mousemove --window "$WID" 1300 800 sleep 0.2 click --window "$WID" 1 sleep 0.1
	fi
	if [ "$3" -eq 1 ]; then
		xdotool mousemove --window "$WID" 1650 800 sleep 0.2 click --window "$WID" 1 sleep 0.1
	fi
fi
reset
}

campaignLoot () {
xdotool mousemove --window "$WID" 1836 610 sleep 0.2 click --window "$WID" 1 sleep 0.1
xdotool mousemove --window "$WID" 157 1004 sleep 0.2 click --window "$WID" 1 sleep 0.1
xdotool sleep 0.25
reset
}

engi () {
	xdotool mousemove --window "$WID" 1860 212 sleep 0.2 click --window "$WID" 1 sleep 0.1
	xdotool mousemove --window "$WID" 1280 830 sleep 0.2 click --window "$WID" 1 sleep 0.1
	xdotool mousemove --window "$WID" 580 539 sleep 0.2 click --window "$WID" 1 sleep 0.1
	xdotool mousemove --window "$WID" 1625 720 sleep 0.2 click --window "$WID" 1 sleep 0.1
xdotool sleep 0.25
reset
}

exped () {
xdotool mousemove --window "$WID" 1856 469 sleep 0.2 click --window "$WID" 1 sleep 0.1
xdotool mousemove --window "$WID" 334 376 sleep 0.2 click --window "$WID" 1 sleep 0.1
xdotool mousemove --window "$WID" 1325 317 sleep 0.2 click --window "$WID" --repeat 2 --delay 250 1 sleep 0.1
xdotool sleep 0.25
reset
}

guardian () {
xdotool key --window "$WID" g sleep 0.4
let gindex=$1-1
temp=$(getSingleRowElement "$gindex" "${guardianPos[@]}")
IFS=';' read -r guardianX guardianY <<< "$temp"

xdotool mousemove --window "$WID" "$guardianX" "$guardianY" sleep 0.2 click --window "$WID" 1 sleep 0.1
xdotool mousemove --window "$WID" 1160 800 sleep 0.2 click --window "$WID" 1 sleep 0.1
xdotool sleep 0.25

reset
}

lib () {
xdotool key --window "$WID" L sleep 0.4
xdotool mousemove --window "$WID" 1800 630 sleep 0.2 click --window "$WID" 1 sleep 0.1
xdotool mousemove --window "$WID" 1 1 sleep 0.2 click --window "$WID" --repeat 2 --delay 0.05 1
xdotool mousemove --window "$WID" 1270 990 sleep 0.2 click --window "$WID" 1 sleep 0.1
xdotool mousemove --window "$WID" 1 1 sleep 0.2 click --window "$WID" --repeat 2 --delay 0.05 1
xdotool mousemove --window "$WID" 590 990 sleep 0.2 click --window "$WID" 1 sleep 0.1
xdotool mousemove --window "$WID" 1 1 sleep 0.2 click --window "$WID" --repeat 2 --delay 0.05 1
fsPattern=$(($1 % 3))
let fsNode1=$2-1
let fsNode2=$3-1
temp=$(getMatrixElement "$fsPattern" "$fsNode1" 16 "${fsTree[@]}")
IFS=';' read -r fsCol1 fsRow1 <<< "$temp"
fsCol1Index=$((fsCol1-1))
fsRow1Index=$((fsRow1-1))
temp=$(getMatrixElement "$fsPattern" "$fsNode2" 16 "${fsTree[@]}")
IFS=';' read -r fsCol2 fsRow2 <<< "$temp"
fsCol2Index=$((fsCol2-1))
fsRow2Index=$((fsRow2-1))

xdotool sleep 0.2 click --window "$WID" --repeat 120 --delay 1 4 sleep 0.1
xdotool sleep 0.2 click --window "$WID" --repeat "$(getSingleRowElement "$fsCol1Index" "${fsScrollsPerColumn[@]}")" --delay 1 5 sleep 0.1
t=$(max $(($fsCol1-6)) 0)
xdotool mousemove --window "$WID" "$((20+t*460))" "$(getSingleRowElement "$fsRow1Index" "${fsRows[@]}")" sleep 0.2 click --window "$WID" 1 sleep 0.1
xdotool mousemove --window "$WID" 750 790 sleep 0.2 click --window "$WID" 1 sleep 0.1
xdotool mousemove --window "$WID" 20 20 sleep 0.2 click --window "$WID" --repeat 2 --delay 250 1 sleep 0.1

xdotool sleep 0.2 click --window "$WID" --repeat 90 --delay 1 4 sleep 0.1
xdotool sleep 0.2 click --window "$WID" --repeat "$(getSingleRowElement "$fsCol2Index" "${fsScrollsPerColumn[@]}")" --delay 1 5 sleep 0.1
t=$(max $(($fsCol2-6)) 0)
xdotool mousemove --window "$WID" "$((20+t*460))" "$(getSingleRowElement "$fsRow2Index" "${fsRows[@]}")" sleep 0.2 click --window "$WID" 1 sleep 0.1
xdotool mousemove --window "$WID" 750 790 sleep 0.2 click --window "$WID" 1 sleep 0.1
xdotool mousemove --window "$WID" 20 20 sleep 0.2 click --window "$WID" --repeat 2 --delay 250 1 sleep 0.1
reset
}


mapFinish () {
xdotool key --window "$WID" M sleep 0.4
xdotool mousemove --window "$WID" 1900 1 sleep 0.251 mousedown --window "$WID" 1 sleep 0.251
xdotool mousemove --window "$WID" 1 1060 sleep 0.251 mouseup --window "$WID" 1 sleep 0.251
xdotool mousemove --window "$WID" 1 1080 sleep 0.251 mousedown --window "$WID" 1 sleep 0.251
xdotool mousemove_relative 790 -820 sleep 0.251 mouseup --window "$WID" 1 sleep 0.251
for k in {1..8};
do
    xdotool mousemove --window "$WID" 150 290 sleep 0.2 click --window "$WID" 1
    xdotool mousemove --window "$WID" 1410 800 sleep 0.2 click --window "$WID" 1
    xdotool mousemove --window "$WID" 1 1070 sleep 0.2 click --window "$WID" --repeat 3 --delay 250 1
done
}



mapStart () {
p=370
t=140
for k in {1..9};
do
    xdotool mousemove --window "$WID" "$p" "$t" sleep 0.2 click --window "$WID" 1 
    xdotool mousemove --window "$WID" 1070 900 sleep 0.2 click --window "$WID" 1 
    xdotool mousemove --window "$WID" 1920 10 sleep 0.05 click --window "$WID" 1
    s=t
    let t=s+96
done
s=t
let t=s-48
xdotool mousemove --window "$WID" "$p" "$t" sleep 0.2 click --window "$WID" 1 
xdotool mousemove --window "$WID" 1070 900 sleep 0.2 click --window "$WID" 1 
xdotool mousemove --window "$WID" 1920 10 sleep 0.2 click --window "$WID" 1
f=p
let p=f+96
for z in {1..8};
do
    t=150
    for k in {1..9};
    do
        xdotool mousemove --window "$WID" "$p" "$t" sleep 0.2 click --window "$WID" 1 
        xdotool mousemove --window "$WID" 1070 900 sleep 0.2 click --window "$WID" 1
        xdotool mousemove --window "$WID" 1920 10 sleep 0.2 click --window "$WID" 1
        s=t
        let t=s+96
    done
    s=t
    let t=s-48
    xdotool mousemove --window "$WID" "$p" "$t" sleep 0.2 click --window "$WID" 1 
    xdotool mousemove --window "$WID" 1070 900 sleep 0.2 click --window "$WID" 1 
    xdotool mousemove --window "$WID" 1920 10 sleep 0.2 click --window "$WID" 1
    f=p
    let p=f+98
done
for z in {1..5};
do
    t=150
    for k in {1..9};
    do
        xdotool mousemove --window "$WID" "$p" "$t" sleep 0.2 click --window "$WID" 1 
        xdotool mousemove --window "$WID" 1070 900 sleep 0.2 click --window "$WID" 1
        xdotool mousemove --window "$WID" 1920 10 sleep 0.2 click --window "$WID" 1
        s=t
        let t=s+96
    done
    f=p
    let p=f+96
done
}
oracle () {
xdotool key --window "$WID" o sleep 0.4
xdotool mousemove --window "$WID" 820 430 sleep 0.2 click --window "$WID" 1 sleep 0.1
xdotool mousemove --window "$WID" 1170 880 sleep 0.2 click --window "$WID" --repeat 2 --delay 250 1
xdotool mousemove --window "$WID" 1620 510 sleep 0.2 click --window "$WID" --repeat 2 --delay 250 1
xdotool mousemove --window "$WID" 1170 510 sleep 0.2 click --window "$WID" --repeat 2 --delay 250 1
xdotool mousemove --window "$WID" 1620 880 sleep 0.2 click --window "$WID" --repeat 2 --delay 250 1
xdotool sleep 0.25
reset
}

serverSwap () {
xdotool mousemove --window "$WID" 1840 50 sleep 0.2 click --window "$WID" 1
xdotool mousemove --window "$WID" 1500 620 sleep 0.2 click --window "$WID" 1
xdotool mousemove --window "$WID" 1300 170 sleep 0.2 click --window "$WID" 1

if [ "$1" -eq 1 ]; then
    xdotool mousemove 520 330 sleep 0.2 click --window "$WID" 1
elif [ "$1" -eq 2 ]; then
    xdotool mousemove 1300 330 sleep 0.2 click --window "$WID" 1
elif [ "$1" -eq 3 ]; then
    xdotool mousemove 520 520 sleep 0.2 click --window "$WID" 1
elif [ "$1" -eq 4 ]; then
    xdotool mousemove 1300 520 sleep 0.2 click --window "$WID" 1
elif [ "$1" -eq 5 ]; then
    xdotool mousemove 520 700 sleep 0.2 click --window "$WID" 1
elif [ "$1" -eq 6 ]; then
    xdotool mousemove 1300 700 sleep 0.2 click --window "$WID" 1
fi
    xdotool mousemove 1110 720 sleep 0.2 click --window "$WID" 1
xdotool sleep 20
reset
}


tavern () {
	xdotool mousemove --window "$WID" 1860 212 sleep 0.2 click --window "$WID" 1 sleep 0.1
	xdotool mousemove --window "$WID" 700 960 sleep 0.2 click --window "$WID" 1 sleep 0.1
	xdotool mousemove --window "$WID" 1720 50 sleep 0.2 click --window "$WID" 1 sleep 0.1
	xdotool mousemove --window "$WID" 500 570 sleep 0.2 click --window "$WID" 1 sleep 0.1
    xdotool sleep 0.25
    reset
}


getMatrixElement () {
    local row=$1        # Expecting the first argument to be row index
    local col=$2        # Expecting the second argument to be column index
    local cols=$3       # Expecting the third argument to be number of columns
    shift 3             # Shift off the first three parameters to get the matrix
    local matrix=("$@") # Remaining arguments are the matrix elements
    local index=$((row * cols + col))
    echo "${matrix[$index]}"
}

getSingleRowElement () {
    local col=$1            # Expecting the first argument to be column index
    shift                    # Shift to drop the column index from parameters
    local matrix=("$@")     # The remaining arguments are the matrix elements
    echo "${matrix[$col]}"  # Output the element at the specified column index
}

                                                              
declare -a fsRows=(
    "260" "400" "520" "640" "780"
)
declare -a fsScrollsPerColumn=(
    "6" "22" "39" "55" "72" "89" "89" "89"
)

declare -a fsTree=(
"1;1" "1;3" "1;5" "2;2" "2;4" "3;3" "4;3" "5;2" "5;4" "6;2" "6;4" "7;2" "7;4" "8;1" "8;3" "8;5" "1;3" "1;4" "2;1" "2;3" "2;5" "3;2" "3;4" "4;3" "5;2" "5;4" "6;3" "7;1" "7;3" "7;5" "8;2" "8;4" "1;3" "2;2" "2;4" "3;1" "3;3" "3;5" "4;3" "5;2" "5;4" "6;2" "6;4" "7;2" "7;4" "8;1" "8;3" "8;5"
)

declare -a guardianPos=(
    "1050;1000" "1200;1000" "750;100" "900;1000" 
)

reset () {
xdotool mousemove --window "$WID" 1840 50 sleep 0.2 click --window "$WID" --repeat 4 --delay 200 1
xdotool mousemove --window "$WID" 10 160 sleep 0.2 click --window "$WID" 1 sleep 0.1
}


max () {
    if [ "$1" -gt "$2" ]; then
        echo "$1"
    else
        echo "$2"
    fi
}
min () {
    if [ "$1" -gt "$2" ]; then
        echo "$2"
    else
        echo "$1"
    fi
}