

import SwiftUI

class AppState: ObservableObject{
    @Published var hasOnboarded: Bool
    
    init(hasOnboarded: Bool) {
        self.hasOnboarded = hasOnboarded
    }
}

@main
struct udemyApp: App {
    @StateObject var appData = ApplicationData()
    @StateObject var appData2 = LogData()
    @ObservedObject var appState = AppState(hasOnboarded: false)
    var body: some Scene {
        WindowGroup {
            if appState.hasOnboarded {
                ContentView().environmentObject(appData).environmentObject(appData2).environmentObject(appState)
            }
            else if !appState.hasOnboarded{
                LoginView()
                    .environmentObject(appState)
            }
            
        }
    }
}

