import CoreData

struct CoreDataController {
    static let shared = CoreDataController()

    let favouriteStylistCoreDataModelContainer: NSPersistentContainer

    init(inMemory: Bool = false) {
        favouriteStylistCoreDataModelContainer = NSPersistentContainer(
            name: "FavouriteStylistCoreDataModel"
        )
        if inMemory {
            favouriteStylistCoreDataModelContainer.persistentStoreDescriptions
                .first?.url = URL(
                    fileURLWithPath: "/dev/null"
                )
        }
        favouriteStylistCoreDataModelContainer.loadPersistentStores {
            description,
            error in
            if let error = error {
                fatalError("Core Data load error: \(error)")
            }
        }
    }

    var viewContext: NSManagedObjectContext {
        return favouriteStylistCoreDataModelContainer.viewContext
    }
}
