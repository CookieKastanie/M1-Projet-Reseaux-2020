## Desactivation of network-manager:
NetworkManager:
  service:
    - dead
    - enable: False
# Suppression de la passerelle par défaut
ip route del default:
  cmd:
    - run

## Configuration de VM2-6:
eth1:
  network.managed:
    - enabled: True
    - type: eth
    - proto: none
    - enable_ipv4: false
    - ipv6proto: static
    - enable_ipv6: true
    - ipv6_autoconf: no
    - ipv6ipaddr: fc00:1234:1::26
    - ipv6netmask: 64
eth2:
  network.managed:
    - enabled: True
    - type: eth
    - proto: none
    - enable_ipv4: false
    - ipv6proto: static
    - enable_ipv6: true
    - ipv6_autoconf: no
    - ipv6ipaddr: fc00:1234:2::26
    - ipv6netmask: 64


## Configurating routes:
#    to LAN3-6  via VM1-6 (eth1)
#    to LAN4-6  via VM3-6 (eth2)
routes:
  network.routes:
    - name: eth1
    - routes:
      - name: LAN3-6
        ipaddr: fc00:1234:3::/64
        gateway: fc00:1234:1::16
    - name: eth2
    - routes:
      - name: LAN4-6
        ipaddr: fc00:1234:4::/64
        gateway: fc00:1234:2::36
# Command to make sure that the first route ( to LAN3-6 ) is added:
ip route add fc00:1234:3::/64 via fc00:1234:1::16 dev eth1  metric 1024:
  cmd:
    - run
# This is due to this error (which is an issue on the git of salt)
# https://github.com/saltstack/salt/issues/31267


# IPV6  & IPV4 Forwarding:
net.ipv4.ip_forward:
  sysctl:
    - present
    - value: 1
net.ipv6.conf.all.forwarding:
  sysctl:
    - present
    - value: 1