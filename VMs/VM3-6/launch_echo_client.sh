#!/bin/bash

# Internet co:
dhclient eth0 && echo ""

# Install [inetutils-inetd]:
echo "  *Installing inetutils-inetd ..."
apt install inetutils-inetd -y && echo ""

# Activate echo service:
update-inetd --add "echostream tcp6 nowait nobody internal" && echo ""

# Launch [inetd]:
service inetutils-inetd start && echo ""

# Restart if needed:
echo "  *Restarting the service to make sure it is working ..."
service inetutils-inetd restart

#Verify that the service started correctly:
echo "  *Service inetd should be started. Confirmation:"
service inetutils-inetd status
echo "You should be able to read {Active: active(running)} in the above output."
