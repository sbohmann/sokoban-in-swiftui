import SwiftUI

enum CurrentView {
    case menu
    case level
    case selectLevel
}

struct ContentView: View {
    @State private var currentView = CurrentView.menu
    
    var body: some View {
        ZStack {
            Background()
            switch currentView {
            case .menu: Menu(setCurrentView: setCurrentView)
            case .level: Level(1).scaledToFit()
            case .selectLevel: Text("Select Level:")
            }
        }
        .foregroundColor(.white)
    }
    
    func setCurrentView(view: CurrentView) {
        currentView = view
    }
}

struct Background: View {
    var body: some View {
        Spacer().background(.black).scaledToFill()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
