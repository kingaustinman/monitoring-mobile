
import SwiftUI

struct LogContentView: View {
    @EnvironmentObject var appState: AppState
    
    let service: ServiceViewModel
    
    var body: some View {

            LogsView(service: service)
    }
}

struct LogContentView_Previews: PreviewProvider {
    static var previews: some View {
        LogContentView(service: ApplicationData().userData[0])
                .environmentObject(LogData())
    }
}
