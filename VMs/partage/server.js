const net = require('net');
const { server_side } = require('./config.json');

// Creating the server extremity (for VM1)
console.log( 'Creating a server ...' );

const serverPort = server_side.port;

const server = net.createServer(socket => {
	// Creating tun0:
	console.log('\tCreating tun0 interface ...');
    const { spawn } = require('child_process');
    const tun0 = spawn('./test_iftun', ['tun0']);
    console.log('\t\ttun0 created.');
    
    // Pinping inputs and ouputs:
    tun0.stdout.pipe(socket);
    socket.pipe(tun0.stdin);

    // Adding routes related to tun0:
    setTimeout( () => {
    	spawn( server_side.command.name, server_side.command.args )
   	}, 500);
});
server.on( "error", console.log );
console.log(`\tMaking the server listen on ${serverPort}`);
server.listen( serverPort );

console.log('Server created.')