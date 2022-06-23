
import SwiftUI

struct AddServiceView: View {
    @EnvironmentObject var appData: ApplicationData
    @Environment(\.dismiss) var dismiss
    @State private var nameInput: String = ""
    @State private var emailInput: String = ""
    @State private var serviceNameInput: String = ""
    @State private var statusInput: String = ""
    @State private var teamInput: String = ""
    @State private var errorStatusInput: String = ""
    @State private var logEventsWithErrorsTSInput: String = ""
    @State private var componentsInput: String = ""
    @State private var componentStatusInput: String = ""
    var service: ServiceViewModel?
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 12) {
            HStack {
                Text(service == nil ? "Add Service" : "Edit Service")
                    .font(.body.weight(.bold))
                Spacer()
                Button("Close") {
                    dismiss()
                }.padding([.top, .bottom], 12)
            }
            TextField("Insert name", text: $nameInput)
                .textFieldStyle(.roundedBorder)
            TextField("Insert email", text: $emailInput)
                .textFieldStyle(.roundedBorder)
            TextField("Insert service name", text: $serviceNameInput)
                .textFieldStyle(.roundedBorder)
            TextField("Insert status", text: $statusInput)
                .textFieldStyle(.roundedBorder)
            TextField("Insert team", text: $teamInput)
                .textFieldStyle(.roundedBorder)
            TextField("Insert error status", text: $errorStatusInput)
                .textFieldStyle(.roundedBorder)
            TextField("Insert logEvnetsWIthErrors", text: $logEventsWithErrorsTSInput)
                .textFieldStyle(.roundedBorder)
//            TextField("Insert Title", text: $componentsInput)
//                .textFieldStyle(.roundedBorder)
//            TextField("Insert Title", text: $componentStatusInput)
//                .textFieldStyle(.roundedBorder)
            Button("Save") {
                storeService()
                dismiss()
            }.buttonStyle(.borderedProminent)
            Spacer()
        }.padding()
            .onAppear {
                nameInput = service?.name ?? ""
                emailInput = service?.email ?? ""
                serviceNameInput = service?.serviceName ?? ""
                statusInput = service?.status ?? ""
                teamInput = service?.team ?? ""
                errorStatusInput = service?.errorStatus ?? ""
                logEventsWithErrorsTSInput = service?.logEventsWithErrorsTS ?? ""
                componentsInput = service?.components ?? ""
                componentStatusInput = service?.componentStatuss ?? ""
                
            }
    }
    func storeService() {
        let name = nameInput.trimmingCharacters(in: .whitespaces)
        let email = emailInput.trimmingCharacters(in: .whitespaces)
        let serviceName = serviceNameInput.trimmingCharacters(in: .whitespaces)
        let status = statusInput.trimmingCharacters(in: .whitespaces)
        let team = teamInput.trimmingCharacters(in: .whitespaces)
        let errorStatus = errorStatusInput.trimmingCharacters(in: .whitespaces)
        let logEventsWithErrorsTS = logEventsWithErrorsTSInput.trimmingCharacters(in: .whitespaces)
        let components = componentsInput.trimmingCharacters(in: .whitespaces)
        let componentsStatus = componentStatusInput.trimmingCharacters(in: .whitespaces)
        

            let newService = ServiceViewModel(service: Service(name: name, email: email, serviceName: serviceName, status: status, team: team, errorStatus: errorStatus, logEventsWithErrorsTS: logEventsWithErrorsTS, components: components, componentsStatus: componentsStatus, selected: false, logging: [
                LogViewModel(log: Log(link: "https://us-east-1.console.aws.amazon.com/cloudwatch/home?region=us-east-1#logsV2:log-groups/log-group/%2Faws%2Flambda%2Fslatldisal-ad-osaappbff-osaAuth", serviceName: "One Sales", account: 657003001523, region: "US-east-1", groupName: "/aws/lambda/slatldisal-ad-osaappbff-osaAuth",errorStatus: "ERROR", logEventsWithErrorsTS: "2022-06-02T22:50:25Z", selected: false)),
                LogViewModel(log: Log(link: "https://us-east-1.console.aws.amazon.com/cloudwatch/home?region=us-east-1#logsV2:log-groups/log-group/%2Faws%2Flambda%2Fslatldisal-ad-osaappbff-osaBFFApp", serviceName: "One Sales", account: 657003001523, region: "US-east-1", groupName: "/aws/lambda/slatldisal-ad-osaappbff-osaBFFApp", selected: false)),
                LogViewModel(log: Log(link: "https://us-east-1.console.aws.amazon.com/cloudwatch/home?region=us-east-1#logsV2:log-groups/log-group/%2Faws%2Flambda%2Fslatldisal-ad-osaappbff-osaBFFEvent", serviceName: "One Sales", account: 657003001523, region: "US-east-1", groupName: "/aws/lambda/slatldisal-ad-osaappbff-osaBFFEvent", selected: false)),
            ]))
            appData.userData.append(newService)
    
        
    }
}

struct AddServiceView_Previews: PreviewProvider {
    static var previews: some View {
        AddServiceView()
    }
}




