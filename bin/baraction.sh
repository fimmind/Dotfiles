#!/usr/bin/env bash

net() {
  echo -e "NET: $(iwgetid --raw)"
}

vol() {
  amixer get Master | awk -F'[][]' 'END{ printf "VOL: %s:%s", $4, $2 }'
}

rom() {
  df -h / | sed -sn 2p | awk '{ printf "ROM: %s + %s", $5, $4 }'
}

ram() {
  free | awk '/Mem/ { printf "RAM: %d%% + %.1fG", $3 / $2 * 100.0, $4 / 1024.0 / 1024.0 }'
}

cpu() {
  read cpu a b c previdle rest < /proc/stat
  prevtotal=$((a+b+c+previdle))
  sleep 0.5
  read cpu a b c idle res < /proc/stat
  total=$((a+b+c+idle))
  cpu="$((100 - 100 * (idle - previdle) / (total - prevtotal)))%"
  echo -e "CPU: $cpu"
}

while :; do
  echo "$(cpu)      $(ram)      $(rom)      $(vol)      $(net)"
done
