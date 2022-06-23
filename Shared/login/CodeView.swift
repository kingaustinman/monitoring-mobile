
import SwiftUI

struct CodeView: View {
    @Environment (\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var login: String = ""
    @State private var code: String = ""
    @State private var warning: String = "Invalid Code. Please Try Again."
    @State private var sysImage: String = "exclamationmark.triangle"
    @State private var opac: Double = 0
    @Binding var Email: String
    @Binding var sessionNumber: String
    @Binding var nameChallenge: String
    @Binding var activeLink: Bool
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
                    SecureField("4-Digit Code", text: $code)
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
                            recieveEmail()
                        }
                            .frame(maxWidth: .infinity, alignment: .trailing)
//                    NavigationLink(isActive: $activeLink,
//                                   destination: {CodeView(activeLink: $activeLink)},
//                                   label: {EmptyView()})
                    }
                    .frame(width: 300)
                    .buttonStyle(.borderedProminent)
                    .tint(Color(code.count == 4 ?  "NavyBlue" : "Gray"))
                    .foregroundColor(.white)
                    .buttonBorderShape(.roundedRectangle(radius: 12))
                }
                .padding()
                .frame(height: 100)
            }
        }
        .navigationTitle("Login")
    }
    
    
    func recieveEmail() {
        guard let url2 = URL(string: "https://cognito-idp.us-east-1.amazonaws.com/") else {
            return
        }

        var request2 = URLRequest(url: url2)

        request2.httpMethod = "POST"
        request2.setValue("AWSCognitoIdentityProviderService.RespondToAuthChallenge", forHTTPHeaderField: "x-amz-target")
        request2.setValue("application/x-amz-json-1.1", forHTTPHeaderField: "Content-Type")

        let jsonString2 = """
        {
          "ChallengeName": "\(nameChallenge)",
          "ChallengeResponses": {
            "USERNAME": "\(Email)",
            "ANSWER": "\(code)"
          },
          "ClientId": "1fmu714afc6jsegff1fkddc0et",
          "Session": "\(sessionNumber)"
        }
        """
        let data2 = jsonString2.data(using: .utf8)!

        request2.httpBody = data2

        let task2 = URLSession.shared.dataTask(with: request2) { data2, response2, error in
            guard let data2 = data2, error == nil else {
                return
            }

            do {
//                let response2 = try JSONSerialization.jsonObject(with: data2, options: .allowFragments)
                let response2 = try JSONDecoder().decode(Response2.self, from: data2)
                if response2.AuthenticationResult.TokenType == "Bearer" {
                    DispatchQueue.main.async {
                        appState.superID = response2.AuthenticationResult.IdToken
                        print("SUPER_ID: \(appState.superID)")
                    }
                    exchangeToken(accessToken: response2.AuthenticationResult.AccessToken)
                    self.presentationMode.wrappedValue.dismiss()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                        exchangeToken(accessToken: response2.AuthenticationResult.AccessToken)
                        on()
                    }
                }
//                print("CHALLENGENAME: \(response2.AuthenticationResult.TokenType)")
                
            }
            catch {
                print(error)
            }
        }
        task2.resume()
    }
    
    func exchangeToken(accessToken: String) {
        guard let url3 = URL(string: "https://iqj8u1lau3.execute-api.us-east-1.amazonaws.com/token/exchange") else {
            return
        }

        var request3 = URLRequest(url: url3)

        request3.httpMethod = "POST"
        request3.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

        let task3 = URLSession.shared.dataTask(with: request3) { data3, response3, error in
            guard let data3 = data3, error == nil else {
                return
            }

            do {
//                let response2 = try JSONSerialization.jsonObject(with: data2, options: .allowFragments)
                let response3 = try JSONDecoder().decode(Response3.self, from: data3)
                DispatchQueue.main.async {
                    print("EXCHANGE SUCCEEDED: \(response3.apiToken)")
                    appState.superToken = response3.apiToken
                    print("EXCHANGE SUCCEEDED: \(appState.superToken)")
                }
//                appState.superToken = response3.apiToken
//                print("CHALLENGENAME: \(response2.AuthenticationResult.TokenType)")
                
            }
            catch {
                print(error)
            }
        }
        task3.resume()
    }
    
    struct Response2: Codable {
        let AuthenticationResult: Result
        let ChallengeParameters: Parameters
        
        struct Result: Codable {
            let AccessToken: String
            let ExpiresIn: Int
            let IdToken: String
            let RefreshToken: String
            let TokenType: String
        }
        struct Parameters: Codable {

        }
    }
    
    struct Response3: Codable {
        let apiToken: String
    }

    func isCorrect(correctCode: String) {
        if code.count == 4 && code == correctCode {
            self.presentationMode.wrappedValue.dismiss()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                on()
            }
        }
        else{
            opac = 1
        }
    }
    
    func on() {
        appState.hasOnboarded = true
    }
    
}

struct CodeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CodeView(Email: .constant("email"), sessionNumber: .constant("sessionNumber"), nameChallenge: .constant("nameChallenge"), activeLink: .constant(true))
        }
    }
}
