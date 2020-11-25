#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <stdbool.h>
#include <linux/if.h>
#include <linux/if_tun.h>

#include "iftun.h"

int main (int argc, char** argv){
	if( argc != 2 ){
		printf("Error in command line arguments. (nb args wrong)\n");
		exit(1);
	}

	int fd = tun_alloc( argv[1] );
	
	//printf("Faire la configuration de %s...\n",argv[1]);
	char* prefix = "./configure-tun.sh ";
	char* command =  (char*) malloc( strlen(prefix) + strlen(argv[1])+1 );
	strcpy( command, prefix);
	strcat( command, argv[1]);
	system( command );
	//printf("Done.\n");
	
	//printf("Appuyez sur une touche pour terminer\n");
	//getchar();
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
