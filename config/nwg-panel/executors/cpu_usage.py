#!/usr/bin/python3

import psutil

percent = psutil.cpu_percent(interval=2)
print(f' {percent:.0f}%')
