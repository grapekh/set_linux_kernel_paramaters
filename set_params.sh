#!/bin/bash
#
# Parameters needed for database optimization (Redhat 7 and Ubuntu)
#
# Grapek - 20190115
# Grapek - 20190122 - changed params for better sql performance: 
#    65535 512000 2048 32000 intstead of 65535 512000 1024 1024
#     echo "kernel.sem = 65535 512000 1024 1024" >> /etc/sysctl.conf 
#
# run this as root!
#

echo "Here are the current limits..."
ipcs -l

echo ""
echo "Increasing memory limits..."
sysctl -w kernel.msgmax=65536
sysctl -w kernel.msgmnb=65536
sysctl -w kernel.shmmax=18014398509465599
sysctl -w kernel.shmall=18014398442373116


echo ""
echo "Increasing memory limits permanently..."

echo "# 
# sysctl configuration file for Red Hat Linux 7 and/or Ubuntu 
# Changes needed for Palms...
#
kernel.msgmnb=65536
kernel.msgmax=65536
kernel.shmmax=18014398509465599
kernel.shmall=18014398442373116" > /etc/sysctl.d/01-custom.conf



echo ""
echo "Setting up semaphores in file... "
echo "kernel.sem = 65535 512000 2048 32000" >> /etc/sysctl.conf 

echo ""
echo "Testing semaphores and making them so... "
sysctl -p

echo ""
echo "Making everything permanent..."
sysctl --system


echo ""
echo "All done - here are the settings"
echo ""
ipcs -l
