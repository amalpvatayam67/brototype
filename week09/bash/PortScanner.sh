#!/bin/bash
read -p "Enter hostname or domain: " host

# Resolve IP
ip=$(ping -c 1 $host | grep "PING" | cut -d "(" -f 2 | cut -d ")" -f 1)
echo "Resolved IP: $ip"

# Spinner function
spinner() {
  local pid=$!
  local spin='-\|/'
  local i=0
  while kill -0 $pid 2>/dev/null; do
    i=$(( (i+1) %4 ))
    printf "\rScanning ports... ${spin:$i:1}"
    sleep 0.1
  done
  printf "\rScan complete.          \n"
}

# Scan in background and use spinner
(
  for port in {1..100}; do
    timeout 1 bash -c "echo >/dev/tcp/$ip/$port" 2>/dev/null &&
    echo "Port $port is open"
  done
) & spinner
