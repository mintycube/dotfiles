#!/usr/bin/env bash

user_host="$(whoami)@$(hostname)"
# user_host="user@arch"
distro="$(awk -F= '/^NAME/{gsub(/"/, "", $2); print $2}' /etc/os-release)"
# distro="Arch Linux"
kernel="$(uname -r)"
wm="$(xprop -id "$(xprop -root -notype | awk '$1=="_NET_SUPPORTING_WM_CHECK:"{print $5}')" -notype -f _NET_WM_NAME 8t | grep "WM_NAME" | cut -f2 -d \")"
# wm="dwm"
memory="$(free -m | awk 'NR==2{printf "%.0f MiB / %.0f MiB\n", $3, $2}')"
term="$TERMINAL"
# term="st"
# up_time="$(uptime -p | sed 's/up //')"
up_time="$(awk '{if ($1>=86400) {printf "%d days, ", int($1/86400)};if ($1>=3600) {printf "%d hours, ", int(($1%86400)/3600)};if ($1>=60) {printf "%d mins ", int(($1%3600)/60)};if ($1<60) {printf "%d seconds", int($1)} }' /proc/uptime)"
pkg_count="$(pacman -Qq | wc -l) (pacman)"
pad=$(printf '%0.1s' " "{1..27})
random_number=$((RANDOM % 7))

if [ $random_number -eq 0 ]; then
  echo -e "\e[90m                               \e[90m╭─────┬─────────────────────────────╮"
  echo -e "\e[90m ⠀⠀⠀⣀⣀⣤⣤⣦⣶⢶⣶⣿⣿⣿⣿⣿⣿⣿⣷⣶⣶⡄⠀⠀⠀⠀⠀⠀⠀ \e[90m│  \e[34m  \e[90m│  \e[32m$user_host${pad:${#user_host}}\e[90m│"
  echo -e "\e[90m ⠀⠀⠀⣿⣿⣿⠿⣿⣿⣾⣿⣿⣿⣿⣿⣿⠟⠛⠛⢿⣿⡇⠀⠀⠀⠀⠀⠀⠀ \e[90m│  \e[34m  \e[90m│  \e[0m$distro${pad:${#distro}}\e[90m│"
  echo -e "\e[90m ⠀⠀⠀⣿⡟⠡⠂⠀⢹⣿⣿⣿⣿⣿⣿⡇⠘⠁⠀⠀⣿⡇⠀⢠⣄⠀⠀⠀⠀ \e[90m│  \e[34m  \e[90m│  \e[0m$kernel${pad:${#kernel}}\e[90m│"
  echo -e "\e[90m ⠀⠀⠀⢸⣗⢴⣶⣷⣷⣿⣿⣿⣿⣿⣿⣷⣤⣤⣤⣴⣿⣗⣄⣼⣷⣶⡄⠀⠀ \e[90m│  \e[34m󰙀  \e[90m│  \e[0m$wm${pad:${#wm}}\e[90m│"
  echo -e "\e[90m ⠀⠀⢀⣾⣿⡅⠐⣶⣦⣶⠀⢰⣶⣴⣦⣦⣶⠴⠀⢠⣿⣿⣿⣿⣼⣿⡇⠀⠀ \e[90m│  \e[34m  \e[90m│  \e[0m$memory${pad:${#memory}}\e[90m│"
  echo -e "\e[90m ⠀⢀⣾⣿⣿⣷⣬⡛⠷⣿⣿⣿⣿⣿⣿⣿⠿⠿⣠⣿⣿⣿⣿⣿⠿⠛⠃⠀⠀ \e[90m│  \e[34m  \e[90m│  \e[0m$term${pad:${#term}}\e[90m│"
  echo -e "\e[90m ⠀⢸⣿⣿⣿⣿⣿⣿⣿⣶⣦⣭⣭⣥⣭⣵⣶⣿⣿⣿⣿⣟⠉⠀⠀⠀⠀⠀⠀ \e[90m│  \e[34m󰔚  \e[90m│  \e[0m$up_time${pad:${#up_time}}\e[90m│"
  echo -e "\e[90m ⠀⠀⠙⠇⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀⠀⠀⠀⠀⠀ \e[90m│  \e[34m  \e[90m│  \e[0m$pkg_count${pad:${#pkg_count}}\e[90m│"
  echo -e "\e[90m⠀ ⠀⠀⠀⣿⣿⣿⣿⣿⣛⠛⠛⠛⠛⠛⢛⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀ \e[90m├─────┴─────────────────────────────┤"
  echo -e "\e[90m⠀⠀ ⠀⠀⠿⣿⣿⣿⠿⠿⠀⠀⠀⠀⠀⠸⣿⣿⣿⣿⠿⠇⠀⠀⠀⠀    \e[90m│   \e[33m󰮯   \e[31m󰊠   \e[32m󰊠   \e[34m󰊠   \e[35m󰊠   \e[36m󰊠   \e[37m󰊠   \e[90m󰊠   │"
  echo -e "\e[90m                               \e[90m╰───────────────────────────────────╯"
