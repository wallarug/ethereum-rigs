#!/bin/bash

sudo nvidia-smi -pl 130

counter=0
while [ $counter -le 5 ]
do
DISPLAY=:0 XAUTHORITY=/run/user/1000/gdm/Xauthority nvidia-settings -a [gpu:$counter]/GPUFanControlState=1
((counter++))
done

counter=0
while [ $counter -le 11 ]
do
DISPLAY=:0 XAUTHORITY=/run/user/1000/gdm/Xauthority nvidia-settings -a [fan:$counter]/GPUTargetFanSpeed=90
((counter++))
done