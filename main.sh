#! /bin/bash
Black="\e[30m" ; White="\e[37m"
Green="\e[32m" ; Red="\e[31m"
Yellow="\e[33m"; Blue="\e[34m"
Purple="\e[35m"; Aqua="\e[36m"
Noc="\e[0m"



pause_(){ read -t 2 -sn1 -p "Press any key to continue..."; }

draw_screen_(){
	clear

	board=( " ${xy[0]} | ${xy[1]} | ${xy[2]}"\
		"---|---|---"\
		" ${xy[3]} | ${xy[4]} | ${xy[5]}"\
		"---|---|---"\
		" ${xy[6]} | ${xy[7]} | ${xy[8]}")
	printf "\n"
	for (( i=0; i<5; i++ )); do echo -e "    ${board[$i]}"; done
	printf "\n\n"
}

who_wins_(){
	case "$PlayingMode" in
		1)
			[[ "$Player1" == "X" ]] && ResultX="You win!" && ResultO="Better luck next time!"
			[[ "$Player1" == "O" ]] && ResultO="You win!" && ResultX="Better luck next time!"
		;;
		2)
			[[ "$Player1" == "X" ]] && ResultX="${PName1} Wins!" && ResultO="${PName2} Wins!"
			[[ "$Player1" == "O" ]] && ResultX="${PName2} Wins!" && ResultO="${PName1} Wins!"
		;;
	esac
	ResultD="Match draw!"

	# Rules to win
	if [[ "${xy[1]}${xy[0]}" == "${xy[0]}${xy[2]}" || "${xy[3]}${xy[0]}" == "${xy[0]}${xy[6]}" ]]; then
		result="Result${xy[1]}";
	elif [[ "${xy[3]}${xy[4]}" == "${xy[4]}${xy[5]}" || "${xy[1]}${xy[4]}" == "${xy[4]}${xy[7]}" ]]; then
		result="Result${xy[4]}"
	elif [[ "${xy[6]}${xy[8]}" == "${xy[8]}${xy[7]}" || "${xy[2]}${xy[8]}" == "${xy[8]}${xy[5]}" ]]; then
		result="Result${xy[8]}"
	elif [[ "${xy[0]}${xy[4]}" == "${xy[4]}${xy[8]}" || "${xy[2]}${xy[4]}" == "${xy[4]}${xy[6]}" ]]; then
		result="Result${xy[4]}"
	elif [[ "${xy[@]}" != *[1-9]* ]]; then
		result="ResultD"
	fi

	if [[ ! -z "$result" ]]; then
		clear; sleep 0.4
		printf "${Green}${!result}$Noc\n\n"
		unset result
		pause_
		main_ "@"
	fi
}
