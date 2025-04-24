//
//  FavouriteStylistCoreDataModel+CoreDataProperties.swift
//  HeySaloon
//
//  Created by Kuruppuge Sanuga Lakdinu Kuruppu on 2025-04-24.
//
//

import Foundation
import CoreData


extension FavouriteStylistCoreDataModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavouriteStylistCoreDataModel> {
        return NSFetchRequest<FavouriteStylistCoreDataModel>(entityName: "FavouriteStylistCoreDataModel")
    }

    @NSManaged public var stylistId: String?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var profileUrl: String?
    @NSManaged public var thumbnailUrl: String?
    @NSManaged public var saloonName: String?
    @NSManaged public var isOpen: Bool
    @NSManaged public var distance: Double
    @NSManaged public var isClientLiked: Bool
    @NSManaged public var startTime: String?
    @NSManaged public var endTime: String?
    @NSManaged public var totalQueued: Int32
    @NSManaged public var queueWillEnd: String?
    @NSManaged public var totalReviewed: Int32
    @NSManaged public var currentRating: Double

}

extension FavouriteStylistCoreDataModel : Identifiable {

}
