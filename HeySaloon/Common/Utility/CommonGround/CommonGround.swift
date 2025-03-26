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

    private init() {}
}
