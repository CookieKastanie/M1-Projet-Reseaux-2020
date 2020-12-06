# Avoir acces à internet :
dhclient eth0:
  cmd:
    - run
## Installation de node :
curl:
  pkg:
    - installed
software-properties-common:
  pkg:
    - installed

curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -:
  cmd:
    - run

nodejs:
  pkg:
    - installed
npm i -g pm2:
  cmd:
    - run

## Installation de netcat6:
netcat6:
  pkg:
    - installed

## Désactivation de network-manager
NetworkManager:
  service:
    - dead
    - enable: False
## Suppression de la passerelle par défaut
ip route del default:
  cmd:
    - run

## Configuration de VM3
eth1:
  network.managed:
    - enabled: True
    - type: eth
    - proto: none
    - ipaddr: 172.16.2.163
    - netmask: 28
eth2:
  network.managed:
    - enabled: True
    - type: eth
    - proto: none
    - enable_ipv4: false
    - ipv6proto: static
    - enable_ipv6: true
    - ipv6_autoconf: no
    - ipv6ipaddr: fc00:1234:4::3
    - ipv6netmask: 64

## Configurating routes:
# to LAN1                     via eth1
# to LAN1-6 & LAN2-6 & LAN3-6 via eth2
#ip route add 172.16.2.128/28 via 172.16.2.162 dev eth1:
 # cmd:
  #  - run

routes:
  network.routes:
    - name: eth1
    - routes:
      - name: LAN1
        ipaddr: 172.16.2.128/28
        gateway: 172.16.2.162
#    - name: eth2
 #   - routes:
  #    - name: LAN1-6
   #     ipaddr: fc00:1234:1::/64
    #    gateway: fc00:1234:4::36

# IPV6  & IPV4 Forwarding:
net.ipv4.ip_forward:
  sysctl:
    - present
    - value: 1
net.ipv6.conf.all.forwarding:
  sysctl:
    - present
    - value: 1

# Launch node client:
bash /vagrant/launch_client.sh &:
  cmd:
    - run
