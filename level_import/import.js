const fs = require('fs')

console.log(process.argv)

if (process.argv.length !== 3) {
    throw RangeError("Expecting one argument: <path to input file>")
}

const inputFile = process.argv[2]

if (!fs.existsSync(inputFile) || !fs.statSync(inputFile).isFile()) {
    throw RangeError("Not a file: [" + inputFile + "]")
}

fs.readFileSync(inputFile, 'utf-8')
    .split(/\r?\n/)
    .forEach(parseLine)

function parseLine(line) {
    console.log(line)
}
