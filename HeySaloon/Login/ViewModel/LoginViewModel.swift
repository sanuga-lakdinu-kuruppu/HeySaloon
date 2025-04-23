import SwiftUI

class LoginViewModel {
    static let shared = LoginViewModel()
    let loginRequestEndpoint = "\(CommonGround.shared.baseUrl)/auth/login"
    let otpVerifyEndpoint = "\(CommonGround.shared.baseUrl)/otp-verifications"

    private init() {}

    func requestOtpWithEmail(emailAddress: String) async throws {

        //request object creation
        let emailLoginRequest = EmailLoginRequest(
            email: emailAddress,
            loginType: "EMAIL_LOGIN"
        )

        //network call
        let (_, response) = try await NetworkSupporter.shared.call(
            requestBody: emailLoginRequest,
            endpoint: loginRequestEndpoint,
            method: "POST",
            isSecured: false
        )

        //response handling
        if response.statusCode == 200 {
            DispatchQueue.main.async {
                CommonGround.shared.email = emailAddress
            }
        } else if response.statusCode == 429 {
            throw LoginError.requestExceeded
        } else {
            throw NetworkError.processError
        }
    }

    func verifyOtpWithEmail(otp: String) async throws {

        //request object creation
        let emailOtpVerifyRequest = EmailOtpVerifyRequest(
            loginType: "EMAIL_LOGIN",
            verificationType: "REGULAR_AUTH",
            email: CommonGround.shared.email,
            otp: otp
        )

        //network call
        let (data, response) = try await NetworkSupporter.shared.call(
            requestBody: emailOtpVerifyRequest,
            endpoint: otpVerifyEndpoint,
            method: "PATCH",
            isSecured: false
        )

        //response handling
        if response.statusCode == 200 {
            let emailOtpVerifyResponse = try JSONDecoder().decode(
                EmailOtpVerifyResponse.self,
                from: data
            )
            DispatchQueue.main.async {
                CommonGround.shared.isLoggedIn = true
                CommonGround.shared.accessToken =
                    emailOtpVerifyResponse.data.accessToken
                CommonGround.shared.refreshToken =
                    emailOtpVerifyResponse.data.refreshToken
                if let payload = SupportManager.shared.decodeJwt(
                    jwtToken: emailOtpVerifyResponse.data.accessToken
                ) {
                    if let clientId = payload["clientId"] as? String {
                        CommonGround.shared.clientId = clientId
                    }

                    if let stylistId = payload["stylistId"] as? String {
                        CommonGround.shared.clientId = stylistId
                    }

                    if let role = payload["role"] as? String {
                        CommonGround.shared.role =
                            role == Role.stylist.rawValue
                            ? Role.stylist : Role.client
                    }

                    if let firstName = payload["firstName"] as? String,
                        let lastName = payload["lastName"] as? String,
                        let imageUrl = payload["imageUrl"] as? String
                    {
                        CommonGround.shared.userProfile = UserProfileModel(
                            firstName: firstName,
                            lastName: lastName,
                            imageUrl: imageUrl
                        )
                    }

                }
                CommonGround.shared.saveUserDefaults()
                NotificationManager.shared
                    .sendInstantNotifcation(
                        title: "Hey Saloon",
                        body:
                            "Welcome back \(CommonGround.shared.userProfile?.firstName ?? "User"), let's get you started. Have a greate experience with Hey Saloon. Enjoy the style!"
                    )
            }

        } else if response.statusCode == 401 {
            throw LoginError.otpInvalid
        } else if response.statusCode == 409 {
            throw LoginError.otpAlreadyVerified
        } else if response.statusCode == 410 {
            throw LoginError.otpExpired
        } else {
            throw NetworkError.processError
        }
    }

}
