import SwiftUI

struct Level: View {
    @State private var game: Game
    private let exitLevel: () -> ()
    @State private var exitToMenuConfirmationDialogVisible = false
    
    init(_ number: Int, _ exitLevel: @escaping () -> ()) {
        game = Game(data: loadLevel(number))
        self.exitLevel = exitLevel
    }
    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                ScrollView(.horizontal) {
                    VStack(spacing: 0) {
                        ForEach(0 ..< game.data.height, id: \.self) { y in
                            HStack(spacing: 0) {
                                ForEach(0 ..< game.data.width, id: \.self) { x in
                                    FieldView(data: game.data, position: (Position(x: x, y: y)))
                                }
                            }
                        }
                    }.frame(width: CGFloat(20 * game.data.width), height: CGFloat(20 * game.data.height))
                }.frame(width: UIScreen.main.bounds.width)
            }
            Spacer()
            HStack {
                Button("<-", action:
                {
                    exitToMenuConfirmationDialogVisible = true
                })
                    .confirmationDialog(LocalizedStringKey(stringLiteral: "Exit to menu?"),
                                        isPresented: $exitToMenuConfirmationDialogVisible) {
                        Button("Exit") {
                            exitLevel()
                        }
                        .frame(width: 10, height: 10)
                    }
                    .keyboardShortcut(.escape, modifiers: [])
                    .frame(width: 60, height: 60)
                Spacer()
                    .frame(width: 60, height: 60)
                Button("^") {
                    game.up()
                }
                .keyboardShortcut(.upArrow, modifiers: [])
                .frame(width: 60, height: 60)
                Spacer()
                    .frame(width: 60, height: 60)
                Spacer()
                    .frame(width: 60, height: 60)
            }
            HStack {
                Button("<") {
                    game.left()
                }
                .keyboardShortcut(.leftArrow, modifiers: [])
                .frame(width: 60, height: 60)
                Spacer()
                    .frame(width: 60, height: 60)
                Button(">") {
                    game.right()
                }
                .keyboardShortcut(.rightArrow, modifiers: [])
                .frame(width: 60, height: 60)
            }
            Button("v") {
                game.down()
            }
            .keyboardShortcut(.downArrow, modifiers: [])
            .frame(width: 60, height: 60)
        }
        .scaledToFit()
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
                BoxView(onTarget: data.target(position))
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
        Level(1, {})
    }
}
