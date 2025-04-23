import SwiftUI

enum LoginError: Error {
    case otpSendingError
    case otpExpired
    case otpAlreadyVerified
    case otpInvalid
    case requestExceeded
}
