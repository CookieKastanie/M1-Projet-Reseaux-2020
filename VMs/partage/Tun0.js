const { spawn } = require('child_process');

module.exports = class Tun0 {
    constructor() {}

    start(params = ['tun0']) {
        if(!this.process) {
            this.process = spawn('./test_iftun', params);

            this.process.stdout.on('data', data => {
                console.log( data.toString() );
            });

            this.process.stderr.on('data', data => {
                console.error(`Tun0 -> ${data}`);
            });

            this.process.on('close', code => {
                console.log(`Tun0 -> child process exited with code ${code}`);
                this.process = null;
            });
        }
    }

    stop() {
        if(this.process) {
            this.process.kill('SIGINT');
            this.process = null;
        }
    }
}
