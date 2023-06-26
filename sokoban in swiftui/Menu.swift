import SwiftUI

struct Menu: View {
    let setCurrentView: (CurrentView) -> ()
    
    var body: some View {
        VStack {
            Text("MENU")
                .padding()
            Button("Start", action: self.start)
                .padding()
            Button("Select Level", action: self.selectLevel)
                .padding()
        }
    }
    
    func start() {
        setCurrentView(.level)
    }
    
    func selectLevel() {
        setCurrentView(.selectLevel)
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu { view in }
    }
}
