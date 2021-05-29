#!/bin/bash

sudo nvidia-smi -i 0 -pl 300
sudo nvidia-smi -i 1 -pl 300
sudo nvidia-smi -i 2 -pl 120
sudo nvidia-smi -i 3 -pl 300

counter=0
while [ $counter -le 3 ]
do
DISPLAY=:0 XAUTHORITY=un/user/1000/gdm/Xauthority nvidia-settings -a [gpu:$counter]/GPUFanControlState=1
((counter++))
done

counter=0
while [ $counter -le 14 ]
do
DISPLAY=:0 XAUTHORITY=un/user/1000/gdm/Xauthority nvidia-settings -a [fan:$counter]/GPUTargetFanSpeed=85
((counter++))
done
