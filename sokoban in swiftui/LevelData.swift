import Foundation

struct LevelData {
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
    
    func target(_ position: Position) -> Bool {
        return get(position) == .target
    }
    
    mutating func moveBox(from: Position, to: Position) {
        if let index = boxes.firstIndex(of: from) {
            boxes[index] = to
        }
    }
}

enum Field {
    case wall
    case open
    case target
}

struct Position: Equatable {
    let x, y: Int
    
    func movedBy(_ dx: Int, _ dy: Int) -> Position {
        return Position(x: x + dx, y: y + dy)
    }
}
