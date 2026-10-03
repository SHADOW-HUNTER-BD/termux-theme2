#!/bin/bash
# SHADOWx404 - Change banner/prompt name
clear

r='\033[1;91m'; g='\033[1;92m'; y='\033[1;93m'; c='\033[1;96m'; n='\033[0m'
E="${r}[×]${n}"

CONFIG_DIR="$HOME/.shadowx404"
CONFIG_FILE="$CONFIG_DIR/config"
ZSHRC="$HOME/.zshrc"
THEME="$HOME/.oh-my-zsh/custom/themes/shadowx404.zsh-theme"

if [ ! -f "$CONFIG_FILE" ]; then
    echo -e "\n ${r}[×] Error: SHADOWx404 is not installed yet. Run install.sh first.${n}"
    exit 1
fi

source "$CONFIG_FILE"
CURRENT_NAME="$SHADOWX_USER"

echo -e " ${c}[+] Current prompt name: ${g}${CURRENT_NAME}${n}"
echo

while true; do
    read -p "$(echo -e ${g}[${n}+${g}]──[${n}Enter New Name${g}]────►${n} )" name
    echo
    if [[ -z "$name" ]]; then
        echo -e " ${E} Name cannot be empty!"
        continue
    fi
    if [[ ! "$name" =~ ^[a-zA-Z0-9[:space:]-]+$ ]]; then
        echo -e " ${E} Invalid input! Use letters, numbers, hyphens & spaces only."
        continue
    fi
    name="${name^^}"
    name="${name// /-}"
    len=${#name}
    if [[ $len -ge 1 && $len -le 12 ]]; then
        break
    else
        echo -e " ${E} Name must be 1-12 characters. Current length: $len"
    fi
done

# Update config, zshrc theme, and banner
sed -i "s/^SHADOWX_USER=.*/SHADOWX_USER=\"$name\"/" "$CONFIG_FILE"
[ -f "$ZSHRC" ] && sed -i "s/$CURRENT_NAME/$name/g" "$ZSHRC"
[ -f "$THEME" ] && sed -i "s/$CURRENT_NAME/$name/g" "$THEME"

echo -e " ${g}[+] Name successfully changed to: ${y}$name${n}"
echo -e " ${c}[!] Restart your terminal or run 'zsh' to see the changes.${n}"
echo
