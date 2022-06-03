
import SwiftUI

struct LogsView: View {
    @EnvironmentObject var appData2: LogData
    @ObservedObject var appState = AppState(hasOnboarded: true)
    @EnvironmentObject var apppState: AppState
    
    
    let service: ServiceViewModel
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text(service.team).bold()
                if service.team == "Platform" {
                    Spacer().frame(width: 250)
                }
                else{
                    Spacer().frame(width: 200)
                }
                if service.status == "UP"{
                    Image(systemName: "circle.fill").foregroundColor(.green)
                }
                else{
                    Image(systemName: "circle.fill").foregroundColor(.red)
                }
            }
            HStack{
                Text(service.name)
            }
            HStack{
                Text(service.email)
            }
        }
        List(service.service.logging) { logging in
            NavigationLink(destination: {
                DetailView(log: logging)
            }, label: {
                HStack{
                    Text(logging.groupName)
                    Spacer()
                    if logging.errorStatus == "ERROR" {
                        Image(systemName: "e.square").foregroundColor(.red)
                    }
                    else{
                        Image(systemName: "e.square").foregroundColor(.green)
                    }
                }
            })
        }.listStyle(.sidebar).navigationTitle(service.serviceName)
                
    }
    
}

struct LogsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LogsView(service: ApplicationData().userData[1])
                .environmentObject(LogData())
        }
    }
}
