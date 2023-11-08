#!/bin/bash

# neet to update '/rocky/besu/besu.service'
echo besu.service 
cp /rocky/besu/besu.service /etc/systemd/system/besu.service

systemctl start besu.service
systemctl enable besu.service

# echo log rotate

