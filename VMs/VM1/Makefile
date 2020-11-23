DEFAULT_INTERFACE_NAME = tun0

####################
all: tester_iftun

tester_iftun:
	./test_iftun ${DEFAULT_INTERFACE_NAME} | hexdump -C 
