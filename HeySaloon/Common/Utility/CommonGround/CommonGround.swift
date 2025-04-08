import SwiftUI

class CommonGround: ObservableObject {

    static let shared = CommonGround()
    let baseUrl = "https://api.theweb.asia"
    @Published var routes: [Route] = []
    @Published var email: String = ""
    @Published var commingFrom: Route = Route.mainApp
    @Published var accessToken: String = ""
    @Published var refreshToken: String = ""
    @Published var idToken: String = ""
    @Published var role: Role? = nil
    @Published var isLoggedIn: Bool = false
    @Published var selectedStylist: StylistModel? = nil
    @Published var userProfile: UserProfileModel? = nil

    private init() {}

    func getUserDefaults() {
        isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        accessToken = UserDefaults.standard.string(forKey: "accessToken") ?? ""
        let firstname = UserDefaults.standard.string(forKey: "firstname") ?? ""
        let lastname = UserDefaults.standard.string(forKey: "lastname") ?? ""
        let imageUrl = UserDefaults.standard.string(forKey: "imageUrl") ?? ""
        self.userProfile = UserProfileModel(
            firstName: firstname,
            lastName: lastname,
            imageUrl: imageUrl
        )
    }

    func saveUserDefaults() {
        UserDefaults.standard.set(isLoggedIn, forKey: "isLoggedIn")
        UserDefaults.standard.set(accessToken, forKey: "accessToken")
        UserDefaults.standard.set(userProfile?.firstName, forKey: "firstname")
        UserDefaults.standard.set(userProfile?.lastName, forKey: "lastname")
        UserDefaults.standard.set(userProfile?.imageUrl, forKey: "imageUrl")
    }

    func removeUserDefaults() {
        UserDefaults.standard.removeObject(forKey: "isLoggedIn")
        UserDefaults.standard.removeObject(forKey: "accessToken")
        UserDefaults.standard.removeObject(forKey: "firstname")
        UserDefaults.standard.removeObject(forKey: "lastname")
        UserDefaults.standard.removeObject(forKey: "imageUrl")
    }

    func logout() {
        self.isLoggedIn = false
        self.role = nil
        self.commingFrom = .mainApp
        self.email = ""
        self.routes = []
        self.accessToken = ""
        self.idToken = ""
        self.refreshToken = ""
        self.userProfile = nil
        self.removeUserDefaults()
    }
}
