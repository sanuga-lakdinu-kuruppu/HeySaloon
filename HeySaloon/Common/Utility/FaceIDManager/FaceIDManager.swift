import LocalAuthentication

class FaceIDManager: ObservableObject {
    @Published var isAuthenticated: Bool = false

    func authenticate() {
        let laContext = LAContext()
        var error: NSError?

        if laContext
            .canEvaluatePolicy(
                .deviceOwnerAuthenticationWithBiometrics,
                error: &error
            )
        {
            let reason = "Unlock Hey Saloon using Face ID"
            laContext.evaluatePolicy(
                .deviceOwnerAuthenticationWithBiometrics,
                localizedReason: reason
            ) { success, error in
                DispatchQueue.main.async {
                    if success {
                        //face auth success
                        self.isAuthenticated = true
                    } else {
                        //face auth failed
                    }
                }
            }
        }
    }
}
