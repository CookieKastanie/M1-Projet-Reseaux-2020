CC = gcc
DEFAULT_EXE = iftun
DEFAULT_TUN_NAME = tun0
################################
all: compile copyToVM1AndVM3

compile:
	$(CC) iftun.c  iftun.h  tunalloc.c  tunalloc.h -o $(DEFAULT_EXE)

tester_iftun:
	./$(DEFAULT_EXE) tun0

copyToVM1AndVM3:
	cp $(DEFAULT_EXE) ../VMs/VM1/
	cp $(DEFAULT_EXE) ../VMs/VM3/


mrproper:
	rm $(DEFAULT_EXE)
