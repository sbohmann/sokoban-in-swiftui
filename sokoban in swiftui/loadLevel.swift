import Foundation

func loadLevel(_ number: Int) -> LevelData {
    let levelFilePath = Bundle.main.path(forResource: "level\(number).txt", ofType: nil)!
    let levelDescription = try! String(contentsOfFile: levelFilePath)
    let lines = levelDescription
        .split(separator: "\n")
        .map({ line in [Unicode.Scalar](line.unicodeScalars) })
    let width = lines.reduce(0, { sum, line in max(sum, line.count) })
    let height = lines.count
    var map = [Field]()
    var boxes = [Position]()
    var player: Position?
    
    parseMap()
    
    if (map.count != width * height) {
        fatalError("map size is off")
    }
    
    func parseMap() {
        for y in 0 ..< height {
            let line = lines[y]
            for x in 0 ..< width {
                parseField(line: line, x: x, y: y)
            }
        }
    }
    
    func parseField(line: [Unicode.Scalar], x: Int, y: Int) {
        if x < line.count {
            parseFieldCharacter(character: line[x], x: x, y: y)
        } else {
            map.append(.open)
        }
    }
    
    func parseFieldCharacter(character: Unicode.Scalar, x: Int, y: Int) {
        switch character {
        case " ":
            map.append(.open)
        case ".":
            map.append(.target)
        case "#":
            map.append(.wall)
        case "@":
            map.append(.open)
            setPlayer(x, y)
        case "+":
            map.append(.target)
            setPlayer(x, y)
        case "$":
            map.append(.open)
            boxes.append(Position(x: x, y: y))
        case "*":
            map.append(.target)
            boxes.append(Position(x: x, y: y))
        default:
            fatalError("Illegal character [\(character)]")
        }
    }
    
    func setPlayer(_ x: Int, _ y: Int) {
        if player != nil {
            fatalError("Multiple players")
        }
        player = Position(x: x, y: y)
    }
    
    return LevelData(
        width:width,
        height: height,
        map: map,
        boxes: boxes,
        player: player!)
}
