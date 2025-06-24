#!/bin/bash

nmcli radio wifi on

nmcli connection delete Hotspot >/dev/null 2>&1

nmcli device wifi hotspot ifname wlan0 ssid Rasp password rasp2137
