# monitoring-mobile

The goal of the Monitoring Service is to bring observability and visibility to the overall applications and microservices in the Porsche ecosystem.

A major pain point for applications is that errors are not as visible as they should be, making it harder to react to problems before being visible to end customers. By surfacing these errors in a more timely manner, we can react more quickly. In addition, with warnings also being captured, it can alert us to potential issues down the road, allowing us to proactively attack future problems.

The architecture and flow of this monitoring system is described below. In a nutshell, agents are needed in the environments where information is captured. These include (but not limited to) application logs and health checks. The agents then forwards captured information to the central monitoring service, which then persists this information. A dashboard presents this information for realtime and historic view of the various services. An alerting system is also leveraged to provide quick realtime notification to potential downtime events.

## In Use Screenshots
![Simulator Screen Shot - iPhone 11 - 2022-06-25 at 11 10 41](https://user-images.githubusercontent.com/29511702/175791925-5dc39e90-e6f8-4ee6-8029-6c861dae74f9.png)
![Simulator Screen Shot - iPhone 11 - 2022-06-25 at 11 10 59](https://user-images.githubusercontent.com/29511702/175791926-e2badbad-3c6d-4fa1-93ad-d03d198a28a0.png)
![Simulator Screen Shot - iPhone 11 - 2022-06-25 at 11 11 03](https://user-images.githubusercontent.com/29511702/175791928-d03406c7-a92c-49cd-8d89-14c93a2607ea.png)
![Simulator Screen Shot - iPhone 11 - 2022-06-25 at 15 29 30](https://user-images.githubusercontent.com/29511702/175792280-6368e115-988c-4499-9e10-c0fcf435a14a.png)
![Simulator Screen Shot - iPhone 11 - 2022-06-25 at 11 15 41](https://user-images.githubusercontent.com/29511702/175791930-38efa207-f096-44d1-b349-ce20a1711388.png)
![Simulator Screen Shot - iPhone 11 - 2022-06-25 at 11 15 51](https://user-images.githubusercontent.com/29511702/175791932-e332d69b-6276-48c9-85e3-f8c3be6c1dea.png)
![Simulator Screen Shot - iPhone 11 - 2022-06-25 at 11 15 56](https://user-images.githubusercontent.com/29511702/175791933-a19eb5ae-0eb6-48b2-bc08-1f04ac65cee6.png)
![Simulator Screen Shot - iPhone 11 - 2022-06-25 at 11 16 16](https://user-images.githubusercontent.com/29511702/175791935-93393863-e477-4578-8a4f-a915342b38fb.png)

## Requirements

* Xcode 13+
* iOS 12+
* Swift 5+
## How to build

1) Clone the repository

```bash
$ git clone https://github.com/kingaustinman/monitoring-mobile.git
```

2) Traverse to Directory

```bash
$ cd monitoring-mobile
$ cd monitoring.xcodeproj
```

3) Open the workspace in Xcode

```bash
$ open "project.xcworkspace"
```
4) Login to the UI with a valid email address


## Architecture

```text
                 ┌───────────────────┐
                 │Dashboard          │
                 │(Browser)          │
                 │                   │
                 │                   │
                 │                   │
                 └─────────┬─────────┘
                           │
                           │
                           │
┌──────────────────────────┼────────────────────────────────────┐
│ Account 1                │                                    │
│    ┌─────────────────────┼───────────────────────────────┐    │
│    │ Region 1            │                               │    │
│    │                     │                               │    │
│    │                     │                               │    │
│    │                     │                               │    │
│    │ ┌────────────┐ ┌────▼─────┐         ┌─────────────┐ │    │
│    │ │Intelligence│ │API       │         │Event        │ │    │
│    │ │(Lambda)    │ │(Lambda)  │    ┌────┤Aggregator   │ │    │
│    │ └──────┬─▲───┘ └─────┬────┘    │    └(Lambda)     │ │    │
│    │        │ │           │         │    └─────▲───────┘ │    │
│    │        │ │     ┌─────▼────┐    │          │         │    │
│    │        │ └─────│ DynamoDB ◄────┘          │         │    │
│    │        └───────►          │               │         │    │
│    │                └─────┬────┘               │         │    │
│    │                      │                    │         │    │
│    │                ┌─────▼────┐               │         │    │
│    │                │ Alerter  │          ┌────┴───────┐ │    │
│    │                │          │          │EventBus    │ │    │
│    │                └──────────┘          │            ◄─┼────┼──┐
│    │                                      │            │ │    │  │
│    └──────────────────────────────────────┴─────▲──────┴─┘    │  │
│                                                 │             │  │
│    ┌──────────────────────────────────────┬─────┴──────┬─┐    │  │
│    │ Region 2                             │EventBus    │ │    │  │
│    │                ┌──────────┐          │            │ │    │  │
│    │                │Agent     ├──────────►            │ │    │  │
│    │                │(Lambda)  │          └────────────┘ │    │  │
│    │                │          │                         │    │  │
│    │                └──▲─────▲─┘                         │    │  │
│    │                   │     │                           │    │  │
│    │      ┌────────────┴─┐  ┌┴─────────────┐             │    │  │
│    │      │Service 1 Logs│  │Service 2 Logs│             │    │  │
│    │      │              │  │              │             │    │  │
│    │      │              │  │              │             │    │  │
│    │      └──────────────┘  └──────────────┘             │    │  │
│    │                                                     │    │  │
│    │                                                     │    │  │
│    │                                                     │    │  │
│    └─────────────────────────────────────────────────────┘    │  │
│                                                               │  │
└───────────────────────────────────────────────────────────────┘  │
                                                                   │
┌───────────────────────────────────────────────────────────────┐  │
│Account 2                                                      │  │
│   ┌──────────────────────────────────────┬────────────┬─┐     │  │
│   │ Region 1                             │EventBus    │ │     │  │
│   │                ┌──────────┐          │            ├─┼─────┼──┘
│   │                │Agent     ├──────────►            │ │     │
│   │                │(Lambda)  │          └────────────┘ │     │
│   │                │          │                         │     │
│   │                └──▲─────▲─┘                         │     │
│   │                   │     │                           │     │
│   │      ┌────────────┴──  ┌┴─────────────┐             │     │
│   │      │Service 1 Logs|  │Service 2 Logs│             │     │
│   │      │              │  │              │             │     │
│   │      │              │  │              │             │     │
│   │      └──────────────┘  └──────────────┘             │     │
│   │                                                     │     │
│   │                                                     │     │
│   │                                                     │     │
│   └─────────────────────────────────────────────────────┘     │
│                                                               │
└───────────────────────────────────────────────────────────────┘
```

## Flow

1. Agents subscribe to Log Group events with filtering, for errors and warnings.
2. Agents send asynchronous events to the local default EventBus.
3. Forwarding rules forward those events to the Monitoring Service's account/region default EventBus.
4. The Monitoring Service Event Aggregator Lambda collects that data and stores in DynamoDB.
5. The Monitoring Service Intelligence Lambda may do further analysis on new data in correlation with previous data (ex. anomaly detection). (* future version)
6. The Monitoring Service Alerter accepts events from DynamoDB streams and notifies via slack/email/sms. (* future version)

### Application Logging

* Consistent logging syntax for errors and warnings (should already be supported by our monorepo common Logging)
* Good developer categorization of errors and warnings.
* Include a correlation ID (cid) to be able to trace events and their source throughout the microservice architecture. A correlation ID is generated (shortid) at incoming external boundaries (i.e. API call from UI, API call from 3rd party, scheduler) and carries it through internal application processing as well as passed on microservice calls. (* future version)

## Future Enhancements Ideas

With an Agent living in all environments, and able to stream data asynchronously to a central hub, and able to display this in a UI, this architecture can be leveraged for many different monitoring and observability use-cases, all by posting messages to the local EventBus.

Let the foundation "marinate for perfection", and enhance with...

* Record service health history and display in Dashboard. We already have health endpoints for some services, which includes the health of their downstream dependencies. A dependency graph can be displayed, highlighting impact of upstream applications/services.
* Allow a user to mark errors/warnings as read/unread for themselves. "Bookmarks" may be a better concept. Pinned? Hidden vs resolved? -> Capture feedback to see if this is neceasary.
* Application deployment status and version/timestamp. (ex. git commit ID of dev/pp/p)
* Notifications controllable by buffering (ie. combining messages to minimize noise), channel availability (email, sms, slack, etc.), and schedule (ex. send combined messages in the morning)(ex. don't send at certain times).
* Realtime dashboard (w/ no refresh, as in a control center).
* Intelligence and metrics. (ex. anomaly detection)(ex. predictive analysis based on history)
* Correlation ID (Distributed Tracing)
  * <https://microsoft.github.io/code-with-engineering-playbook/observability/correlation-id/>
  * <https://medium.com/@scokmen/debugging-microservices-part-ii-the-correlation-identifier-552f9016afcd>
* If we enhance this architecture to 2 way communication (ie. hub -> agent asynchronous commands), we can add on-demand configuration and other actions from the UI, for a whole other set of use-cases...
