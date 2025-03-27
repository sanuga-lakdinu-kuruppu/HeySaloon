import SwiftUI

struct LoginOtpVerificationView: View {

    @ObservedObject var commonGround: CommonGround
    let loginViewModel: LoginViewModel = LoginViewModel.shared
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width
    @State var otp: [String] = Array(repeating: "", count: 4)
    @State var isLoading: Bool = false
    @State var alertMessage: String = ""
    @State var isShowAlert: Bool = false

    var body: some View {
        ZStack {
            MainBackgroundView()
            VStack {
                VStack(spacing: 16) {
                    HStack {
                        TitleTextView(text: "Enter Received OTP")
                        Spacer()
                    }
                    .padding(.top, 32)

                    HStack {
                        CaptionTextView(
                            text:
                                "We have sent an otp to the entered \(commonGround.commingFrom == Route.emailLogin ? "email address" : "mobile number" )."
                        )
                        Spacer()
                    }

                    OtpInputCombinedView(otp: $otp)

                    HStack {
                        CaptionTextView(
                            text:
                                "Didn’t received an otp?"
                        )
                        HyberLinkTextView(
                            text: "resend",
                            foregroundColor: .accent
                        )
                        .onTapGesture {
                            requestNewOtp()
                        }
                        Spacer()
                    }

                }

                Spacer()

                Button {
                    verifyOtp()
                } label: {
                    MainButtonView(
                        text: "Verify",
                        foregroundColor: Color.black,
                        backgroundColor: Color.white,
                        isBoarder: false,
                        isDisabled: otp.joined().isEmpty || isLoading
                            || otp.joined().count != 4
                    )

                }
                .disabled(
                    otp.joined().isEmpty || otp.joined().count != 4
                        || isLoading)

            }
            .padding(.horizontal, screenwidth * 0.05)
            .padding(.bottom, 32)

            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
            }

        }
        .onDisappear {
            commonGround.commingFrom = Route.loginOtpVerification
        }
        .alert(
            alertMessage,
            isPresented: $isShowAlert
        ) {
            Button("OK", role: .cancel) {}
        }
    }

    private func clearOtpArray() {
        otp.removeAll()
        otp = Array(repeating: "", count: 4)
    }

    //request new otp network call
    private func requestNewOtp() {
        clearOtpArray()
        Task {
            isLoading = true
            do {
                try await loginViewModel
                    .requestOtpWithEmail(emailAddress: commonGround.email)
            } catch {

                showAlert(
                    message:
                        "Sorry!, Something went wrong. Please try again later.")
            }
            isLoading = false
        }
    }

    //to check the entered otp (start network call)
    private func verifyOtp() {
        Task {
            isLoading = true
            do {
                try await loginViewModel
                    .verifyOtpWithEmail(otp: otp.joined())
                commonGround.routes
                    .append(
                        Route.commonTab
                    )
            } catch LoginError.otpExpired {
                showAlert(
                    message:
                        "Sorry!, Entered OTP is expired. Please request a new OTP."
                )
            } catch LoginError.otpAlreadyVerified {
                showAlert(
                    message:
                        "Sorry!, OTP is already verified. Please try again.")
            } catch LoginError.otpInvalid {
                showAlert(
                    message:
                        "Sorry!, Enterd OTP is invalid. Please try again.")
            } catch {
                showAlert(
                    message:
                        "Sorry!, Something went wrong. Please try again later.")
            }
            isLoading = false
        }
    }

    //to show the alert
    private func showAlert(message: String) {
        alertMessage = message
        isShowAlert = true
    }
}

#Preview {
    LoginOtpVerificationView(commonGround: CommonGround.shared)
}