elif [ $random_number -eq 1 ]; then
  echo -e "\e[90m                                   \e[90m╭─────┬─────────────────────────────╮"
  echo -e "\e[90m   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          \e[90m│  \e[34m  \e[90m│  \e[32m$user_host${pad:${#user_host}}\e[90m│"
  echo -e "\e[90m    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       \e[90m│  \e[34m  \e[90m│  \e[0m$distro${pad:${#distro}}\e[90m│"
  echo -e "\e[90m          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     \e[90m│  \e[34m  \e[90m│  \e[0m$kernel${pad:${#kernel}}\e[90m│"
  echo -e "\e[90m           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    \e[90m│  \e[34m󰙀  \e[90m│  \e[0m$wm${pad:${#wm}}\e[90m│"
  echo -e "\e[90m          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   \e[90m│  \e[34m  \e[90m│  \e[0m$memory${pad:${#memory}}\e[90m│"
  echo -e "\e[90m   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  \e[90m│  \e[34m  \e[90m│  \e[0m$term${pad:${#term}}\e[90m│"
  echo -e "\e[90m  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   \e[90m│  \e[34m󰔚  \e[90m│  \e[0m$up_time${pad:${#up_time}}\e[90m│"
  echo -e "\e[90m ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  \e[90m│  \e[34m  \e[90m│  \e[0m$pkg_count${pad:${#pkg_count}}\e[90m│"
  echo -e "\e[90m ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ \e[90m├─────┴─────────────────────────────┤"
  echo -e "\e[90m      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     \e[90m│   \e[33m󰮯   \e[31m󰊠   \e[32m󰊠   \e[34m󰊠   \e[35m󰊠   \e[36m󰊠   \e[37m󰊠   \e[90m󰊠   │"
  echo -e "\e[90m       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣤⣾⡿⠃     \e[90m╰───────────────────────────────────╯"
elif [ $random_number -eq 2 ]; then
  echo -e "\e[90m        ⣀⣤⣴⣶⣶⣶⣶⣶⣶⣤⣄⣀           \e[90m╭─────┬─────────────────────────────╮"
  echo -e "\e[90m    ⢀⣠⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣄        \e[90m│  \e[34m  \e[90m│  \e[32m$user_host${pad:${#user_host}}\e[90m│"
  echo -e "\e[90m  ⢀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣆      \e[90m│  \e[34m  \e[90m│  \e[0m$distro${pad:${#distro}}\e[90m│"
  echo -e "\e[90m ⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧     \e[90m│  \e[34m  \e[90m│  \e[0m$kernel${pad:${#kernel}}\e[90m│"
  echo -e "\e[90m ⣾⣿⡿⠟⡋⠉⠛⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠛⠉⠉⠙⠻⣿⣿⣇    \e[90m│  \e[34m󰙀  \e[90m│  \e[0m$wm${pad:${#wm}}\e[90m│"
  echo -e "\e[90m⢠⣿⡏⢰⣿⣿⡇  ⢸⣿⣿⣿⠿⠿⣿⣿⣿⠁⣾⣿⣷  ⠘⣿⣿    \e[90m│  \e[34m  \e[90m│  \e[0m$memory${pad:${#memory}}\e[90m│"
  echo -e "\e[90m⠸⣿⣇⠈⠉⠉  ⢀⣼⡿⠋    ⠙⢿⣄⠙⠛⠁  ⢠⣿⣿    \e[90m│  \e[34m  \e[90m│  \e[0m$term${pad:${#term}}\e[90m│"
  echo -e "\e[90m ⢿⣿⡇   ⣶⣿⣿⢁⣤⣤⣤⣤⣤⣤ ⣿⣷   ⠈⢹⣿⡟    \e[90m│  \e[34m󰦖  \e[90m│  \e[0m$up_time${pad:${#up_time}}\e[90m│"
  echo -e "\e[90m ⠈⢿⡗  ⢸⣿⣿⣿⣶⣶⣶⣶⣶⣶⣶⣶⣿⣿    ⢸⡟     \e[90m│  \e[34m  \e[90m│  \e[0m$pkg_count${pad:${#pkg_count}}\e[90m│"
  echo -e "\e[90m   ⠳⡀ ⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿    ⠌      \e[90m├─────┴─────────────────────────────┤"
  echo -e "\e[90m      ⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣤          \e[90m│   \e[33m󰮯   \e[31m󰊠   \e[32m󰊠   \e[34m󰊠   \e[35m󰊠   \e[36m󰊠   \e[37m󰊠   \e[90m󰊠   │"
  echo -e "\e[90m       ⠉⠙⠻⠿⠿⣿⣿⣿⣿⠿⠿⠛⠉           \e[90m╰───────────────────────────────────╯"
