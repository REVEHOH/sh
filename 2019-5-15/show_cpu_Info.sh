#!/bin/sh
awk '/vendor_id/{print $3}' /proc/cpuinfo | uniq
