
import SwiftUI

struct LoginView: View {
    @State private var login: String = ""
    @State private var email: String = ""
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
                    TextField("Insert Email", text: $email)
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
                            isCorrect()
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
                        CodeView(activeLink: $activeLink)
                    }
                }
                .padding()
                .frame(height: 100)
            }
        }
        .navigationTitle("Login")
    }
    

    func isCorrect() {
        if isEmailValid() {
            activeLink = true
        }
        else{
            opac = 1
        }
    }
    
    func isEmailValid() -> Bool {
        let emailTest = NSPredicate(format: "SELF MATCHES %@",
                                    "^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$")
        return emailTest.evaluate(with: email)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginView()
        }
    }
}
