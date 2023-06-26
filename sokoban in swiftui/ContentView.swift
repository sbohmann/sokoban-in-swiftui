import SwiftUI

enum CurrentView {
    case menu
    case level
    case selectLevel
}

struct ContentView: View {
    @State private var currentView = CurrentView.menu
    
    var body: some View {
        switch currentView {
        case .menu: Menu(setCurrentView: setCurrentView)
        case .level: Level(1)
        case .selectLevel: Text("Select Level:")
        }
    }
    
    func setCurrentView(view: CurrentView) {
        currentView = view
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
