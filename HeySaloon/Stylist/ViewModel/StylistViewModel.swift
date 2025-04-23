import SwiftUI

class StylistViewModel {
    static let shared = StylistViewModel()

    let stylistGetEndpint = "\(CommonGround.shared.baseUrl)/stylists"
    let bookingRequestEndpoint = "\(CommonGround.shared.baseUrl)/bookings"
    let bookingByStylistIdEndpoint =
        "\(CommonGround.shared.baseUrl)/bookings/stylistId"
    let portfolioGetEndpoint =
        "\(CommonGround.shared.baseUrl)/portfolios?clientId=\(CommonGround.shared.clientId)"

    private init() {}

    func getPortfolios(stylistId: String) async throws -> [PortfolioModel] {
        //network call
        let (data, response) = try await NetworkSupporter.shared.call(
            requestBody: AnyCodable(),
            endpoint: portfolioGetEndpoint + "&stylistId=\(stylistId)",
            method: "GET",
            isSecured: true
        )

        //response handling
        if response.statusCode == 200 {
            let portfolioResponse = try JSONDecoder().decode(
                PortfolioResponse.self,
                from: data
            )
            return portfolioResponse.data
        } else if response.statusCode == 498 {
            try await SupportManager.shared.getNewRefreshToken()
            return try await getPortfolios(stylistId: stylistId)
        } else if response.statusCode == 401 {
            throw NetworkError.notAuthorized
        } else {
            throw NetworkError.processError
        }
    }

    func getStylist(stylistId: String) async throws -> StylistModel? {
        //network call
        let (data, response) = try await NetworkSupporter.shared.call(
            requestBody: AnyCodable(),
            endpoint: stylistGetEndpint + "/\(stylistId)",
            method: "GET",
            isSecured: true
        )

        //response handling
        if response.statusCode == 200 {
            let stylistResponse = try JSONDecoder().decode(
                StylistResponse.self,
                from: data
            )

            return stylistResponse.data
        } else if response.statusCode == 498 {
            try await SupportManager.shared.getNewRefreshToken()
            return try await getStylist(stylistId: stylistId)
        } else if response.statusCode == 401 {
            throw NetworkError.notAuthorized
        } else {
            throw NetworkError.processError
        }
    }

    func createBooking(stylist: StylistModel, booking: BookingModel)
        async throws
        -> BookingModel
    {

        //request creation
        let bookingRequest = BookingRequest(
            stylistId: stylist.stylistId,
            clientId: CommonGround.shared.clientId,
            servicesSelected: booking.servicesSelected.map { $0.serviceId }
        )

        //network call
        let (data, response) = try await NetworkSupporter.shared.call(
            requestBody: bookingRequest,
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
            return bookingCreateResponse.data!
        } else if response.statusCode == 498 {
            try await SupportManager.shared.getNewRefreshToken()
            return try await createBooking(stylist: stylist, booking: booking)
        } else {
            throw NetworkError.processError
        }
    }

    func getAppointment(stylist: StylistModel) async throws -> BookingModel? {
        //network call
        let (data, response) = try await NetworkSupporter.shared.call(
            requestBody: AnyCodable(),
            endpoint: bookingByStylistIdEndpoint + "/\(stylist.stylistId)",
            method: "GET",
            isSecured: true
        )

        //response handling
        if response.statusCode == 200 {
            let bookingCreateResponse = try JSONDecoder().decode(
                BookingCreateResponse.self,
                from: data
            )

            //            if bookingCreateResponse.status == "0000" {
            return bookingCreateResponse.data
            //            } else if bookingCreateResponse.status == "1111" {
            //                return nil
            //            } else {
            //                throw NetworkError.processError
            //            }

        } else if response.statusCode == 401 {
            throw NetworkError.notAuthorized
        } else {
            throw NetworkError.processError
        }
    }

    func calculateNextPosition(stylist: StylistModel?) -> Int {
        guard let stylist = stylist else {
            return 0
        }
        let current = stylist.totalQueued ?? 0
        return current + 1
    }
    //
    //    func calculateServiceTime(selectedServices: [ServiceModel]) -> Int {
    //        return selectedServices.reduce(0) { $0 + $1.serviceWillTake }
    //    }
}