elif [ $random_number -eq 3 ]; then
  echo -e "\e[90m                                    \e[90m╭─────┬─────────────────────────────╮"
  echo -e "\e[90m                                    \e[90m│  \e[34m  \e[90m│  \e[32m$user_host${pad:${#user_host}}\e[90m│"
  echo -e "\e[90m    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣀⣀⡀⠀⠀    \e[90m│  \e[34m  \e[90m│  \e[0m$distro${pad:${#distro}}\e[90m│"
  echo -e "\e[90m    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠠⣀⣠⣶⣶⣶⣿⣿⣿⣟⠟⠉⠁⠀⠉⠀    \e[90m│  \e[34m  \e[90m│  \e[0m$kernel${pad:${#kernel}}\e[90m│"
  echo -e "\e[90m    ⠀⠀⠀⠀⠀⠀⠀⢀⣀⣤⣵⣶⣿⣿⣿⡿⣟⢿⡝⠙⠀⠤⠤⣤⣤⡶⠂⠀    \e[90m│  \e[34m󰙀  \e[90m│  \e[0m$wm${pad:${#wm}}\e[90m│"
  echo -e "\e[90m    ⠀⠀⠀⠀⢀⠴⣪⣾⣿⣿⣿⣿⣿⢿⡿⠃⢿⢸⣧⡍⠭⣭⣿⡿⠋⠀⠀⠀    \e[90m│  \e[34m  \e[90m│  \e[0m$memory${pad:${#memory}}\e[90m│"
  echo -e "\e[90m  ⠀⠀⠀⠀⠀⢀⣵⣿⣿⣿⣿⣿⢯⠟⡵⠋ ⢠⢾⣿⣿⣿⡤⣼⢏⣠⣀⠀⠀⠀    \e[90m│  \e[34m  \e[90m│  \e[0m$term${pad:${#term}}\e[90m│"
  echo -e "\e[90m     ⠀⣰⣻⣿⣿⣿⣾⣿⣧⢡⣘⠁⠀⠀⠘⣄⣻⣿⣿⣷⣿⣿⡿⠍⠁⠀⠀    \e[90m│  \e[34m󰔚  \e[90m│  \e[0m$up_time${pad:${#up_time}}\e[90m│"
  echo -e "\e[90m     ⡇⡿⣿⣿⣿⡿⣿⡻⣿⣜⢄⣶⣤⣀⠀⠀⠀⠈⠛⢻⣟⠫⠉⠀⠀⠀⠀    \e[90m│  \e[34m  \e[90m│  \e[0m$pkg_count${pad:${#pkg_count}}\e[90m│"
  echo -e "\e[90m    ⠀⠣⡻⣌⡻⠿⣿⣮⣽⣿⣶⣾⣿⣳⠶⠖⠬⠍⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀    \e[90m├─────┴─────────────────────────────┤"
  echo -e "\e[90m    ⠀⠀⠈⠀⠉⠉⠙⠛⠛⠒⠓⠒⠀⠀⠀⠒⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀    \e[90m│   \e[33m󰮯   \e[31m󰊠   \e[32m󰊠   \e[34m󰊠   \e[35m󰊠   \e[36m󰊠   \e[37m󰊠   \e[90m󰊠   │"
  echo -e "\e[90m                                    \e[90m╰───────────────────────────────────╯"
