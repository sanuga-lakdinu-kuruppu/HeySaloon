import SwiftUI

class StylistViewModel {
    static let shared = StylistViewModel()

    let bookingRequestEndpoint = "\(CommonGround.shared.baseUrl)/bookings"

    private init() {}

    func createBooking(
        stylist: StylistModel,
        selectedServices: [ServiceModel]
    ) async throws
        -> BookingModel
    {

        //request creation
        let bookingRequest = BookingRequest(
            stylistId: stylist.stylistId,
            selectedServices: selectedServices
        )

        //network call
        let (data, response) = try await NetworkSupporter.shared.call(
            request: bookingRequest,
            endpoint: bookingRequestEndpoint,
            method: "POST",
            isSecured: true
        )

        //response handling
        if response.statusCode == 200 {

            let bookingCreateResponse = try JSONDecoder().decode(
                BookingCreateResponse.self,
                from: data
            )

            if bookingCreateResponse.status == "0000" {
                return bookingCreateResponse.data
            } else {
                throw NetworkError.processError
            }

        } else if response.statusCode == 404 {
            throw BookingCreationError.stylistNotFound
        } else if response.statusCode == 401 {
            throw NetworkError.notAuthorized
        } else {
            throw NetworkError.processError
        }
    }

    func calculateNextPosition(stylist: StylistModel) -> Int {
        let current = stylist.totalQueued
        return current + 1
    }

    func calculateServiceTime(selectedServices: [ServiceModel]) -> Int {
        return selectedServices.reduce(0) { $0 + $1.minutes }
    }
}
