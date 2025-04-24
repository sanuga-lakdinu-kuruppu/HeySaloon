import SwiftUI

struct FavoriteTabView: View {

    var userProfile: UserProfileModel?
    var favoriteStylists: [StylistModel]

    var body: some View {
        VStack {
            HStack {
                HeadlineTextView(
                    text:
                        "\(userProfile?.firstName.isEmpty == false ? userProfile!.firstName : "Guest")'s Favorites"
                )

                Spacer()
                CalloutTextView(
                    text:
                        "See more"
                )
                .onTapGesture {
                    print("see more clicked")
                }
            }

            //favourite items
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(favoriteStylists, id: \.stylistId) {
                        stylist in
                        FavoritesCardView(stylist: stylist)
                    }
                }
            }
        }
    }
}

#Preview {
    //    FavoriteTabView()
}
