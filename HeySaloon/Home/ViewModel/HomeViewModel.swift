import SwiftUI

class HomeViewModel {
    static let shared = HomeViewModel()
    let userDetailsEndpoint = "\(CommonGround.shared.baseUrl)/user"
    let favoriteStylistsEndpoint =
        "\(CommonGround.shared.baseUrl)/stylists/favorites"
    let nearByStylistsEndpoint =
        "\(CommonGround.shared.baseUrl)/stylists/nearBy"
    let topRatedStylistsEndpoint =
        "\(CommonGround.shared.baseUrl)/stylists/topRated"

    private init() {}

    func getUserProfile() async throws -> UserProfileModel {

        //network call
        let (data, response) = try await NetworkSupporter.shared.call(
            request: AnyCodable(),
            endpoint: userDetailsEndpoint,
            method: "GET",
            isSecured: true
        )

        //response handling
        if response.statusCode == 200 {

            let userProfileResponse = try JSONDecoder().decode(
                UserProfileResponse.self,
                from: data
            )

            if userProfileResponse.status == "0000" {
                return userProfileResponse.data
                    ?? .init(
                        firstName: "", lastName: "",
                        imageUrl: ""
                    )
            } else {
                throw NetworkError.processError
            }

        } else if response.statusCode == 401 {
            throw NetworkError.notAuthorized
        } else {
            throw NetworkError.processError
        }
    }

    func getFavoriteStylists() async throws -> [StylistModel] {
        //network call
        let (data, response) = try await NetworkSupporter.shared.call(
            request: AnyCodable(),
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

            if favoriteStylistsResponse.status == "0000" {
                return favoriteStylistsResponse.data
            } else {
                throw NetworkError.processError
            }

        } else if response.statusCode == 401 {
            throw NetworkError.notAuthorized
        } else {
            throw NetworkError.processError
        }
    }

    func getNearByStylists() async throws -> [StylistModel] {
        //network call
        let (data, response) = try await NetworkSupporter.shared.call(
            request: AnyCodable(),
            endpoint:
                "\(nearByStylistsEndpoint)?lat=\(37.75826042644298)&log=\(-122.43800997698538)",
            method: "GET",
            isSecured: true
        )

        //response handling
        if response.statusCode == 200 {

            let nearByStylistsResponse = try JSONDecoder().decode(
                NearByStylistsResponse.self,
                from: data
            )

            if nearByStylistsResponse.status == "0000" {
                return nearByStylistsResponse.data
            } else {
                throw NetworkError.processError
            }

        } else if response.statusCode == 401 {
            throw NetworkError.notAuthorized
        } else {
            throw NetworkError.processError
        }
    }

    func getTopRatedStylists() async throws -> [StylistModel] {
        //network call
        let (data, response) = try await NetworkSupporter.shared.call(
            request: AnyCodable(),
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

            if topRatedStylistsResponse.status == "0000" {
                return topRatedStylistsResponse.data
            } else {
                throw NetworkError.processError
            }

        } else if response.statusCode == 401 {
            throw NetworkError.notAuthorized
        } else {
            throw NetworkError.processError
        }
    }
}
