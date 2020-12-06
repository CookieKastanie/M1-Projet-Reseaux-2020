#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <stdbool.h>
#include <linux/if.h>
#include <linux/if_tun.h>
#include <pthread.h>

#include "iftun.h"
int fd;

char* concat(const char *s1, const char *s2);
char* concat(const char *s1, const char *s2){
    char *result = malloc(strlen(s1) + strlen(s2) + 1);
    strcpy(result, s1);
    strcat(result, s2);
    return result;
}

int main (int argc, char** argv){
	if( argc < 2  || argc > 3 ){
		printf("Error in command line arguments. (nb args wrong)\n");
		exit(1);
	}

	fd = tun_alloc( argv[1] );
	
	//printf("Faire la configuration de %s...\n",argv[1]);
	char* command = "./configure-tun.sh ";
	command = concat( command, argv[1]);
	system( command );
	free( command );
	//printf("Done.\n");

	// If the second argument is supplied: (IPv6 addr) 
	// Create an ipV6 route using tun0 towards this addr
	if( argc == 3 ){
		char* command = "sudo ip -6  route add ";
		command = concat( command, argv[2] );
		command = concat( command, " dev " );
		command = concat( command, argv[1] );
		system( command );
		free( command );
	}
	// In to tun0:
    pthread_t thread_id; 
    pthread_create(&thread_id, NULL, start_thread, NULL); 

    // tun0 to out:
	copyData( fd, 1 );
	
}

void copyData( int src, int dst ){
	int size_buffer = 1024;
	char* buffer = malloc( size_buffer * sizeof(char) );
	while( true ){
		read(  src, buffer, size_buffer );
		write( dst, buffer, size_buffer );
	}
	free( buffer );
}

void* start_thread(){
	copyData(0, fd);
}
