
//import Amplify
//import AWSCognitoAuthPlugin
import SwiftUI

class AppState: ObservableObject{
    @Published var hasOnboarded: Bool
    @Published var superToken: String
    @Published var superID: String
    
    init(hasOnboarded: Bool, superToken: String, superID: String) {
        self.hasOnboarded = hasOnboarded
        self.superToken = superToken
        self.superID = superID
    }
    
    func getSuperID() -> String{
        return superID
    }
}

//class AppDelegate: NSObject, UIApplicationDelegate {
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//
//        do {
//            try Amplify.add(plugin: AWSCognitoAuthPlugin())
//            try Amplify.configure()
//            print("Amplify configured with auth plugin")
//        } catch {
//            print("Failed to initialize Amplify with \(error)")
//        }
//
//        return true
//    }
//}

@main
struct udemyApp: App {
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var appData = ApplicationData()
    @StateObject var appData2 = LogData()
    @ObservedObject var appState = AppState(hasOnboarded: false, superToken: "1234", superID: "1234")
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

