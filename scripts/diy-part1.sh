#!/bin/bash
# DIY Part 1: Execute before updating feeds

echo "DIY Part 1: Add custom feeds"
# Add Siriling's feed for 5G Modem Support
echo 'src-git siriling https://github.com/Siriling/5G-Modem-Support.git' >> feeds.conf.default

# Passwall and other feeds are already in feeds.conf.default

# Add any extra logic here if needed

echo "DIY Part 1: Done"
exit 0
