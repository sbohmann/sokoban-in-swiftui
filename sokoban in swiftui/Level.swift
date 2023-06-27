import SwiftUI

struct Level: View {
    @State private var game: Game
    
    init(_ number: Int) {
        game = Game(data: loadLevel(number))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0 ..< 10) { y in
                HStack(spacing: 0) {
                    ForEach(0 ..< 10) { x in
                        FieldView(data: game.data, position: (Position(x: x, y: y)))
                    }
                }
            }
            Spacer()
            Button("^") {
                game.up()
            }
            HStack {
                Button("<") {
                    game.left()
                }
                Text(" ")
                Button(">") {
                    game.right()
                }
            }
            Button("v") {
                game.down()
            }
        }
    }
}

private struct FieldView: View {
    let data: LevelData
    let position: Position
    
    var body: some View {
        ZStack {
            switch(data.get(position)) {
            case .wall:
                WallView()
            case .open:
                OpenView()
            case .target:
                TargetView()
            }
            if (data.box(position)) {
                BoxView()
            }
            if (position == data.player) {
                PlayerView()
            }
        }
    }
}

private struct Game {
    var data: LevelData
    
    mutating func up() {
        move(0, -1)
    }
    
    mutating func left() {
        move(-1, 0)
    }
    
    mutating func right() {
        move(1, 0)
    }
    
    mutating func down() {
        move(0, 1)
    }
    
    mutating private func move(_ dx: Int, _ dy: Int) {
        let next = data.player.movedBy(dx, dy)
        let beyond = next.movedBy(dx, dy)
        if (data.free(next)) {
            data.player = next
        } else if (data.box(next) && data.free(beyond)) {
            data.moveBox(from: next, to: beyond)
            data.player = next
        }
    }
}

private struct LevelData {
    let width, height: Int
    let map: [Field]
    var boxes: [Position]
    var player: Position
    
    func get(_ position: Position) -> Field {
        return get(position.x, position.y)
    }
    
    func get(_ x: Int, _ y: Int) -> Field {
        if (x >= 0 && y >= 0 && x < width && y < height) {
            return map[y * width + x]
        } else {
            return .wall
        }
    }
            
    func free(_ position: Position) -> Bool {
        switch (get(position)) {
        case .open, .target:
            return !box(position)
        default:
            return false
        }
    }
    
    func box(_ position: Position) -> Bool {
        return boxes.contains(position)
    }
    
    mutating func moveBox(from: Position, to: Position) {
        if let index = boxes.firstIndex(of: from) {
            boxes[index] = to
        }
    }
}

private enum Field {
    case wall
    case open
    case target
}

private struct Position: Equatable {
    let x, y: Int
    
    func movedBy(_ dx: Int, _ dy: Int) -> Position {
        return Position(x: x + dx, y: y + dy)
    }
}

private func loadLevel(_ number: Int) -> LevelData {
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

struct Level_Previews: PreviewProvider {
    static var previews: some View {
        Level(1)
    }
}
