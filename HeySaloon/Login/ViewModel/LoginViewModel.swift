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

        guard let requestEncoded = try? JSONEncoder().encode(emailLoginRequest)
        else {
            throw LoginError.processError
        }

        //http request creation
        guard let url = URL(string: loginRequestEndpoint) else {
            throw LoginError.processError
        }

        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"

        //request made
        let (data, response) = try await URLSession.shared.upload(
            for: request,
            from: requestEncoded
        )

        guard let response = response as? HTTPURLResponse
        else {
            throw LoginError.processError
        }

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
            throw LoginError.processError
        }
    }

    func verifyOtpWithEmail(otp: String) async throws {

        //request object creation
        let emailOtpVerifyRequest = EmailOtpVerifyRequest(
            email: CommonGround.shared.email, type: "EMAIL_LOGIN", otp: otp)

        guard
            let requestEncoded = try? JSONEncoder().encode(
                emailOtpVerifyRequest)
        else {
            throw LoginError.processError
        }

        //http request creation
        guard let url = URL(string: otpVerifyEndpoint) else {
            throw LoginError.processError
        }

        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"

        //request made
        let (data, response) = try await URLSession.shared.upload(
            for: request,
            from: requestEncoded
        )

        guard let response = response as? HTTPURLResponse
        else {
            throw LoginError.processError
        }

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

                }
            } else if emailOtpVerifyResponse.status == "1112" {
                throw LoginError.otpExpired
            } else if emailOtpVerifyResponse.status == "1113" {
                throw LoginError.otpAlreadyVerified
            } else if emailOtpVerifyResponse.status == "1114" {
                throw LoginError.otpInvalid
            } else {
                throw LoginError.processError
            }

        } else {
            print("c")
            throw LoginError.processError
        }
    }

}
