import SwiftUI

class CommonGround: ObservableObject {

    static let shared = CommonGround()
    let baseUrl = "https://api.theweb.asia"
    @Published var routes: [Route] = []
    @Published var email: String = ""
    @Published var commingFrom: Route = Route.mainApp
    @Published var accessToken: String = ""
    //    @Published var accessToken: String = "f6567e74-720f-484d-8e1b-2a03e0e796ab"
    @Published var refreshToken: String = ""
    @Published var idToken: String = ""
    @Published var role: Role? = nil
    @Published var isLoggedIn: Bool = false

    private init() {}

    func logout() {
        self.isLoggedIn = false
        self.role = nil
        self.commingFrom = .mainApp
        self.email = ""
        self.routes = []
        self.accessToken = ""
        self.idToken = ""
        self.refreshToken = ""
    }
}
