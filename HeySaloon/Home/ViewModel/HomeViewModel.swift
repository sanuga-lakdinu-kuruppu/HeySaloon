import SwiftUI

class HomeViewModel {
    static let shared = HomeViewModel()
    let favoriteStylistsEndpoint =
        "\(CommonGround.shared.baseUrl)/stylists?queryOn=favourites&clientId=\(CommonGround.shared.clientId)"
    let nearByStylistsEndpoint =
        "\(CommonGround.shared.baseUrl)/stylists?queryOn=nearBy&clientId=\(CommonGround.shared.clientId)"
    let topRatedStylistsEndpoint =
        "\(CommonGround.shared.baseUrl)/stylists?queryOn=topRated"

    private init() {}

    func getFavoriteStylists() async throws -> [StylistModel] {
        //network call
        let (data, response) = try await NetworkSupporter.shared.call(
            requestBody: AnyCodable(),
            endpoint: favoriteStylistsEndpoint,
            method: "GET",
            isSecured: true
        )

        //response handling
        if response.statusCode == 200 {
            let favoriteStylistsResponse = try JSONDecoder().decode(
                FavoriteStylistsResponse.self,
                from: data
            )
            return favoriteStylistsResponse.data
        } else if response.statusCode == 401 {
            throw NetworkError.notAuthorized
        } else if response.statusCode == 498 {
            try await SupportManager.shared.getNewRefreshToken()
            return try await getFavoriteStylists()
        } else {
            throw NetworkError.processError
        }
    }

    func getNearByStylists(lat: Double, log: Double) async throws
        -> [StylistModel]
    {
        //network call
        let (data, response) = try await NetworkSupporter.shared.call(
            requestBody: AnyCodable(),
            endpoint:
                "\(nearByStylistsEndpoint)&lat=\(lat)&log=\(log)",
            method: "GET",
            isSecured: true
        )

        //response handling
        if response.statusCode == 200 {
            let nearByStylistsResponse = try JSONDecoder().decode(
                NearByStylistsResponse.self,
                from: data
            )
            return nearByStylistsResponse.data
        } else if response.statusCode == 498 {
            try await SupportManager.shared.getNewRefreshToken()
            return try await getNearByStylists(lat: lat, log: log)
        } else if response.statusCode == 401 {
            throw NetworkError.notAuthorized
        } else {
            throw NetworkError.processError
        }
    }

    func getTopRatedStylists() async throws -> [StylistModel] {
        //network call
        let (data, response) = try await NetworkSupporter.shared.call(
            requestBody: AnyCodable(),
            endpoint: topRatedStylistsEndpoint,
            method: "GET",
            isSecured: true
        )

        //response handling
        if response.statusCode == 200 {
            let topRatedStylistsResponse = try JSONDecoder().decode(
                TopRatedStylistsResponse.self,
                from: data
            )
            return topRatedStylistsResponse.data
        } else if response.statusCode == 498 {
            try await SupportManager.shared.getNewRefreshToken()
            return try await getTopRatedStylists()
        } else if response.statusCode == 401 {
            throw NetworkError.notAuthorized
        } else {
            throw NetworkError.processError
        }
    }
}