elif [ $random_number -eq 4 ]; then
  echo -e "\e[90m       ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⠀      \e[90m╭─────┬─────────────────────────────╮"
  echo -e "\e[90m       ⠀⠀⢤⠘⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠠⣢⢃⡶      \e[90m│  \e[34m  \e[90m│  \e[32m$user_host${pad:${#user_host}}\e[90m│"
  echo -e "\e[90m    ⠀⠀ ⠀⠀⣼⡶⠘⠀⠀⠀⠀⠀⠀⠀⠀⢠⢀⠄⠀⠢⢼⣿⣿⣷⡅ ⠀    \e[90m│  \e[34m  \e[90m│  \e[0m$distro${pad:${#distro}}\e[90m│"
  echo -e "\e[90m    ⠀⠀ ⠠⠀⣿⣿⢇⡀⠀⠀⠀⠀⠀⠀⡤⠀⢈⢄⡇⣪⣿⣿⣿⢟⡠ ⠀    \e[90m│  \e[34m  \e[90m│  \e[0m$kernel${pad:${#kernel}}\e[90m│"
  echo -e "\e[90m    ⠀⠀ ⠀⢸⣿⣿⣟⡐⠁⣀⠀⠀⠀⣠⡤⡨⣳⣿⣿⣿⣿⣿⣿⡿⠃ ⠀    \e[90m│  \e[34m󰙀  \e[90m│  \e[0m$wm${pad:${#wm}}\e[90m│"
  echo -e "\e[90m    ⠀⠀ ⠀⠀⢻⣿⣿⣇⠸⠠⠀⠀⣠⣿⣷⣿⣿⣿⣿⣿⣿⣿⠿⠁⠁ ⠀    \e[90m│  \e[34m  \e[90m│  \e[0m$memory${pad:${#memory}}\e[90m│"
  echo -e "\e[90m  ⠀⠀⠀⠀ ⠀⠀⠀⠙⠿⣿⣮⣄⣄⣈⣾⣿⣿⣿⣿⣿⣿⣿⣿⢏⠹⠄⠃ ⠀    \e[90m│  \e[34m  \e[90m│  \e[0m$term${pad:${#term}}\e[90m│"
  echo -e "\e[90m     ⠀ ⠀⠀⠀⢀⣤⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣟⠻⠀⠙⠠⠀⠀ ⠀    \e[90m│  \e[34m󰔚  \e[90m│  \e[0m$up_time${pad:${#up_time}}\e[90m│"
  echo -e "\e[90m       ⠀⠀⠀⠈⢤⡟⠻⣿⣿⣿⣿⣿⣿⡿⠿⡻⠳⠁⠀⠁⠀⠀⠀ ⠀    \e[90m│  \e[34m  \e[90m│  \e[0m$pkg_count${pad:${#pkg_count}}\e[90m│"
  echo -e "\e[90m    ⠀  ⠀⠀⠀⠀⠀⠀⠁⠙⢿⣿⣿⣿⣿⣶⣾⣷⣶⣦⣤⠀⠀⠀⠀ ⠀    \e[90m├─────┴─────────────────────────────┤"
  echo -e "\e[90m     ⠀ ⠀⠀⠀⠀⠀⢀⣤⡶⡖⠿⣿⣿⣿⣿⡿⠏⠝⠁⠀⠀⠀⠀⠀ ⠀    \e[90m│   \e[33m󰮯   \e[31m󰊠   \e[32m󰊠   \e[34m󰊠   \e[35m󰊠   \e[36m󰊠   \e[37m󰊠   \e[90m󰊠   │"
  echo -e "\e[90m       ⠀⠀⠀⠀⠀⠈⠀⠡⠔⠀⠈⠙⠙⠑⠂⠀⠀⠀⠀⠀⠀⠀⠀      \e[90m╰───────────────────────────────────╯"
