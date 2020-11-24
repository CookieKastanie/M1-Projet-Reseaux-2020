CC = gcc
DEFAULT_EXE = test_extremite
################################
all: compile copyToVM3_6

compile:
	$(CC) extremite.c extremite.h -o $(DEFAULT_EXE)

tester_extremite:
	./$(DEFAULT_EXE)

copyToVM1AndVM3:
	cp $(DEFAULT_EXE) ../VMs/VM1/
	cp $(DEFAULT_EXE) ../VMs/VM3/
copyToVM3_6:
	cp $(DEFAULT_EXE) ../VMs/VM3-6/
	

mrproper:
	rm $(DEFAULT_EXE)
