import SwiftUI

class ActivitiesViewModel {
    static let shared = ActivitiesViewModel()

    let bookingGetAllEndpointForClient =
        "\(CommonGround.shared.baseUrl)/bookings/clientId/\(CommonGround.shared.clientId)?status=QUEUED"
    private init() {}

    //tog get the bookings by client id
    func getBookingsByClientId() async throws -> [BookingModel] {
        //network call
        let (data, response) = try await NetworkSupporter.shared.call(
            requestBody: AnyCodable(),
            endpoint: bookingGetAllEndpointForClient,
            method: "GET",
            isSecured: true
        )

        //response handling
        if response.statusCode == 200 {
            let bookBookingGetResponse = try JSONDecoder().decode(
                BookBookingGetResponse.self,
                from: data
            )
            return bookBookingGetResponse.data
        } else if response.statusCode == 401 {
            throw NetworkError.notAuthorized
        } else if response.statusCode == 498 {
            try await SupportManager.shared.getNewRefreshToken()
            return try await getBookingsByClientId()
        } else {
            throw NetworkError.processError
        }
    }
}
