
import SwiftUI

struct LoginView: View {
    @State private var login: String = ""
    @State private var Email: String = ""
    @State private var sessionNumber: String = ""
    @State private var nameChallenge: String = ""
    @State private var warning: String = "Email must be Valid."
    @State private var sysImage: String = "exclamationmark.triangle"
    @State private var opac: Double = 0
    @State private var activeLink: Bool = false
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationView{
            ZStack{
                Image("Image")
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .blur(radius: 3)
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 5) {
                    Text(login)
                        .bold()
                        .font(.system(size: 35))
                        .padding()
                    TextField("Insert Email", text: $Email)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 300)
                        .autocapitalization(.none)
                    HStack(spacing: 22){
                        Spacer()
                        Label(warning, systemImage: sysImage)
                            .foregroundColor(.red)
                            .opacity(opac)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    HStack(spacing: 1){
                        Button("Enter"){
                            isCorrect(email: Email)
//                            sendEmail()
                        }
                            .frame(maxWidth: .infinity, alignment: .trailing)
//                    NavigationLink(isActive: $activeLink,
//                                   destination: {CodeView(activeLink: $activeLink)},
//                                   label: {EmptyView()})
                    }
                    .frame(width: 300)
                    .buttonStyle(.borderedProminent)
                    .tint(Color(isEmailValid() ?  "NavyBlue" : "Gray"))
                    .foregroundColor(.white)
                    .buttonBorderShape(.roundedRectangle(radius: 12))
                    .popover(isPresented: $activeLink, arrowEdge: .top) {
                        CodeView(Email: $Email, sessionNumber: $sessionNumber, nameChallenge: $nameChallenge, activeLink: $activeLink)
                    }
                }
                .padding()
                .frame(height: 100)
            }
        }
        .navigationTitle("Login")
    }
    

    func isCorrect(email: String) {
        if isEmailValid() {
            sendEmail(email: email)
            activeLink = true
        }
        else{
            opac = 1
        }
    }
    
    func sendEmail(email: String) {
        guard let url = URL(string: "https://cognito-idp.us-east-1.amazonaws.com/") else {
            return
        }

        var request = URLRequest(url: url)

        request.httpMethod = "POST"
        request.setValue("AWSCognitoIdentityProviderService.InitiateAuth", forHTTPHeaderField: "x-amz-target")
        request.setValue("application/x-amz-json-1.1", forHTTPHeaderField: "Content-Type")

        let jsonString = """
        {
            "AuthFlow": "CUSTOM_AUTH",
            "ClientId": "1fmu714afc6jsegff1fkddc0et",
            "AuthParameters": {
                "USERNAME": "\(email)"
            },
            "ClientMetadata": {}
        }
        """
        let data = jsonString.data(using: .utf8)!
//        let body: String: Any = [
//            "AuthFlow": "CUSTOM_AUTH",
//            "ClientId": "2pqva98pt6ert0gt286nv89ld8",
//            "AuthParameters": [
//                "USERNAME": "anthony.daga.extern@porsche.digital"
//            ],
//            "ClientMetadata": []
//        ]
        

//        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        request.httpBody = data

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                return
            }

            do {
//                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                let response = try JSONDecoder().decode(Response.self, from: data)
//                print("SUCCESS: \(response)")
//                print("CHALLENGENAME: \(response.ChallengeName)")
//                print("USERNAME: \(response.ChallengeParameters.USERNAME)")
//                print("EMAIL: \(response.ChallengeParameters.email)")
//                print("SESSION: \(response.Session)")
//                recieveEmail(session: response.Session, email: response.ChallengeParameters.email, challengeName: response.ChallengeName)
                nameChallenge = response.ChallengeName
                Email = response.ChallengeParameters.email
                sessionNumber = response.Session
                
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
    
    struct Response: Codable {
        let ChallengeName: String
        let ChallengeParameters: Challenges
        let Session: String
        
        struct Challenges: Codable {
            let USERNAME: String
            let email: String
        }
    }

    
      
    
    func isEmailValid() -> Bool {
        let emailTest = NSPredicate(format: "SELF MATCHES %@",
                                    "^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$")
        return emailTest.evaluate(with: Email)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginView()
        }
    }
}
