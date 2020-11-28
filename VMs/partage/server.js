const net = require('net');

if( process.argv.length == 3 ){
	// host
	const serverPort = parseInt( process.argv[2] );
	const server = net.createServer(socket => {
	    socket.on('connect', () => {
	        const { spawn } = require('child_process');
	        const tun0 = spawn('./test_iftun', ['tun0']);
	            
	        tun0.stdout.pipe(socket);
	        socket.pipe(tun0.stdin);
	    });
	});
	server.listen( serverPort );
}else{
	const remoteHost = process.argv[2];
	const remotePort = parseInt( process.argv[3] );

	// client
	const client = new net.Socket();
	client.connect(remotePort, remoteHost, () => {
	    const { spawn } = require('child_process');
	    const tun0 = spawn('./test_iftun', ['tun0']);
	    
	    tun0.stdout.pipe(client);
	    client.pipe(tun0.stdin);
	});
}