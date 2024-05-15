#!/bin/bash
command -v curl >/dev/null 2>&1 || exit 1
green='\033[30;102m'; yellow='\033[30;103m'; white='\033[30;107m'; reset='\033[0m'
wordle_dir="${XDG_DATA_HOME:-$HOME/.local/share}/wordle"
mkdir -p "${wordle_dir}" || exit 1
dict="https://gist.githubusercontent.com/prichey/95db6bdef37482ba3f6eb7b4dec99101/raw/"
if [[ ! -f "${wordle_dir}/wordles" ]]; then
  curl -s "${dict}" | tr '[:lower:]' '[:upper:]' > "${wordle_dir}/wordles"
fi
mapfile -t words < "${wordle_dir}/wordles" || exit 1
actual=${words[$((RANDOM % ${#words[@]}))]}
[[ $1 == "unlimit" ]] && max_guess=999999
for (( guess_count=1; guess_count<=${max_guess:-6}; guess_count++ )); do
    until [[ " ${words[*]} " =~ " ${guess^^} " ]]; do
      printf -- '%s\n' "Please enter a valid 5 letter word..."
      read -rp "Enter your guess (${guess_count} / ${max_guess:-6}): " guess
    done
    guess="${guess^^}"; output=""; remaining=""
    if [[ "${actual}" == "${guess}" ]]; then
        printf -- '%s\n' "You guessed right!"
        for ((i=0; i<5; i++)); do
            output+="${green} ${guess:$i:1} ${reset}"
        done
        printf -- '%b\n' "${output}"; exit 0
    fi
    for ((i=0; i<5; i++)); do
        [[ "${actual:$i:1}" != "${guess:$i:1}" ]] && remaining+=${actual:$i:1}
    done
    