elif [ $random_number -eq 5 ]; then
  echo -e "\e[90m      ⠀⠀⠀⠀⠀⠀⢀⢀⠀⣄⢂⣀⣂⣤⣀⢀⢀⠀⠀⠀⠀⠀⠀       \e[90m╭─────┬─────────────────────────────╮"
  echo -e "\e[90m      ⠀⠀⠀⠀⣄⣰⣝⣉⣙⢱⣞⠜⡖⣌⣌⣁⣻⣠⣀⠀⠀⠀⠀       \e[90m│  \e[34m  \e[90m│  \e[32m$user_host${pad:${#user_host}}\e[90m│"
  echo -e "\e[90m    ⠀ ⠀⠀⢔⢽⣊⣂⣇⡒⠮⢻⣇⠲⢍⣿⢟⣒⣰⣠⣑⡔⣀⠀⠀  ⠀    \e[90m│  \e[34m  \e[90m│  \e[0m$distro${pad:${#distro}}\e[90m│"
  echo -e "\e[90m    ⠀ ⠀⠹⡸⢙⣕⡐⢂⠍⣩⡻⣿⣆⣾⠟⣉⢣⠪⠲⡰⡋⣢⢆⠀  ⠀    \e[90m│  \e[34m  \e[90m│  \e[0m$kernel${pad:${#kernel}}\e[90m│"
  echo -e "\e[90m    ⠀ ⠀⣪⡹⣵⢦⠽⡓⠶⠶⣧⣹⣿⣏⣴⠶⠛⠟⠽⢛⣒⢮⡙⠀  ⠀    \e[90m│  \e[34m󰙀  \e[90m│  \e[0m$wm${pad:${#wm}}\e[90m│"
  echo -e "\e[90m    ⠀ ⠸⢋⢪⠑⢩⠈⠀⠀⠀⠈⣿⣿⣿⠁⠀⠀⠘⢠⠈⠆⢎⢱⠁  ⠀    \e[90m│  \e[34m  \e[90m│  \e[0m$memory${pad:${#memory}}\e[90m│"
  echo -e "\e[90m  ⠀⠀⠀ ⠀⠻⡕⡲⡈⠀⠀⠀⠀⠀⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠆⠄⠁  ⠀    \e[90m│  \e[34m  \e[90m│  \e[0m$term${pad:${#term}}\e[90m│"
  echo -e "\e[90m      ⠀⠀⠀⠇⠀⠀⠀⠀⠀⣰⣿⣿⣿⣤⡀⠀⠀⠀⠀⠌⠘⠀⠀  ⠀    \e[90m│  \e[34m󰔚  \e[90m│  \e[0m$up_time${pad:${#up_time}}\e[90m│"
  echo -e "\e[90m      ⠀⠀⠀⢱⠒⡶⡶⢖⣫⡿⢻⠿⡟⢿⣍⡱⢖⠶⠒⡆⠀⠀⠀  ⠀    \e[90m│  \e[34m  \e[90m│  \e[0m$pkg_count${pad:${#pkg_count}}\e[90m│"
  echo -e "\e[90m    ⠀ ⠀⠀⠀⠀⠁⠬⡃⠴⣇⣴⠏⠖⠙⣦⣸⠦⡼⠣⠉⠀⠀⠀⠀  ⠀    \e[90m├─────┴─────────────────────────────┤"
  echo -e "\e[90m      ⠀⠀⠀⠀⠀⠀⠈⠁⠑⠢⠧⠭⠼⠵⠋⠊⠁⠀⠀⠀⠀⠀⠀  ⠀    \e[90m│   \e[33m󰮯   \e[31m󰊠   \e[32m󰊠   \e[34m󰊠   \e[35m󰊠   \e[36m󰊠   \e[37m󰊠   \e[90m󰊠   │"
  echo -e "\e[90m       ⠀⠀⠀⠀⠀⠀             ⠀⠀⠀⠀      \e[90m╰───────────────────────────────────╯"
