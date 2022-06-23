
import SwiftUI

public extension String {
    
    func urlEncoded() -> String? {
        addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
    }
}

struct Logger: Hashable, Codable {
    let logGroups: [ListLogs]
    
    struct ListLogs: Hashable, Codable {
        let logGroupLink: String
        let serviceName: String
        let awsAccount: String
        let logGroupId: String
        let awsRegion: String
        let logGroupName: String
        let lastUpdateTS: String
    }
    
}

class ViewModelLog: ObservableObject {
    @Published var log: Logger = Logger(logGroups: [])

    func fetch(sName: String, theToken: String) {
        
        let urlServiceName = sName.addingPercentEncoding(
            withAllowedCharacters: .urlQueryAllowed
        )
        
        guard let url = URL(string:
                                "https://iqj8u1lau3.execute-api.us-east-1.amazonaws.com/loggroups/\(urlServiceName ?? "yessir")") else {
            return
        }
        
        var request = URLRequest(url: url)

        request.httpMethod = "GET"
        request.setValue("Bearer \(theToken)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            do {
//                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                let log = try JSONDecoder().decode(Logger.self, from: data)
                DispatchQueue.main.async {
//                    print("SUCCEEDED: \(response)")
                    self?.log = log
                }
            }
            catch {
                print("ERROR: \(error)")
            }
        }
        
        task.resume()
    }
    
}



struct GetLogsView: View {
    @EnvironmentObject var appState: AppState
    @StateObject var viewModelLog = ViewModelLog()
    @Binding var serviceName: String
    
    var body: some View {
            List(viewModelLog.log.logGroups, id: \.self) { log in
                NavigationLink(destination: {
                    PlaceholderView()
                }, label: {
                    Text(log.logGroupId)
                })
            }.listStyle(.sidebar)
                .navigationTitle("LogGroupsTitle")
                .onAppear {
                    viewModelLog.fetch(sName: serviceName, theToken: appState.superToken)
                }
    }
}

struct GetLogsView_Previews: PreviewProvider {
    static var previews: some View {
        GetLogsView(serviceName: .constant("super"))
    }
}


