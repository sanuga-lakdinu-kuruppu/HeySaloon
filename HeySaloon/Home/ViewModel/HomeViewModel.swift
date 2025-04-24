import CoreData
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

    func getFavouriteStylistsInCoreData() -> [StylistModel] {
        let context = CoreDataController.shared.viewContext
        let fetchRequest = NSFetchRequest<FavouriteStylistCoreDataModel>(
            entityName: "FavouriteStylistCoreDataModel"
        )

        do {
            let results = try context.fetch(fetchRequest)
            return results.map { result in
                StylistModel(
                    stylistId: result.stylistId ?? "",
                    firstName: result.firstName ?? "",
                    lastName: result.lastName ?? "",
                    profileUrl: result.profileUrl ?? "",
                    thumbnailUrl: result.thumbnailUrl ?? "",
                    saloonName: result.saloonName,
                    isOpen: result.isOpen,
                    distance: result.distance,
                    isClientLiked: result.isClientLiked,
                    startTime: result.startTime,
                    endTime: result.endTime,
                    totalQueued: Int(result.totalQueued),
                    queueWillEnd: result.queueWillEnd,
                    totalReviewed: Int(result.totalReviewed),
                    currentRating: result.currentRating
                )
            }
        } catch {
            print("error occured in fetching: \(error)")
            return []
        }
    }

    func saveFavouriteStylistsInCoreData(_ stylists: [StylistModel]) {
        let context = CoreDataController.shared.viewContext

        //deleting existing records
        do {
            let fetchRequest: NSFetchRequest<FavouriteStylistCoreDataModel> =
                FavouriteStylistCoreDataModel.fetchRequest()
            let existingStylists = try context.fetch(fetchRequest)
            existingStylists.forEach { stylist in
                context.delete(stylist)
            }
        } catch {
            print("error occured in deleting: \(error)")
        }

        //saving new data
        stylists.forEach { stylist in
            let favouriteStylist = FavouriteStylistCoreDataModel(
                context: context
            )

            favouriteStylist.stylistId = stylist.stylistId
            favouriteStylist.firstName = stylist.firstName
            favouriteStylist.lastName = stylist.lastName
            favouriteStylist.profileUrl = stylist.profileUrl
            favouriteStylist.thumbnailUrl = stylist.thumbnailUrl
            favouriteStylist.saloonName = stylist.saloonName
            favouriteStylist.isOpen = stylist.isOpen ?? false
            favouriteStylist.distance = stylist.distance ?? 0.0
            favouriteStylist.isClientLiked = stylist.isClientLiked ?? false
            favouriteStylist.startTime = stylist.startTime
            favouriteStylist.endTime = stylist.endTime
            favouriteStylist.totalQueued = Int32(stylist.totalQueued ?? 0)
            favouriteStylist.queueWillEnd = stylist.queueWillEnd
            favouriteStylist.totalReviewed = Int32(stylist.totalReviewed ?? 0)
            favouriteStylist.currentRating = stylist.currentRating ?? 0.0

            do {
                try context.save()
            } catch {
                print("error occured in saving: \(error)")
            }
        }
    }

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
            saveFavouriteStylistsInCoreData(favoriteStylistsResponse.data)
            return favoriteStylistsResponse.data
        } else if response.statusCode == 401 {
            throw NetworkError.notAuthorized
        } else if response.statusCode == 498 {
            try await SupportManager.shared.getNewRefreshToken()
            return try await getFavoriteStylists()
        } else {
            return getFavouriteStylistsInCoreData()
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
