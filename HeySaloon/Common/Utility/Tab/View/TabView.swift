import SwiftUI

struct TabView: View {
    var body: some View {
        VStack {
            Text("This is the tab view")
        }.onAppear {
//            NotificationManager.shared.requestPermission()
        }
    }
}

#Preview {
    TabView()
}
