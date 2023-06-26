import SwiftUI

private class PathBuilder {
    private(set) var path = Path()
    
    func move(_ x: CGFloat, _ y: CGFloat) -> Self {
        path.move(to: CGPoint(x: x, y: y))
        return self
    }
    
    func line(_ x: CGFloat, _ y: CGFloat) -> Self {
        path.addLine(to: CGPoint(x: x, y: y))
        return self
    }
    
    func close() -> Self {
        path.closeSubpath()
        return self
    }
}

private func buildBrightPath() -> Path {
    return PathBuilder()
        .move(0,20)
        .line(5,15)
        .line(5,5)
        .line(15,5)
        .line(20,0)
        .line(0,0)
        .close()
        .path
}

private func buildDarkPath() -> Path {
    return PathBuilder()
        .move(0,20)
        .line(5,15)
        .line(15,15)
        .line(15,5)
        .line(20,0)
        .line(20,20)
        .close()
        .path
}

struct WallView: View {
    static let brightPath = buildBrightPath()
    static let darkPath = buildDarkPath()
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.blue)
                .frame(width: 20, height: 20)
            Self.brightPath
                .fill(Color(white: 0.8))
                .frame(width: 20, height: 20)
            Self.darkPath
                .fill(Color(white: 0.3))
                .frame(width: 20, height: 20)
        }
            .compositingGroup()
    }
}
