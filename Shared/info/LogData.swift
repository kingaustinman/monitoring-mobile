
import SwiftUI

struct Log {
    var link: String
    var serviceName: String
    var account: Int
    var region: String
    var groupName: String
    var errorStatus: String?
    var logEventsWithErrorsTS: String?
    var selected: Bool
}

struct LogViewModel: Identifiable {
    let id = UUID()
    var log: Log
    
    var link: String {
        return log.link
    }
    var serviceName: String {
        return log.serviceName.capitalized
    }
    var account: String {
        return String(log.account)
    }
    var region: String {
        return log.region
    }
    var groupName: String {
        return log.groupName
    }
    var errorStatus: String {
        return log.errorStatus ?? ""
    }
    var logEventsWithErrorsTS: String {
        return log.logEventsWithErrorsTS ?? ""
    }
    var selected: Bool {
        get {
            return log.selected
        }
        set {
            log.selected = newValue
        }
    }
}

class LogData: ObservableObject {
    @Published var logsData: [LogViewModel]
    
    init() {
        logsData = [
            LogViewModel(log: Log(link: "https://us-east-1.console.aws.amazon.com/cloudwatch/home?region=us-east-1#logsV2:log-groups/log-group/%2Faws%2Flambda%2Fslatldisal-ad-osaappbff-osaAuth", serviceName: "One Sales", account: 657003001523, region: "US-east-1", groupName: "/aws/lambda/slatldisal-ad-osaappbff-osaAuth", selected: false)),
            LogViewModel(log: Log(link: "https://us-east-1.console.aws.amazon.com/cloudwatch/home?region=us-east-1#logsV2:log-groups/log-group/%2Faws%2Flambda%2Fslatldisal-ad-osaappbff-osaBFFApp", serviceName: "One Sales", account: 657003001523, region: "US-east-1", groupName: "/aws/lambda/slatldisal-ad-osaappbff-osaBFFApp", selected: false)),
            LogViewModel(log: Log(link: "https://us-east-1.console.aws.amazon.com/cloudwatch/home?region=us-east-1#logsV2:log-groups/log-group/%2Faws%2Flambda%2Fslatldisal-ad-osaappbff-osaBFFEvent", serviceName: "One Sales", account: 657003001523, region: "US-east-1", groupName: "/aws/lambda/slatldisal-ad-osaappbff-osaBFFEvent", selected: false)),
        ]
    }
}
