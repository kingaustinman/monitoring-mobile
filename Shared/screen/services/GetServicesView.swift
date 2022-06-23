
import SwiftUI


struct Servicer: Hashable, Codable {
    let services: [ListServices]
    
    struct ListServices: Hashable, Codable {
        let contactInfo: Info
        let healthStatus: Status
        let serviceName: String
        let lastUpdateTS: String
        let team: String
    }
    
    struct Info: Hashable, Codable {
        let name: String
        let email: String
    }
    struct Status: Hashable, Codable {
        let components: Component?
        let status: String
    }
        struct Component: Hashable, Codable {
            let vehicleInfoService: String
            
            private enum CodingKeys : String, CodingKey {
                    case vehicleInfoService = "Vehicle Info Service"
                }
        }
    
}

class WebSocketStream: AsyncSequence {

    typealias Element = URLSessionWebSocketTask.Message
    typealias AsyncIterator = AsyncThrowingStream<URLSessionWebSocketTask.Message, Error>.Iterator
    
    private var stream: AsyncThrowingStream<Element, Error>?
        private var continuation: AsyncThrowingStream<Element, Error>.Continuation?
        private let socket: URLSessionWebSocketTask
        
    init(url: String, session: URLSession = URLSession.shared) {
            socket = session.webSocketTask(with: URL(string: url+"eyJraWQiOiJLTzdSdld1b080SlwvZ082Wlpxak12eFVFSWVuQU9XVEl3d2M4dGlrTXdPYz0iLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJkMmViNjlhYi1hZTlmLTQ4YmEtYWRiMy0wNjZkY2E5ZWQ2YzAiLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiaXNzIjoiaHR0cHM6XC9cL2NvZ25pdG8taWRwLnVzLWVhc3QtMS5hbWF6b25hd3MuY29tXC91cy1lYXN0LTFfY3JWQXdXY2JGIiwiY29nbml0bzp1c2VybmFtZSI6ImQyZWI2OWFiLWFlOWYtNDhiYS1hZGIzLTA2NmRjYTllZDZjMCIsIm9yaWdpbl9qdGkiOiJiNzJjMDBiYS0xYzE2LTRjOTEtYTY3MS05MDk2ZTkzZDRlYjMiLCJhdWQiOiIxZm11NzE0YWZjNmpzZWdmZjFma2RkYzBldCIsImV2ZW50X2lkIjoiZDEzOTIxYTgtNDQ3YS00MjU1LThhMjItODAxNmMzMTljY2NmIiwidG9rZW5fdXNlIjoiaWQiLCJhdXRoX3RpbWUiOjE2NTU5NjMxNzYsImV4cCI6MTY1NTk2Njc3NiwiaWF0IjoxNjU1OTYzMTc2LCJqdGkiOiJkZDA0YWZhMy0wYjFmLTQzYTktOTBlOS1mOTU4NGNmZDUzODIiLCJlbWFpbCI6ImF1c3RpbkBhYnN0cmFjdGVkLmlvIn0.pFvIFZJf4Oay0QyN1eRbIJll3XTK9Hpm3YfDUqbhQxSs67QQUL9yjmBGXrwGlpZIlMybpCPXo_jDNKVMNpkXyNSTRz63QoFNkJHXvWQAUgP8i2nQ2UwiUnkR0vLEbslAZIk5nqMrPtoQ3kLgRn_EHfOQzBzs0le9hkH1QgWU6PGNhhmkaj_dfcBorWsRbqMTh7BxbBxJOWugEJCfWAKT6cvwjFA9KvFZZWFGjjJcDZAjrB1zEz2o9E_vy-e8FFADlgz1kHDdJL0FIhn8y0wurgk9jfE_Bs5KO3M4jnQW7KprM4iVjuy-xWp-bONOaQMHJIqpTCN0Dpmz34o5H2Bc4w",
                                                     "RefreshToken": "eyJjdHkiOiJKV1QiLCJlbmMiOiJBMjU2R0NNIiwiYWxnIjoiUlNBLU9BRVAifQ")!)
            stream = AsyncThrowingStream { continuation in
                self.continuation = continuation
                self.continuation?.onTermination = { @Sendable [socket] _ in
                    socket.cancel()
                    print("CONNECTION WAS LOST")
                }
            }
        }
    
    func makeAsyncIterator() -> AsyncIterator {
        guard let stream = stream else {
            fatalError("stream was not initialized")
        }
        print("STREAM WAS INITIALIZED")
        socket.resume()
        listenForMessages()
        return stream.makeAsyncIterator()
    }
    
    private func listenForMessages() {
        socket.receive { [unowned self] result in
            switch result {
            case .success(let message):
                continuation?.yield(message)
                listenForMessages()
            case .failure(let error):
                continuation?.finish(throwing: error)
            }
        }
    }
}

class ViewModelService: ObservableObject {
    @Published var service: Servicer = Servicer(services: [])
    
    var timer = Timer()

    func viewDidLoad(theToken: String) {
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.fetch(theToken: theToken)
        })
    }


    func fetch(theToken: String) {
        guard let url = URL(string:
            "https://iqj8u1lau3.execute-api.us-east-1.amazonaws.com/services") else {
            return
        }
        
        var request = URLRequest(url: url)
        print("Making Fetch Request: \(theToken)")
        request.httpMethod = "GET"
        request.setValue("Bearer \(theToken)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            do {
//                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                let servicee = try JSONDecoder().decode(Servicer.self, from: data)
                DispatchQueue.main.async {
//                    print("SUCCEEDED: \(response)")
                    self?.service = servicee
                }

            }
            catch {
                print("ERROR: \(error)")
            }
        }
        
        task.resume()
    }
    
}


struct GetServicesView: View {
    @EnvironmentObject var appState: AppState
    @StateObject var viewModelService = ViewModelService()
    @State private var openDiolag: Bool = false
    @EnvironmentObject var appppState: AppState
    private let stream = WebSocketStream(url: "wss://dbaqkri5s7.execute-api.us-east-1.amazonaws.com/ad?idToken=")
    
    var body: some View {
            List(viewModelService.service.services, id: \.self) { service in
                NavigationLink(destination: {
                    GetLogsView(serviceName: .constant(service.serviceName)).environmentObject(appState)
                }, label: {
                    Text(service.serviceName)
                })
            }.listStyle(.sidebar)
            .navigationTitle("ServicesTitle")
                .task {
                    do {
                        for try await message in stream {
                            print("A NEW SERVICE WAS CREATED")
                            viewModelService.fetch(theToken: appState.superToken)
                        }
                    } catch {
                        debugPrint("Oops something didn't go right")
                    }
                }
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
    //                ToolbarItemGroup(placement: .navigationBarTrailing){
    //                    NavigationLink(destination: {
    //                        AddServiceView()
    //                    }, label: {Text("add")})
    //                }
                    
                }
                .confirmationDialog("logout" , isPresented: $openDiolag, actions: {
                    Button("Confirm", role: .none, action: {appppState.hasOnboarded = false})
                    Button("Cancel", role: .cancel, action: {})
                }, message: {
                    Text("Are You Sure Your Want To Logout?")
                })
                .onAppear {
                    print ("ON APPEAR: \(appState.superToken) \(appState.hasOnboarded)")
                    viewModelService.fetch(theToken: appState.superToken)
                }
                
    }
}

struct GetServicesView_Previews: PreviewProvider {
    static var previews: some View {
        GetServicesView()
    }
}

