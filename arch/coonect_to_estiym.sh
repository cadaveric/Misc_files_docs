knock 77.85.194.33 2135:udp 2135:udp 2135:udp 2135:udp 2135:udp 2135:udp

ssh -f  -N -o UserKnownHostsFile=/dev/null -o TCPKeepAlive=yes -o ServerAliveCountMax=20 -o ServerAliveInterval=15 -o StrictHostKeyChecking=no  -L 2222:192.168.16.14:22 ras_admins@77.85.194.50 -p 55738 
