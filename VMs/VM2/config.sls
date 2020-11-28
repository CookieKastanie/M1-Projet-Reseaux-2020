## Désactivation de network-manager
NetworkManager:
  service:
    - dead
    - enable: False
## Suppression de la passerelle par défaut
ip route del default:
  cmd:
    - run

## Configuration de VM2:
eth1:
  network.managed:
    - enabled: True
    - type: eth
    - proto: none
    - ipaddr: 172.16.2.132
    - netmask: 28
eth2:
  network.managed:
    - enabled: True
    - type: eth
    - proto: none
    - ipaddr: 172.16.2.162
    - netmask: 28

# No route needed.

# IPV6  & IPV4 Forwarding:
net.ipv4.ip_forward:
  sysctl:
    - present
    - value: 1
net.ipv6.conf.all.forwarding:
  sysctl:
    - present
    - value: 1
