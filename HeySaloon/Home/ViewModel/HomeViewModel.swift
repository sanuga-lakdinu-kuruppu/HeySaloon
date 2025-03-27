import SwiftUI

class HomeViewModel {
    static let shared = HomeViewModel()
    let userDetailsEndpoint = "\(CommonGround.shared.baseUrl)/user"
    let favoriteStylistsEndpoint =
        "\(CommonGround.shared.baseUrl)/stylists/favorites"

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
}
