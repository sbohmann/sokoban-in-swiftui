import SwiftUI

struct Level: View {
    private var data: LevelData
    
    init(_ number: Int) {
        data = loadLevel(number)
    }
    
    var body: some View {
        VStack {
            ForEach(0 ..< 10) { y in
                HStack {
                    ForEach(0 ..< 10) { x in
                        FieldView(data: data, position: (Position(x: x, y: y)))
                    }
                }
            }
        }
    }
}

private struct FieldView: View {
    let data: LevelData
    let position: Position
    
    var body: some View {
        if (position == data.player) {
            Text("P")
        } else {
            switch(data.get(position)) {
            case .wall:
                WallView()
            case .open:
                Text("O")
            case .target:
                Text("X")
            }
        }
    }
}

private struct LevelData {
    let width, height: Int
    let map: [Field]
    let boxes: [Position]
    let player: Position
    
    func get(_ position: Position) -> Field {
        return get(position.x, position.y)
    }
    
    func get(_ x: Int, _ y: Int) -> Field {
        return map[y * width + x]
    }
}

private enum Field {
    case wall
    case open
    case target
}

private struct Position: Equatable {
    let x, y: Int
}

private func loadLevel(_ number: Int) -> LevelData {
    return LevelData(width:10, height: 10,
                     map:
                     [.wall, .wall, .wall, .wall, .wall, .wall, .wall, .wall, .wall, .wall,
                      .wall, .wall, .wall, .wall, .wall, .wall, .wall, .wall, .wall, .wall,
                      .wall, .wall, .wall, .wall, .wall, .wall, .wall, .wall, .wall, .wall,
                      .wall, .wall, .wall, .wall, .wall, .wall, .wall, .wall, .wall, .wall,
                      .wall, .wall, .wall, .wall, .wall, .wall, .wall, .wall, .wall, .wall,
                      .wall, .wall, .wall, .wall, .wall, .wall, .wall, .wall, .wall, .wall,
                      .wall, .wall, .wall, .wall, .wall, .wall, .wall, .wall, .wall, .wall,
                      .wall, .wall, .wall, .wall, .wall, .wall, .wall, .wall, .wall, .wall,
                      .wall, .wall, .wall, .wall, .wall, .wall, .wall, .wall, .wall, .wall,
                      .wall, .wall, .wall, .wall, .wall, .wall, .wall, .wall, .wall, .wall],
                     boxes: [],
                     player: Position(x: 5, y: 5))
}

struct Level_Previews: PreviewProvider {
    static var previews: some View {
        Level(1)
    }
}
