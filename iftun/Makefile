CC = gcc
FLAGS = -pthread
DEFAULT_EXE = test_iftun
DEFAULT_TUN_NAME = tun0
################################
all: compile copyToPartage

compile:
	$(CC) $(FLAGS) iftun.c  iftun.h  tunalloc.c  tunalloc.h -o $(DEFAULT_EXE)

tester_iftun:
	./$(DEFAULT_EXE) tun0

copyToPartage:
	cp $(DEFAULT_EXE) ../VMs/partage/

mrproper:
	rm $(DEFAULT_EXE)
