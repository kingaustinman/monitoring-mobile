
import SwiftUI

struct LogsView: View {
    @EnvironmentObject var appData2: LogData
    @ObservedObject var appState = AppState(hasOnboarded: true, superToken: "1234", superID: "1234")
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
                if service.componentStatuss == "UP" {
                    Text("Components: " )
                    Spacer().frame(width: 214)
                    Image(systemName: "e.square").foregroundColor(.red)
                }
                else if service.componentStatuss == "DOWN"{
                    Text(service.components).bold()
                    Spacer().frame(width: 180)
                    Image(systemName: "e.square").foregroundColor(.red)
                }
            }
            VStack{
                    Text(service.components)
            }
            HStack{
                Text(service.name).font(.system(size: 10))
                
            }
            HStack{
                Text(service.email).font(.system(size: 10))
            }
        }
        List(service.service.logging) { logging in
            NavigationLink(destination: {
                DetailView(log: logging)
            }, label: {
                HStack{
                    if logging.errorStatus == "ERROR" {
                        Text(logging.groupName).foregroundColor(.red)
                    }
                    else{
                        Text(logging.groupName)
                    }
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
