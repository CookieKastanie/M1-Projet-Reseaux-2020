const dgram = require('dgram');

module.exports = class UDP4 {
    constructor(port = 123) {
        this.sock = dgram.createSocket('udp4');
        this.sock.bind(port);

        this.sock.on('error', (err) => {
            console.log(`Socket error:\n${err.stack}`);
            this.sock.close();
        });

        this.sock.on('listening', () => {
            const address = this.sock.address();
            console.log(`Socket listening ${address.address}:${address.port}`);
        });
    }

    onData(event) {
        this.sock.on('message', event);
    }

    send(ip, port, data) {
        this.sock.send(data, port, ip);
    }
}
