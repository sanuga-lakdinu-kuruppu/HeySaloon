import SwiftUI

struct MainBackgroundView: View {
    var body: some View {
        ContainerRelativeShape()
            .fill(Color("MainBackgroundColor"))
            .ignoresSafeArea()
    }
}

#Preview {
    MainBackgroundView()
}
