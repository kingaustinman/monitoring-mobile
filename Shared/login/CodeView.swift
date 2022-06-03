
import SwiftUI

struct CodeView: View {
    @Environment (\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var login: String = ""
    @State private var code: String = ""
    @State private var warning: String = "Invalid Code. Please Try Again."
    @State private var sysImage: String = "exclamationmark.triangle"
    @State private var opac: Double = 0
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
                            isCorrect()
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
    

    func isCorrect() {
        if code.count == 4 && code == "1234" {
            self.presentationMode.wrappedValue.dismiss()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
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
            CodeView(activeLink: .constant(true))
        }
    }
}
