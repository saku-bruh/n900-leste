#!/bin/sh
sudo su -c "cpufreq-set -c 0 -g powersave"
sudo su -c "echo 1 > /sys/devices/system/cpu/cpufreq/boost"
sudo su -c "echo 720000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq && cpufreq-set -c 0 -g conservative"
sudo su -c "/etc/init.d/n900-pm start"
