
import SwiftUI

struct PlaceholderView: View {
    var body: some View {
        VStack {
            Text("Select a Show")
            Spacer()
        }.padding()
    }
}

struct PlaceholderView_Previews: PreviewProvider {
    static var previews: some View{
        PlaceholderView()
            .environmentObject(ApplicationData())
    }
}
