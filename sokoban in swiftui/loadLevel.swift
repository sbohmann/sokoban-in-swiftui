import Foundation

func loadLevel(_ number: Int) -> LevelData {
    let levelFilePath = Bundle.main.path(forResource: "level\(number).txt", ofType: nil)!
    let levelDescription = try! String(contentsOfFile: levelFilePath)
    print(levelDescription.split(separator: "\n"))
    return LevelData(width:10, height: 10,
                     map:
                     [.wall, .wall, .wall, .wall, .wall, .wall, .wall, .wall, .wall, .wall,
                      .wall, .wall, .wall, .wall, .wall, .wall, .wall, .wall, .wall, .wall,
                      .wall, .wall, .wall, .wall, .wall, .wall, .wall, .wall, .wall, .wall,
                      .wall, .wall, .wall, .open, .open, .open, .wall, .wall, .wall, .wall,
                      .wall, .wall, .wall, .open, .open, .target, .open, .wall, .wall, .wall,
                      .wall, .wall, .open, .open, .open, .open, .open, .open, .wall, .wall,
                      .wall, .wall, .open, .open, .open, .open, .open, .wall, .wall, .wall,
                      .wall, .wall, .wall, .open, .target, .open, .wall, .wall, .wall, .wall,
                      .wall, .wall, .wall, .wall, .wall, .wall, .wall, .wall, .wall, .wall,
                      .wall, .wall, .wall, .wall, .wall, .wall, .wall, .wall, .wall, .wall],
                     boxes: [Position(x: 4, y: 4)],
                     player: Position(x: 5, y: 5))
}
