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
    for y in 0 ..< height {
        let line = lines[y]
        for x in 0 ..< width {
            if x < line.count {
                let character = line[x]
                switch character {
                case " ":
                    map.append(.open)
                case ".":
                    map.append(.target)
                case "#":
                    map.append(.wall)
                case "@":
                    map.append(.open)
                    if player != nil {
                        fatalError("Multiple players")
                    }
                    player = Position(x: x, y: y)
                case "+":
                    map.append(.target)
                    if player != nil {
                        fatalError("Multiple players")
                    }
                    player = Position(x: x, y: y)
                case "$":
                    map.append(.open)
                    boxes.append(Position(x: x, y: y))
                case "*":
                    map.append(.target)
                    boxes.append(Position(x: x, y: y))
                default:
                    fatalError("Illegal character [\(character)]")
                }
            } else {
                map.append(.open)
            }
        }
    }
    
    if (map.count != width * height) {
        fatalError("map size is off")
    }
    
    return LevelData(width:width,
                     height: height,
                     map: map,
                     boxes: boxes,
                     player: player!)
}
