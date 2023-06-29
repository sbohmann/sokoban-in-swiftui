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

struct Level_Previews: PreviewProvider {
    static var previews: some View {
        Level(1)
    }
}
