#!/bin/sh
sudo sh -c "cpufreq-set -c 0 -g ondemand"
sudo sh -c "echo 1 > /sys/devices/system/cpu/cpufreq/boost"
sudo sh -c "echo 805000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq"
sudo sh -c "/etc/init.d/n900-pm start"
