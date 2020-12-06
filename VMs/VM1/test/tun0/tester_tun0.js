#!/usr/bin/env node
const {spawn} = require('child_process');

// Launch tun0 and create required route:
const tun0 = spawn('./test_iftun', ['tun0', 'fc00:1234:4::/64'] );
// Start a hexdump process to print the packets:
const hexdump = spawn('hexdump', ['-C']);

// Redirecting tun0 output to hexdump's stdin:
tun0.stdout.pipe( hexdump.stdin )
// Redirection hexdump output to stdout:
hexdump.stdout.pipe( process.stdout );

// Start to send packets throught our interface:
setTimeout( () => {
	console.log('Starting to ping ...');
	spawn('ping6', ['fc00:1234:4::3']);
}, 500 );
