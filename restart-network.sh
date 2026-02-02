sudo ip addr flush dev enp0s31f6
sudo ip link set enp0s31f6 down
sudo ip link set enp0s31f6 up
sudo systemctl restart NetworkManager
