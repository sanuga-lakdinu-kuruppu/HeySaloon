import SwiftUI

struct CommonProgressView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .white))
    }
}

#Preview {
    CommonProgressView()
}