else
  echo -e "\e[90m             ⠀⠀⢀⣀⣀⡀⠒⠒⠦⣄⡀⠀⠀⠀⠀⠀⠀⠀     \e[90m╭─────┬─────────────────────────────╮"
  echo -e "\e[90m     ⠀⠀⠀⠀⠀⢀⣤⣶⡾⠿⠿⠿⠿⣿⣿⣶⣦⣄⠙⠷⣤⡀⠀⠀⠀⠀     \e[90m│  \e[34m  \e[90m│  \e[32m$user_host${pad:${#user_host}}\e[90m│"
  echo -e "\e[90m    ⠀⠀⠀⠀⣠⡾⠛⠉⠀⠀⠀⠀⠀⠀⠀⠈⠙⠻⣿⣷⣄⠘⢿⡄⠀⠀⠀⠀    \e[90m│  \e[34m  \e[90m│  \e[0m$distro${pad:${#distro}}\e[90m│"
  echo -e "\e[90m    ⠀⠀⢀⡾⠋⠀⠀⠀⠀⠀⠀⠀⠀⠐⠂⠠⢄⡀⠈⢿⣿⣧⠈⢿⡄⠀⠀⠀    \e[90m│  \e[34m  \e[90m│  \e[0m$kernel${pad:${#kernel}}\e[90m│"
  echo -e "\e[90m    ⠀⢀⠏⠀⠀⠀⢀⠄⣀⣴⣾⠿⠛⠛⠛⠷⣦⡙⢦⠀⢻⣿⡆⠘⡇⠀⠀⠀    \e[90m│  \e[34m󰙀  \e[90m│  \e[0m$wm${pad:${#wm}}\e[90m│"
  echo -e "\e[90m    ⠀⠀⠀⠀⠀⡐⢁⣴⡿⠋⢀⠠⣠⠤⠒⠲⡜⣧⢸⠄⢸⣿⡇⠀⡇⠀⠀⠀    \e[90m│  \e[34m  \e[90m│  \e[0m$memory${pad:${#memory}}\e[90m│"
  echo -e "\e[90m  ⠀⠀⠀⠀⠀⠀⡼⠀⣾⡿⠁⣠⢃⡞⢁⢔⣆⠔⣰⠏⡼⠀⣸⣿⠃⢸⠃⠀⠀⠀    \e[90m│  \e[34m  \e[90m│  \e[0m$term${pad:${#term}}\e[90m│"
  echo -e "\e[90m     ⠀⠀⢰⡇⢸⣿⡇⠀⡇⢸⡇⣇⣀⣠⠔⠫⠊⠀⣰⣿⠏⡠⠃⠀⠀⢀⠀    \e[90m│  \e[34m󰔚  \e[90m│  \e[0m$up_time${pad:${#up_time}}\e[90m│"
  echo -e "\e[90m     ⠀⠀⢸⡇⠸⣿⣷⠀⢳⡈⢿⣦⣀⣀⣀⣠⣴⣾⠟⠁⠀⠀⠀⠀⢀⡎⠀    \e[90m│  \e[34m  \e[90m│  \e[0m$pkg_count${pad:${#pkg_count}}\e[90m│"
  echo -e "\e[90m    ⠀⠀⠀⠘⣷⠀⢻⣿⣧⠀⠙⠢⠌⢉⣛⠛⠋⠉⠀⠀⠀⠀⠀⠀⣠⠎⠀⠀    \e[90m├─────┴─────────────────────────────┤"
  echo -e "\e[90m     ⠀⠀⠀⠹⣧⡀⠻⣿⣷⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⡾⠃⠀⠀⠀    \e[90m│   \e[33m󰮯   \e[31m󰊠   \e[32m󰊠   \e[34m󰊠   \e[35m󰊠   \e[36m󰊠   \e[37m󰊠   \e[90m󰊠   │"
  echo -e "\e[90m     ⠀⠀⠀⠀⠈⠻⣤⡈⠻⢿⣿⣷⣦⣤⣤⣤⣤⣤⣴⡾⠛⠉⠀⠀⠀⠀     \e[90m╰───────────────────────────────────╯"
  echo -e "\e[90m     ⠀⠀⠀⠀⠀⠀⠈⠙⠶⢤⣈⣉⠛⠛⠛⠛⠋⠉⠀⠀⠀⠀⠀⠀⠀⠀     "
fi
