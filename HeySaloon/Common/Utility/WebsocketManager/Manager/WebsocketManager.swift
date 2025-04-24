import Foundation

final class WebSocketManager: NSObject, ObservableObject {
    static let shared = WebSocketManager()

    private var webSocketTask: URLSessionWebSocketTask?
    private var urlSession: URLSession!
    private var isConnected = false
    private let urlString =
        "wss://io6nqs6reh.execute-api.ap-southeast-1.amazonaws.com/prod"

    @Published var isCompleted: Bool = false
    @Published var isPaid: Bool = false
    @Published var currentBooking: BookingModel? = nil

    override private init() {
        super.init()
        let config = URLSessionConfiguration.default
        urlSession = URLSession(
            configuration: config,
            delegate: self,
            delegateQueue: OperationQueue()
        )
    }

    //to connect with the websocket
    func connect(clientId: String) {
        guard !isConnected else { return }

        guard let url = URL(string: "\(urlString)?clientId=\(clientId)") else {
            print("invalid WebSocket URL")
            return
        }

        webSocketTask = urlSession.webSocketTask(with: url)
        webSocketTask?.resume()
        isConnected = true

        listenForMessages()
    }

    //to manually disconnect from the web socket
    func disconnect() {
        webSocketTask?.cancel(with: .goingAway, reason: nil)
        isConnected = false
    }

    //websocket listening
    private func listenForMessages() {
        webSocketTask?.receive { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .failure(_):
                self.isConnected = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    self.connect(clientId: CommonGround.shared.clientId)
                }
            case .success(let message):
                switch message {
                case .data(let data):
                    self.handleReceivedData(data)
                case .string(let text):
                    self.handleReceivedText(text)
                @unknown default:
                    print("received unknown message type")
                }
                self.listenForMessages()
            }
        }
    }

    //this is the method , that will be triggered if the server send notification as json
    private func handleReceivedData(_ data: Data) {
        if let json = try? JSONSerialization.jsonObject(with: data, options: [])
            as? [String: Any]
        {
            print("json received: \(json)")
        }
    }

    //this is the method, that will be triggered when server send a push notification as text
    private func handleReceivedText(_ text: String) {
        print("text recieved \(text)")

        let data = text.data(using: .utf8)
        let decoder = JSONDecoder()

        do {
            let message = try decoder.decode(WebSocketMessage.self, from: data!)
            if message.type == "STARTED" {
                //styling process is started
                NotificationManager.shared
                    .sendInstantNotifcation(
                        title: "Hey Saloon",
                        body:
                            "Hey \(CommonGround.shared.userProfile?.firstName ?? "User"), Your styling process is started. You can check it out in your dashboard.",
                        isInstant: true
                    )
            } else if message.type == "COMPLETED" {
                //styling process is completed
                NotificationManager.shared
                    .sendInstantNotifcation(
                        title: "Hey Saloon",
                        body:
                            "Hey \(CommonGround.shared.userProfile?.firstName ?? "User"), Your styling process is completed. Please pay the amount Rs. \(message.booking?.serviceTotal ?? 0.0) to the stylist \(message.booking?.stylist?.firstName ?? "")",
                        isInstant: true
                    )
                DispatchQueue.main.async {
                    self.isCompleted = true
                    self.currentBooking = message.booking
                }
            } else if message.type == "PAID" {
                //user already paid for the booking
                NotificationManager.shared
                    .sendInstantNotifcation(
                        title: "Hey Saloon",
                        body:
                            "Hey \(CommonGround.shared.userProfile?.firstName ?? "User"), You have paid the amount of Rs. \(message.booking?.serviceTotal ?? 0.0)",
                        isInstant: true
                    )
                DispatchQueue.main.async {
                    self.isCompleted = false
                    self.isPaid = true
                    self.currentBooking = message.booking
                }
            }
        } catch {
            print("error decoding message: \(error)")
        }
    }
}

extension WebSocketManager: URLSessionWebSocketDelegate {
    func urlSession(
        _ session: URLSession,
        webSocketTask: URLSessionWebSocketTask,
        didCloseWith closeCode: URLSessionWebSocketTask.CloseCode,
        reason: Data?
    ) {
        isConnected = false
        print("webSocket closed with code: \(closeCode)")
    }

    func urlSession(
        _ session: URLSession,
        webSocketTask: URLSessionWebSocketTask,
        didOpenWithProtocol protocol: String?
    ) {
        print("webSocket connection opened")
    }
}
