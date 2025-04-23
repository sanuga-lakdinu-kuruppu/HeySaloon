import SwiftUI

enum NetworkError: Error {
    case processError
    case notAuthorized
    case tokenExpired
}
