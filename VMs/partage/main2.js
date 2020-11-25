const UDP4 = require('./UDP4');

const s = new UDP4(456);

setInterval(() => {
    s.send('localhost', 123, Buffer.from(new Int8Array([0, 1, 2, 3, 4])));
}, 1000)
