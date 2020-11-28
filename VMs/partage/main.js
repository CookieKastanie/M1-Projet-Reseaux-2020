// Creation tun0:
const Tun0 = require('./Tun0');
const tun0 = new Tun0();
tun0.start();

/*
// Lecture de fichier:
const net = require('net');
const server = net.createServer(stream => {
    stream.on('data', data => {
        console.log('data:', data);
    });

    stream.on('end', () => {
        server.close();
    });
});
*/
//server.listen('/dev/net/tun');


const UDP4 = require('./UDP4');

const s = new UDP4(123);

s.onData((msg, rinfo) => {
    console.log(msg, `from ${rinfo.address}:${rinfo.port}`);
    //s.send( ip??, 123, msg);
});
