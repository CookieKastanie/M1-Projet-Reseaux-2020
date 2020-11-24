#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <string.h>
#include <netdb.h>

#include "extremite.h"

int main( void ){
	ext_out();
}

void ext_in(){

}

void ext_out(){
	int sockfd, c; /* socket descriptors */
	int len, on;
	struct addrinfo* resol; /* resolution */
	struct addrinfo indic = {AI_PASSIVE, /* All interface */
                            PF_INET,SOCK_STREAM,0, /* IP connected mode */
                            0,NULL,NULL,NULL};
	struct sockaddr_in client;
	char* port = DEFAULT_PORT;
	int err;

	//TODO : check if we need args.
	
printf(" INSIDE  ext_out() func.\n");
	/* Resolution */
	err = getaddrinfo(NULL,port,&indic,&resol);
	if (err<0){
		fprintf(stderr,"Résolution: %s\n",gai_strerror(err));
		exit(2);
	}
	fprintf( stderr, "Resolution done.\n");

	/* Creating the SOCKET */
	if ((sockfd=socket(resol->ai_family,resol->ai_socktype,resol->ai_protocol))<0){
 	 	perror("allocation de socket");
  	 	exit(3);
	}
	fprintf( stderr, "Socket created.\n" );

	// TODO : Check if we need to make port reusable quickly

	/* Binding socket to resolution */	
	if (bind(sockfd,resol->ai_addr,sizeof(struct sockaddr_in))<0) {
		perror("bind");
		exit(5);
	}
	freeaddrinfo( resol );
	fprintf( stderr, "Binding socket done.\n" );

	/* Socket ready to receive */
	if( listen(sockfd,SOMAXCONN) < 0 ){
		perror("Listen");
		exit(6);
	}
	fprintf( stderr, "Socket ready to receive a client.\n" );
	fprintf( stderr, "Waiting for a client ...\n" );
	/* Wait for a connection to be done */
	len=sizeof(struct sockaddr_in);
	if( (c=accept(sockfd,(struct sockaddr *)&client,(socklen_t*)&len)) < 0 ) {
		perror("accept");
		exit(7);
	}
	fprintf( stderr, "Connection established with a client.\n" );

	/* Client data */
	char hotec[NI_MAXHOST];  char portc[NI_MAXSERV];
	err = getnameinfo((struct sockaddr*)&client,len,hotec,NI_MAXHOST,portc,    NI_MAXSERV,0);
	if (err < 0 )
		fprintf(stderr,"résolution client (%i): %s\n",c,gai_strerror(err));
	else
		fprintf(stderr,"accept! (%i) ip=%s port=%s\n",c,hotec,portc);

	printReceivedToStdout( c );
}

void printReceivedToStdout( int client ){
	fprintf( stderr, "Starting to copy the received data to stdout.\n");
	ssize_t lu;
	char buffer[MAX_LINE+1];
	do {
		lu = recv(client, buffer, MAX_LINE, 0);
        if (lu > 0 ) {
    		buffer[lu] = '\0';
			fprintf( stdout, buffer );
  		} 
		else { break; } 
	} while ( 1 );

	fprintf( stderr, "End of extremity." );
	close( client );
}
