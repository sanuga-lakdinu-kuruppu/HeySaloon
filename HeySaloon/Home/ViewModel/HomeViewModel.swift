import SwiftUI

class HomeViewModel {
    static let shared = HomeViewModel()
    let userDetailsEndpoint = "\(CommonGround.shared.baseUrl)/user"

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
                        firstname: "", lastname: "",
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

    func getUserFavorites() async throws {

    }

//    func getFavoriteStylists() async throws -> [StylistModel] {
//
//    }

    func getTemp() -> [StylistModel] {
        let favoriteStylists: [StylistModel] = [
            .init(
                firstname: "Michael",
                lastname: "DeMoya",
                saloon: "Sayona Saloon",
                thumbnailUrl:
                    "https://images.unsplash.com/photo-1585747860715-2ba37e788b70?q=80&w=2948&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                rating: 4.7,
                totalRating: 422,
                isOpen: true
            ),
            .init(
                firstname: "Tommy",
                lastname: "Van",
                saloon: "Wix Saloon",
                thumbnailUrl:
                    "https://images.unsplash.com/photo-1596728325488-58c87691e9af?q=80&w=2946&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                rating: 4.5,
                totalRating: 142,
                isOpen: false
            ),
            .init(
                firstname: "Obi",
                lastname: "",
                saloon: "Z Saloon",
                thumbnailUrl:
                    "https://images.unsplash.com/photo-1598280601605-a42e1b3db108?q=80&w=2938&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                rating: 4.8,
                totalRating: 231,
                isOpen: true
            ),
        ]
        return favoriteStylists
    }
}

//let favoriteStylists: [StylistModel] = [
//    .init(
//        firstname: "Michael",
//        lastname: "DeMoya",
//        saloon: "Sayona Saloon",
//        imageUrl:
//            "https://images.unsplash.com/photo-1585747860715-2ba37e788b70?q=80&w=2948&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
//        rating: 4.7,
//        totalRating: 422,
//        isOpen: true
//    ),
//    .init(
//        firstname: "Tommy",
//        lastname: "Van",
//        saloon: "Wix Saloon",
//        imageUrl:
//            "https://images.unsplash.com/photo-1596728325488-58c87691e9af?q=80&w=2946&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
//        rating: 4.5,
//        totalRating: 142,
//        isOpen: false
//    ),
//    .init(
//        firstname: "Obi",
//        lastname: "",
//        saloon: "Z Saloon",
//        imageUrl:
//            "https://images.unsplash.com/photo-1598280601605-a42e1b3db108?q=80&w=2938&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
//        rating: 4.8,
//        totalRating: 231,
//        isOpen: true
//    ),
//]
