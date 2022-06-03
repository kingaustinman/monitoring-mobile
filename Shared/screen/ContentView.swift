
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    var body: some View {
        NavigationView {
            ServicesView()
            PlaceholderView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            ContentView()
            .environmentObject(ApplicationData()).environmentObject(LogData())
    }
}
