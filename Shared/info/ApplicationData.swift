
import SwiftUI

struct Service {
    var name: String
    var email: String
    var serviceName: String
    var status: String
    var team: String
    var errorStatus: String?
    var logEventsWithErrorsTS: String?
    var components: String?
    var componentsStatus: String?
    var selected: Bool
    var logging: [LogViewModel]
}

struct ServiceViewModel: Identifiable {
    let id = UUID()
    var service: Service
    
    var name: String {
        return service.name.capitalized
    }
    var email: String {
        return service.email
    }
    var serviceName: String {
        return service.serviceName
    }
    var status: String {
        return String(service.status)
    }
    var team: String {
        return service.team
    }
    var errorStatus: String {
        return service.errorStatus ?? ""
    }
    var logEventsWithErrorsTS: String {
        return service.logEventsWithErrorsTS ?? ""
    }
    var components: String {
        return service.components ?? ""
    }
    var componentStatuss: String {
        return service.componentsStatus ?? ""
    }
//    var year: String {
//        return String(service.year)
//    }
    var selected: Bool {
        get {
            return service.selected
        }
        set {
            service.selected = newValue
        }
    }
}

class ApplicationData: ObservableObject {
    @Published var userData: [ServiceViewModel]
    
    init() {
        userData = [
            ServiceViewModel(service: Service(name: "Scott MacCombie", email: "scott.maccombie@porsche.digital", serviceName: "One Sales", status: "UP", team: "Targa Acquired", errorStatus: "ERROR", logEventsWithErrorsTS: "2022-06-02T22:50:25Z", components: "Vehicle Info Service", componentsStatus: "UP", selected: false, logging: [
                LogViewModel(log: Log(link: "https://us-east-1.console.aws.amazon.com/cloudwatch/home?region=us-east-1#logsV2:log-groups/log-group/%2Faws%2Flambda%2Fslatldisal-ad-osaappbff-osaAuth", serviceName: "One Sales", account: 657003001523, region: "US-east-1", groupName: "/aws/lambda/slatldisal-ad-osaappbff-osaAuth",errorStatus: "ERROR", logEventsWithErrorsTS: "2022-06-02T22:50:25Z", selected: false)),
                LogViewModel(log: Log(link: "https://us-east-1.console.aws.amazon.com/cloudwatch/home?region=us-east-1#logsV2:log-groups/log-group/%2Faws%2Flambda%2Fslatldisal-ad-osaappbff-osaBFFApp", serviceName: "One Sales", account: 657003001523, region: "US-east-1", groupName: "/aws/lambda/slatldisal-ad-osaappbff-osaBFFApp", selected: false)),
                LogViewModel(log: Log(link: "https://us-east-1.console.aws.amazon.com/cloudwatch/home?region=us-east-1#logsV2:log-groups/log-group/%2Faws%2Flambda%2Fslatldisal-ad-osaappbff-osaBFFEvent", serviceName: "One Sales", account: 657003001523, region: "US-east-1", groupName: "/aws/lambda/slatldisal-ad-osaappbff-osaBFFEvent", selected: false)),
            ])),
            ServiceViewModel(service: Service(name: "Ben Fletcher", email: "ben.fletcher@porsche.digital", serviceName: "Vehicle Info Service", status: "UP", team: "Platform", selected: false, logging: [
                LogViewModel(log: Log(link: "https://us-east-2.console.aws.amazon.com/cloudwatch/home?region=us-east-2#logsV2:log-groups/log-group/%2Faws%2Flambda%2Fslatldisal-ad-vehicleser-gap167ImporterTask", serviceName: "Vehicle Info Service", account: 657003001523, region: "US-east-2", groupName: "/aws/lambda/slatldisal-ad-vehicleser-gap167ImporterTask", selected: false)),
                LogViewModel(log: Log(link: "https://us-east-2.console.aws.amazon.com/cloudwatch/home?region=us-east-2#logsV2:log-groups/log-group/%2Faws%2Flambda%2Fslatldisal-ad-vehicleser-gap167SftpTasks", serviceName: "Vehicle Info Service", account: 657003001523, region: "US-east-2", groupName: "/aws/lambda/slatldisal-ad-vehicleser-gap167SftpTasks", selected: false)),
                LogViewModel(log: Log(link: "https://us-east-2.console.aws.amazon.com/cloudwatch/home?region=us-east-2#logsV2:log-groups/log-group/%2Faws%2Flambda%2Fslatldisal-ad-vehicleser-inventoryImporterTask", serviceName: "Vehicle Info Service", account: 657003001523, region: "US-east-2", groupName: "/aws/lambda/slatldisal-ad-vehicleser-inventoryImporterTask", selected: false)),
                LogViewModel(log: Log(link: "https://us-east-2.console.aws.amazon.com/cloudwatch/home?region=us-east-2#logsV2:log-groups/log-group/%2Faws%2Flambda%2Fslatldisal-ad-vehicleser-mileageImporterTask", serviceName: "Vehicle Info Service", account: 657003001523, region: "US-east-2", groupName: "/aws/lambda/slatldisal-ad-vehicleser-mileageImporterTask", selected: false)),
                LogViewModel(log: Log(link: "https://us-east-2.console.aws.amazon.com/cloudwatch/home?region=us-east-2#logsV2:log-groups/log-group/%2Faws%2Flambda%2Fslatldisal-ad-vehicleser-pccdLookupsImporterTask", serviceName: "Vehicle Info Service", account: 657003001523, region: "US-east-2", groupName: "/aws/lambda/slatldisal-ad-vehicleser-pccdLookupsImporterTask", selected: false)),
                LogViewModel(log: Log(link: "https://us-east-2.console.aws.amazon.com/cloudwatch/home?region=us-east-2#logsV2:log-groups/log-group/%2Faws%2Flambda%2Fslatldisal-ad-vehicleser-vehicle", serviceName: "Vehicle Info Service", account: 657003001523, region: "US-east-2", groupName: "/aws/lambda/slatldisal-ad-vehicleser-vehicle", selected: false)),
                LogViewModel(log: Log(link: "https://us-east-2.console.aws.amazon.com/cloudwatch/home?region=us-east-2#logsV2:log-groups/log-group/%2Faws%2Flambda%2Fslatldisal-ad-vehicleser-vehicle-event-stream", serviceName: "Vehicle Info Service", account: 657003001523, region: "US-east-2", groupName: "/aws/lambda/slatldisal-ad-vehicleser-vehicle-event-stream", selected: false)),
                LogViewModel(log: Log(link: "https://us-east-2.console.aws.amazon.com/cloudwatch/home?region=us-east-2#logsV2:log-groups/log-group/%2Faws%2Flambda%2Fslatldisal-ad-vehicleser-vehicle-stream", serviceName: "Vehicle Info Service", account: 657003001523, region: "US-east-2", groupName: "/aws/lambda/slatldisal-ad-vehicleser-vehicle-stream", selected: false)),
                LogViewModel(log: Log(link: "https://us-east-2.console.aws.amazon.com/cloudwatch/home?region=us-east-2#logsV2:log-groups/log-group/%2Faws%2Flambda%2Fslatldisal-ad-vehicleser-vehiclesApi", serviceName: "Vehicle Info Service", account: 657003001523, region: "US-east-2", groupName: "/aws/lambda/slatldisal-ad-vehicleser-vehiclesApi", selected: false)),
                LogViewModel(log: Log(link: "https://us-east-2.console.aws.amazon.com/cloudwatch/home?region=us-east-2#logsV2:log-groups/log-group/%2Faws%2Flambda%2Fslatldisal-ad-vehicleser-visSupportLambda", serviceName: "Vehicle Info Service", account: 657003001523, region: "US-east-2", groupName: "/aws/lambda/slatldisal-ad-vehicleser-visSupportLambda", selected: false)),
            ])),
        ]
    }
}
