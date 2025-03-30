import SwiftUI

class LoginViewModel {
    static let shared = LoginViewModel()
    let loginRequestEndpoint = "\(CommonGround.shared.baseUrl)/auth/request"
    let otpVerifyEndpoint = "\(CommonGround.shared.baseUrl)/auth/verify"

    private init() {}

    func requestOtpWithEmail(emailAddress: String) async throws {

        //request object creation
        let emailLoginRequest = EmailLoginRequest(
            email: emailAddress, type: "EMAIL_LOGIN")

        //network call
        let (data, response) = try await NetworkSupporter.shared.call(
            request: emailLoginRequest,
            endpoint: loginRequestEndpoint,
            method: "POST",
            isSecured: false
        )

        //response handling
        if response.statusCode == 200 {
            let emailLoginResponse = try JSONDecoder().decode(
                EmailLoginResponse.self,
                from: data
            )
            if emailLoginResponse.status == "0000" {
                DispatchQueue.main.async {
                    CommonGround.shared.email = emailAddress
                }
            } else {
                throw LoginError.otpSendingError
            }

        } else {
            throw NetworkError.processError
        }
    }

    func verifyOtpWithEmail(otp: String) async throws {

        //request object creation
        let emailOtpVerifyRequest = EmailOtpVerifyRequest(
            email: CommonGround.shared.email, type: "EMAIL_LOGIN", otp: otp)

        //network call
        let (data, response) = try await NetworkSupporter.shared.call(
            request: emailOtpVerifyRequest,
            endpoint: otpVerifyEndpoint,
            method: "POST",
            isSecured: false
        )

        //response handling
        if response.statusCode == 200 {
            let emailOtpVerifyResponse = try JSONDecoder().decode(
                EmailOtpVerifyResponse.self,
                from: data
            )

            if emailOtpVerifyResponse.status == "0000" {
                DispatchQueue.main.async {
                    CommonGround.shared.accessToken =
                        emailOtpVerifyResponse.data!.accessToken!
                    CommonGround.shared.refreshToken =
                        emailOtpVerifyResponse.data!.refreshToken!
                    CommonGround.shared.idToken =
                        emailOtpVerifyResponse.data!.idToken!
                    CommonGround.shared.role =
                        emailOtpVerifyResponse.data!.role!
                    CommonGround.shared.isLoggedIn = true
                    CommonGround.shared.saveUserDefaults()

                    NotificationManager.shared
                        .sendInstantNotifcation(
                            title: "Hey Saloon",
                            body:
                                "Welcome back, let's get you started. Have a greate experience with Hey Saloon. Enjoy the style!"
                        )

                }
            } else if emailOtpVerifyResponse.status == "1112" {
                throw LoginError.otpExpired
            } else if emailOtpVerifyResponse.status == "1113" {
                throw LoginError.otpAlreadyVerified
            } else if emailOtpVerifyResponse.status == "1114" {
                throw LoginError.otpInvalid
            } else {
                throw NetworkError.processError
            }

        } else {
            throw NetworkError.processError
        }
    }

}
