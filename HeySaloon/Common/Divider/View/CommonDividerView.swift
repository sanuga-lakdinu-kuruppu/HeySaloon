import SwiftUI

struct CommonDividerView: View {
    var body: some View {
        Divider()
            .frame(maxWidth: .infinity, maxHeight: 1)
            .background(.white)
            .padding(.top, 8)
    }
}

#Preview {
    CommonDividerView()
}
