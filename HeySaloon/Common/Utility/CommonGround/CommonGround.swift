import SwiftUI

class CommonGround: ObservableObject {

    static let shared = CommonGround()
    let baseUrl = "https://api.theweb.asia"
    @Published var routes: [Route] = []
    @Published var email: String = ""
    @Published var commingFrom: Route = Route.mainApp
    @Published var accessToken: String = ""
    @Published var refreshToken: String = ""
    @Published var role: Role? = nil
    @Published var clientId: String = ""
    @Published var stylistId: String = ""
    @Published var isLoggedIn: Bool = false
    @Published var selectedStylistId: String = ""
    @Published var selectedStylist: StylistModel? = nil
    @Published var userProfile: UserProfileModel? = nil
    @Published var selectedTab: Tab = .home

    private init() {}

    //to get the userdefault details from the system
    func getUserDefaults() {
        isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        accessToken = UserDefaults.standard.string(forKey: "accessToken") ?? ""
        refreshToken =
            UserDefaults.standard.string(forKey: "refreshToken") ?? ""
        role =
            UserDefaults.standard.string(
                forKey: "role"
            ) == Role.stylist.rawValue ? Role.stylist : Role.client
        clientId = UserDefaults.standard.string(forKey: "clientId") ?? ""
        stylistId = UserDefaults.standard.string(forKey: "stylistId") ?? ""
        let firstname = UserDefaults.standard.string(forKey: "firstname") ?? ""
        let lastname = UserDefaults.standard.string(forKey: "lastname") ?? ""
        let imageUrl = UserDefaults.standard.string(forKey: "imageUrl") ?? ""
        self.userProfile = UserProfileModel(
            firstName: firstname,
            lastName: lastname,
            imageUrl: imageUrl
        )
    }

    //to save the values in the user defaults
    func saveUserDefaults() {
        UserDefaults.standard.set(isLoggedIn, forKey: "isLoggedIn")
        UserDefaults.standard.set(accessToken, forKey: "accessToken")
        UserDefaults.standard.set(refreshToken, forKey: "refreshToken")
        UserDefaults.standard.set(role?.rawValue, forKey: "role")
        UserDefaults.standard.set(clientId, forKey: "clientId")
        UserDefaults.standard.set(stylistId, forKey: "stylistId")
        UserDefaults.standard.set(userProfile?.firstName, forKey: "firstname")
        UserDefaults.standard.set(userProfile?.lastName, forKey: "lastname")
        UserDefaults.standard.set(userProfile?.imageUrl, forKey: "imageUrl")
    }

    //to remove the saved user defaults
    func removeUserDefaults() {
        UserDefaults.standard.removeObject(forKey: "isLoggedIn")
        UserDefaults.standard.removeObject(forKey: "accessToken")
        UserDefaults.standard.removeObject(forKey: "refreshToken")
        UserDefaults.standard.removeObject(forKey: "role")
        UserDefaults.standard.removeObject(forKey: "clientId")
        UserDefaults.standard.removeObject(forKey: "stylistId")
        UserDefaults.standard.removeObject(forKey: "firstname")
        UserDefaults.standard.removeObject(forKey: "lastname")
        UserDefaults.standard.removeObject(forKey: "imageUrl")
    }

    //to logout from the appliacation
    func logout() {
        self.isLoggedIn = false
        self.role = nil
        self.commingFrom = .mainApp
        self.email = ""
        self.routes = []
        self.accessToken = ""
        self.refreshToken = ""
        self.clientId = ""
        self.stylistId = ""
        self.userProfile = nil
        self.removeUserDefaults()
    }
}
