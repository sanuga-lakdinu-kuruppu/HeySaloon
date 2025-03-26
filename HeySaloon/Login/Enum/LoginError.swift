import SwiftUI

enum LoginError: Error {
    case processError
    case otpSendingError
    case otpExpired
    case otpAlreadyVerified
    case otpInvalid
}
