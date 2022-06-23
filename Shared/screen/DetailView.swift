
import SwiftUI

struct DetailView: View {
    let log: LogViewModel
    @State private var limit1: Int = 1
    @State private var limit2: Int = 1
    @State private var limit3: Int = 1
    @State private var limit4: Int = 1
    @State private var limit5: Int = 1
    
    var body: some View {
        VStack (alignment: .leading, spacing: 50){

            Text(log.serviceName)
                .onTapGesture (count: 2){
                    limit1 = 1
                }
                .onTapGesture (count: 1){
                    limit1 = 10
                }
                .lineLimit(limit1)
                .truncationMode(.tail)
            Text(log.account)
                .onTapGesture (count: 2){
                    limit2 = 1
                }
                .onTapGesture (count: 1){
                    limit2 = 10
                }
                .lineLimit(limit2)
                .truncationMode(.tail)
            Text(log.groupName)
                .onTapGesture (count: 2){
                    limit3 = 1
                }
                .onTapGesture (count: 1){
                    limit3 = 10
                }
                .lineLimit(limit3)
                .truncationMode(.tail)
            Text(log.region)
                .onTapGesture (count: 2){
                    limit4 = 1
                }
                .onTapGesture (count: 1){
                    limit4 = 10
                }
                .lineLimit(limit4)
                .truncationMode(.tail)
            Text(log.link)
                .onTapGesture (count: 2){
                    limit5 = 1
                }
                .onTapGesture (count: 1){
                    limit5 = 10
                }
                .lineLimit(limit5)
                .truncationMode(.tail)
        }.padding().navigationTitle(Text("Details"))
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            DetailView(log: LogData().logsData[0])
        }
    }
}
