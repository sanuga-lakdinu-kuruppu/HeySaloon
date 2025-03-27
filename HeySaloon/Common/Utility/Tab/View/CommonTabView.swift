import SwiftUI

struct CommonTabView: View {

    @ObservedObject var commonGround: CommonGround

    var body: some View {
        TabView {
            HomeView(commonGround: commonGround)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            ActivitiesView()
                .tabItem {
                    Image(systemName: "list.clipboard.fill")
                    Text("Activities")
                }
            AccountView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Account")
                }
        }
        .onAppear {
            UITabBar.appearance().backgroundColor = .secondaryBackground
            UITabBar.appearance().unselectedItemTintColor = .white
        }
        .accentColor(.accentColor)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    CommonTabView(commonGround: CommonGround.shared)
}
