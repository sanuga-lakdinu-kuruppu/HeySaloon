import SwiftUI

struct AnyCodable: Encodable {}

class NetworkSupporter {
    static let shared = NetworkSupporter()
    let encoder = JSONEncoder()

    private init() {}

    func call<R: Encodable>(
        request: R, endpoint: String, method: String, isSecured: Bool
    )
        async throws -> (Data, HTTPURLResponse)
    {
        if method == "POST" {

            //encoding request
            guard let requestEncoded = try? encoder.encode(request)
            else {
                throw NetworkError.processError
            }

            //http request creation
            guard let url = URL(string: endpoint) else {
                throw NetworkError.processError
            }
            var request = URLRequest(url: url)
            request.setValue(
                "application/json", forHTTPHeaderField: "Content-Type")
            if isSecured {
                request.setValue(
                    CommonGround.shared.accessToken,
                    forHTTPHeaderField: "authorization")
            }
            request.httpMethod = method

            //request call
            let (data, response) = try await URLSession.shared.upload(
                for: request,
                from: requestEncoded
            )

            guard let response = response as? HTTPURLResponse
            else {
                throw NetworkError.processError
            }

            return (data, response)
        } else if method == "GET" {

            //http request creation
            guard let url = URL(string: endpoint) else {
                throw NetworkError.processError
            }

            var request = URLRequest(url: url)
            request.setValue(
                "application/json", forHTTPHeaderField: "Content-Type")
            if isSecured {
                request.setValue(
                    CommonGround.shared.accessToken,
                    forHTTPHeaderField: "authorization")
            }
            request.httpMethod = method

            //request call
            let (data, response) = try await URLSession.shared.data(
                for: request
            )

            guard let response = response as? HTTPURLResponse
            else {
                throw NetworkError.processError
            }

            return (data, response)
        } else {
            return (
                Data(),
                HTTPURLResponse(
                    url: URL(string: "")!, statusCode: 200, httpVersion: nil,
                    headerFields: nil)!
            )
        }

    }
}
