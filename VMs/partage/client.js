const net = require('net');
const { client_side } = require('./config.json');

console.log( 'Creating a client ...' );

// Creating the client extremity (for VM3)
const client = new net.Socket();
client.on( "error", console.log );

client.connect( client_side.port, client_side.host, () => {
	// Creating tun0:
	console.log('\tCreating tun0 interface ...');
    const { spawn } = require('child_process');
    const tun0 = spawn('./test_iftun', ['tun0']);
    console.log('\t\ttun0 created.');
    
    // Pinping inputs and ouputs:
    tun0.stdout.pipe(client);
    client.pipe(tun0.stdin);

    // Adding routes related to tun0:
    setTimeout( () => {
    	spawn( client_side.command.name, client_side.command.args )
   	}, 500);
});

console.log('Client created.')