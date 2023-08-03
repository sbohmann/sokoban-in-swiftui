const fs = require('fs')

if (process.argv.length !== 3) {
    throw RangeError("Expecting one argument: <path to input file>")
}

const inputFile = process.argv[2]

if (!fs.existsSync(inputFile) || !fs.statSync(inputFile).isFile()) {
    throw RangeError("Not a file: [" + inputFile + "]")
}``

fs.readFileSync('./')
    .forEach(console.log)
