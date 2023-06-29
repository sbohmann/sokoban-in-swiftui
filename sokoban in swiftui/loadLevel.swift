import Foundation

func loadLevel(_ number: Int) -> LevelData {
    print("Current directory: [\(Bundle.main.path(forResource: "level1.txt", ofType: nil) ?? "none")]")
    let path = "level\(number).txt"
    if !FileManager.default.fileExists(atPath: path) {
        fatalError("Resource not found [\(path)]")
    }
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
