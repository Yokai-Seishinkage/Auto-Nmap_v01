#!/bin/bash
clear

## Check to see if root user.
root_check=$(whoami)

if [ "$root_check" != "root" ]
then
echo ""
echo -e "\x1b[31mYOU MUST BE ROOT TO RUN THIS TOOL!\x1b[0m"
sleep 3
clear
exit 0
fi

bane=$(echo "" && echo "         Yokai's auto-nmap Tool!!")
line="============================================"
banner=$(echo "$bane" && echo "$line")

echo "$banner"

main() {
clear

echo "$banner"
echo "Enter the interface to use."
echo "(i.e. wlan0)"
read IFACE
echo "$banner"
echo "Enter a target ip address."
read IP
clear
echo "$banner"
echo ""
echo -e "You entered:\x1b[31m $IP \x1b[0m"
sleep 2
clear

echo "$banner"
echo ""
echo "Please choose a scan.(0-9)"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "|1.) Basic Fast Scan (100 ports)          |"
echo "|2.) OS and Service Detection             |"
echo "|3.) Aggressive Basic Scan (10000 ports)  |"
echo "|4.) Stateless or Stateful Host Discovery |"
echo "|5.) Scan UDP and Traceroute              |"
echo "|6.) Comprehensive Scan (slow)            |"
echo "|7.) Sequential Aggressive Basic Scan     |"
echo "|8.) Whois search                         |"
echo "|9.) Quit                                 |"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
read SCAN
clear
echo ""
echo "$banner"

## Basic scanning.
if [ "$SCAN" == "1" ]
then
nmap $IP -T5 -F -v3
exit 0
fi

## OS and Service Scanning.
if [ "$SCAN" == "2" ]
then
nmap $IP -A -p 1-5000 -sV -T5 -vv && traceroute -m 35 -4 -i $IFACE -m 3389 $IP
exit 0
fi

## Aggressive Basic Scanning of 10000 ports.
if [ "$SCAN" == "3" ]
then
nmap $IP -p 1-10000 -T5 -v3
exit 0
fi

## Stateless and Stateful Host Discovery.
if [ "$SCAN" == "4" ]
then
nmap $IP -A -p 1-5000 -T5 -PA80 -PS80 -v3
exit 0
fi

## UDP Scanning with Traceroute.
if [ "$SCAN" == "5" ]
then
nmap $IP -O -A -PA80 -PS80 -T4 -Pn -v3 && traceroute -4 -i $IFACE -m 35 -p 3389 $IP
exit 0
fi

## Comprehensive Scanning. Slow. 65000 ports
if [ "$SCAN" == "6" ]
then
nmap $IP -p 1-65000 -sS -T5 -sU -A -v3 -PE -PP -PS80,443 -PA3389 -PU40125 -PY -g 53
exit 0
fi

## Sequential Aggressive Basic Scanning.
if [ "$SCAN" == "7" ]
then
nmap $IP -r -p 1-65535 -T5 -v3
exit 0
fi

if [ "$SCAN" == "8" ]
then
whois $IP
exit 0
fi

## Exit Script.
if [ "$SCAN" == "0" ]
then
clear
exit 0
fi

}

while true
do
main
done
