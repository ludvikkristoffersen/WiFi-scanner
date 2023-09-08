#!/bin/bash

clear
# Text colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color


echo "

█░█░█ █ █▀▀ █   █▀ █▀▀ ▄▀█ █▄░█ █▄░█ █▀▀ █▀█
▀▄▀▄▀ █ █▀░ █   ▄█ █▄▄ █▀█ █░▀█ █░▀█ ██▄ █▀▄
"
echo -e "${BLUE}- - - - - - - - - - - - - - - - - - by DuckWithDarkHat${NC}"
sleep 2
echo

# Installing the tools if they are not installed
if ! command -v hcxdumptool > /dev/null; then
        echo -e "${YELLOW}[!] hcxdumptool not found. Installing...${NC}"
        sudo apt update
        sudo apt install hcxdumptool -y
        echo -e "${GREEN}[*] hcxdumptool installed.${NC}"
        echo
fi
if ! command -v hcxpcapngtool > /dev/null; then
        echo -e "${YELLOW}[!] hcxpcapngtool not found. Installing...${NC}"
        sudo apt update
        sudo apt install hcxtools -y
        echo -e "${GREEN}[*] hcxpcapngtool installed.${NC}"
        echo
fi
if ! command -v xterm > /dev/null; then
        echo -e "${YELLOW}[!] xterm not found. Installing...${NC}"
        sudo apt update
        sudo apt install xterm -y
        echo -e "${GREEN}[*] xterm installed.${NC}"
        echo
fi
echo -e "${BLUE}[*] ${GREEN}All tools required are installed.${NC}"
echo

# Stopping services that may cause issues
sudo systemctl stop wpa_supplicant.service
sudo systemctl stop NetworkManager.service

# List adapters
echo -e "${BLUE}[*] ${GREEN}List of available WiFi adapters:${NC}"
adapters=$(iwconfig 2>/dev/null | grep -oP '^[^\s]+')
counter=1
while read -r adapter; do
  echo "$counter. $adapter"
  counter=$((counter + 1))
done <<< "$adapters"
echo

# Ask user for the wlan they want to use
read -p "[-] Enter the WLAN you wish to use (example: wlan0): " wlan
echo

if ! iwconfig "$wlan" > /dev/null 2>&1; then
  echo -e "${YELLOW}[!] Invalid WLAN name. Please enter a valid WLAN name.${NC}"
  sudo systemctl start wpa_supplicant.service
  sudo systemctl start NetworkManager.service
  exit 1
fi

# Ask user for the output pcapng file name
read -p "[-] Enter the pcapng output filename (without extension): " pcapngfile
output="${pcapngfile}.pcapng"
echo

# Choose a mode
read -p "[-] Choose a mode:
1. Timer mode
2. Manual mode
Enter your choice (1 or 2): " mode
echo

case $mode in
  1)
    read -p "[-] Enter the duration (in seconds) to run the command: " duration
    echo
    echo -e "${BLUE}[*] Running hcxdumptool command in timer mode...${NC}"
    xterm -T "hcxdumptool" -e sudo hcxdumptool -i "$wlan" -o "$output" --active_beacon --enable_status=63 &
    pid=$!

    sleep "$duration"

    sudo kill "$pid"
    ;;
  2)
    # Running the hcxdumptool in manual mode
    echo -e "${BLUE}[*] Running hcxdumptool command in manual mode. Press Ctrl+C to stop.${NC}"
    xterm -T "hcxdumptool" -e sudo hcxdumptool -i "$wlan" -o "$output" --active_beacon --enable_status=63
    ;;
  *)
    echo -e "${YELLOW}[!] Invalid choice. Please choose 1 or 2.${NC}"
    sudo systemctl start wpa_supplicant.service
    sudo systemctl start NetworkManager.service
    exit 1
    ;;
esac

# Starting the services we stopped earlier
sudo systemctl start wpa_supplicant.service
sudo systemctl start NetworkManager.service
echo
echo

# Ask the user to enter a filename for the hc22000 file
read -p "[-] Enter the hashcat file name (without extension): " hcfile
hashcatFile="${hcfile}.hc22000"
echo

# Ask the user for a name for the ESSID list
read -p "[-] Enter the ESSID list name: " essidList
echo

# Convert the pcapng file to a hc22000 file and create a ESSID list
echo -e "${BLUE}[*] Running hcxpcapngtool command...${NC}"
xterm -T "hcxpcapngtool" -e hcxpcapngtool -o "$hashcatFile" -E "$essidList" "$output"
clear
sleep 1

# Message when finished
echo "

█░█░█ █ █▀▀ █   █▀ █▀▀ ▄▀█ █▄░█ █▄░█ █▀▀ █▀█
▀▄▀▄▀ █ █▀░ █   ▄█ █▄▄ █▀█ █░▀█ █░▀█ ██▄ █▀▄
"
echo -e "${BLUE}- - - - - - - - - - - - - - - - - - by Ludde${NC}"
echo
echo -e "${YELLOW}[*] WiFi scanner completed.${NC}"
