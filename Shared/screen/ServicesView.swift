
import SwiftUI

struct ServicesView: View {
    @EnvironmentObject var appData: ApplicationData
    @EnvironmentObject var appData2: LogData
    @ObservedObject var appState = AppState(hasOnboarded: true)
    @EnvironmentObject var apppState: AppState
    @State private var openDiolag: Bool = false
    
    var body: some View {
        List(appData.userData) { service in
            NavigationLink(destination: { 
                LogContentView(service: service).environmentObject(appData2)
            }, label: {
                HStack{
                    VStack(alignment: .leading){
                        if service.status == "UP"{
                            Text(service.serviceName).foregroundColor(.green)
                        }
                        else{
                            Text(service.serviceName).foregroundColor(.red)
                        }
                        Text(service.team).font(.system(size: 10))
                    }
                    Spacer()
                    if service.errorStatus == "ERROR"{
                        Image(systemName: "e.square").foregroundColor(.red)
                    }
                    else{
                        Image(systemName: "e.square").foregroundColor(.green)
                    }
                }
            })
        }.listStyle(.sidebar)
            .navigationTitle("Services")
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarLeading){
                    Image("porsche")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 65)
                }
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    Button(action: {
                        openDiolag = true
                    },
                        label: {Text("Logout")})
                }
                
            }
            .confirmationDialog("logout" , isPresented: $openDiolag, actions: {
                Button("Confirm", role: .none, action: {apppState.hasOnboarded = false})
                Button("Cancel", role: .cancel, action: {})
            }, message: {
                Text("Are You Sure Your Want To Logout?")
            })
                
            
    }
    
}

struct ServicesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ServicesView()
                .environmentObject(ApplicationData())
        }
    }
}
