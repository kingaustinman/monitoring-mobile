
import SwiftUI
//import UIKit
//
//import Foundation
//
//class WebSocketStream: AsyncSequence {
//
//    typealias Element = URLSessionWebSocketTask.Message
//    typealias AsyncIterator = AsyncThrowingStream<URLSessionWebSocketTask.Message, Error>.Iterator
//
//    private var stream: AsyncThrowingStream<Element, Error>?
//        private var continuation: AsyncThrowingStream<Element, Error>.Continuation?
//        private let socket: URLSessionWebSocketTask
//
//        init(url: String, session: URLSession = URLSession.shared) {
//            socket = session.webSocketTask(with: URL(string: url)!)
//            stream = AsyncThrowingStream { continuation in
//                self.continuation = continuation
//                self.continuation?.onTermination = { @Sendable [socket] _ in
//                    socket.cancel()
//                }
//            }
//        }
//
//    func makeAsyncIterator() -> AsyncIterator {
//        guard let stream = stream else {
//            fatalError("stream was not initialized")
//        }
//        print("STREAM WAS INITIALIZED")
//        socket.resume()
//        listenForMessages()
//        return stream.makeAsyncIterator()
//    }
//
//    private func listenForMessages() {
//        socket.receive { [unowned self] result in
//            switch result {
//            case .success(let message):
//                continuation?.yield(message)
//                listenForMessages()
//            case .failure(let error):
//                continuation?.finish(throwing: error)
//            }
//        }
//    }
//}
//

struct PlaceholderView: View {
//    private let stream = WebSocketStream(url: "wss://dbaqkri5s7.execute-api.us-east-1.amazonaws.com/ad?idToken=eyJraWQiOiJLTzdSdld1b080SlwvZ082Wlpxak12eFVFSWVuQU9XVEl3d2M4dGlrTXdPYz0iLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJkMmViNjlhYi1hZTlmLTQ4YmEtYWRiMy0wNjZkY2E5ZWQ2YzAiLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiaXNzIjoiaHR0cHM6XC9cL2NvZ25pdG8taWRwLnVzLWVhc3QtMS5hbWF6b25hd3MuY29tXC91cy1lYXN0LTFfY3JWQXdXY2JGIiwiY29nbml0bzp1c2VybmFtZSI6ImQyZWI2OWFiLWFlOWYtNDhiYS1hZGIzLTA2NmRjYTllZDZjMCIsIm9yaWdpbl9qdGkiOiIzZDdlYmYzZC0xZGQ4LTQ2NDItYjczYi1lNDA2ZDk1YTYzMmUiLCJhdWQiOiIxZm11NzE0YWZjNmpzZWdmZjFma2RkYzBldCIsImV2ZW50X2lkIjoiMGJmYzkzOTQtYjY2Mi00M2M2LWEwM2MtZTY5ZWViMjdhNWYwIiwidG9rZW5fdXNlIjoiaWQiLCJhdXRoX3RpbWUiOjE2NTQ5MjM4MjUsImV4cCI6MTY1NDkyNzQyNSwiaWF0IjoxNjU0OTIzODI1LCJqdGkiOiI5M2U2Zjg4Yi1mYzMyLTRlYTktYjdmZS1lMjA3YzgyN2IwMGUiLCJlbWFpbCI6ImF1c3RpbkBhYnN0cmFjdGVkLmlvIn0.X6NB9P_3uveJCyK42u_xNV4IpfZVrNhR3waTEfH6X0_yJ_j1ORvJNXghJs0IFfKRlB4ucTGLt9GSxVAXpAbyNUBl8QW0nVihZbnioHGR-PzBEbhOVTc0AE2f3_dmarZZpfeHnja_F-51SlhAhB2ILVzd2Jx8_oWuraIRIVM3HVaGCmx53uObPGl8vYTJbCrFP-SZ3tymEQ9vAFrNv7NNXkEX7U7PHi6QbLXbbmeOzNdL6hQgl9E26zhOPFLV5B0CIS3SUfk24qlurHE1fJEK6BR_0ORcPrIHuKIXKuHTehKk9J4kYLqK6v4mJ2hdo5WlypCDL9S28QYE5k28ifoSVg")
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

