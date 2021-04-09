#!/bin/bash

sudo nvidia-smi -i 0 -pl 130
sudo nvidia-smi -i 1 -pl 130
sudo nvidia-smi -i 3 -pl 150
sudo nvidia-smi -i 2 -pl 150
sudo nvidia-smi -i 4 -pl 130

counter=0
while [ $counter -le 4 ]
do
DISPLAY=:0 XAUTHORITY=un/user/1000/gdm/Xauthority nvidia-settings -a [gpu:$counter]/GPUFanControlState=1
((counter++))
done

counter=0
while [ $counter -le 7 ]
do
DISPLAY=:0 XAUTHORITY=un/user/1000/gdm/Xauthority nvidia-settings -a [fan:$counter]/GPUTargetFanSpeed=90
((counter++))
done
