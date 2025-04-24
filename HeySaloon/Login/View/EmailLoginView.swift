import SwiftUI

struct EmailLoginView: View {

    @ObservedObject var commonGround: CommonGround
    let loginViewModel: LoginViewModel = LoginViewModel.shared
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width
    @State var email: String = ""
    @State var errorMessage: String? = nil
    @State var alertMessage: String = ""
    @State var isShowAlert: Bool = false
    @State var isLoading: Bool = false
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

    var body: some View {
        ZStack {
            MainBackgroundView()
            VStack {
                VStack(spacing: 16) {
                    HStack {
                        TitleTextView(text: "Continue With Email")
                        Spacer()
                    }
                    .padding(.top, 32)

                    HStack {
                        CaptionTextView(
                            text:
                                "We need your email address, you to use the application."
                        )
                        Spacer()
                    }

                    //email input
                    MainTextFieldView(
                        input: $email,
                        hint: "Enter your email address"
                    )
                    .onChange(of: email) { _ in
                        validateEmail()
                    }

                    //error message
                    if let errorMessage = errorMessage {
                        ErrorMessageTextView(text: errorMessage)
                    }
                }

                Spacer()

                // next button
                Button {
                    requestOtp()
                } label: {
                    MainButtonView(
                        text: "Next",
                        foregroundColor: Color.black,
                        backgroundColor: Color.white,
                        isBoarder: false,
                        isDisabled: email.isEmpty || errorMessage != nil
                            || isLoading
                    )
                }
                .disabled(email.isEmpty || errorMessage != nil || isLoading)

            }
            .padding(.horizontal, screenwidth * 0.05)
            .padding(.bottom, 32)

            if isLoading {
                CommonProgressView()
            }
        }
        .onDisappear {
            commonGround.commingFrom = Route.emailLogin
        }
        .alert(
            alertMessage,
            isPresented: $isShowAlert
        ) {
            Button("OK", role: .cancel) {}
        }
    }

    //starting otp request network call
    private func requestOtp() {
        Task {
            isLoading = true
            do {
                try await loginViewModel
                    .requestOtpWithEmail(emailAddress: email)
                commonGround.routes
                    .append(
                        Route.loginOtpVerification
                    )
            } catch LoginError.requestExceeded {
                showAlert(
                    message:
                        "Too many login requests. Please try again later."
                )
            } catch {
                showAlert(
                    message:
                        "Sorry!, Something went wrong. Please try again later."
                )
            }
            isLoading = false
        }
    }

    //to show the alert
    private func showAlert(message: String) {
        alertMessage = message
        isShowAlert = true
    }

    //to validate the entered email address
    private func validateEmail() {
        if email.isEmpty {
            errorMessage = "Email should be filled to continue."
        } else if email.range(
            of: emailRegex,
            options: .regularExpression,
            range: nil,
            locale: nil
        ) == nil {
            errorMessage =
                "Email should be a correct email address (ex: sample@gmail.com)."
        } else {
            errorMessage = nil
        }
    }
}

#Preview {
    EmailLoginView(commonGround: CommonGround.shared)
}
