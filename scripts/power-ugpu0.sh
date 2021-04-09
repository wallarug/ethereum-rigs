#!/bin/bash

sudo nvidia-smi -pl 300

counter=0
while [ $counter -le 7 ]
do
DISPLAY=:0 XAUTHORITY=/run/user/1000/gdm/Xauthority nvidia-settings -a [gpu:$counter]/GPUFanControlState=1
((counter++))
done

counter=0
while [ $counter -le 14 ]
do
DISPLAY=:0 XAUTHORITY=/run/user/1000/gdm/Xauthority nvidia-settings -a [fan:$counter]/GPUTargetFanSpeed=85
((counter++))
done



## DISPLAY=:0 XAUTHORITY=/run/user/1000/gdm/Xauthority nvidia-settings -a [gpu:0]/GPUFanControlState=1 -a [fan:0]/GPUTargetFanSpeed=90