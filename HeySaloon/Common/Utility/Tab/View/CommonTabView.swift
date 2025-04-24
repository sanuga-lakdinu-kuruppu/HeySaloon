import SwiftUI

struct CommonTabView: View {

    @ObservedObject var commonGround: CommonGround
    @StateObject var webSocketManager = WebSocketManager.shared
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width

    var body: some View {
        TabView(selection: $commonGround.selectedTab) {
            HomeView(commonGround: commonGround)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(Tab.home)
            ActivitiesView()
                .tabItem {
                    Image(systemName: "list.clipboard.fill")
                    Text("Activities")
                }
                .tag(Tab.activities)
            AccountView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Account")
                }
                .tag(Tab.account)
        }
        .onAppear {
            UITabBar.appearance().backgroundColor = .secondaryBackground
            UITabBar.appearance().unselectedItemTintColor = .white
        }
        .accentColor(.accentColor)
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $webSocketManager.isPaid) {
            BookingRatingSheetView()
        }
        .sheet(isPresented: $webSocketManager.isCompleted) {
            BookingPaymentSheetView()
        }
    }
}

enum Tab {
    case home
    case activities
    case account
}

#Preview {
    CommonTabView(commonGround: CommonGround.shared)
}
