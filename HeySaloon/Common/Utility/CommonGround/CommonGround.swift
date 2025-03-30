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

    private init() {}

    func getUserDefaults() {
        isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        accessToken = UserDefaults.standard.string(forKey: "accessToken") ?? ""
    }

    func saveUserDefaults() {
        UserDefaults.standard.set(isLoggedIn, forKey: "isLoggedIn")
        UserDefaults.standard.set(accessToken, forKey: "accessToken")
    }

    func removeUserDefaults() {
        UserDefaults.standard.removeObject(forKey: "isLoggedIn")
        UserDefaults.standard.removeObject(forKey: "accessToken")
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
        self.removeUserDefaults()
    }
}
