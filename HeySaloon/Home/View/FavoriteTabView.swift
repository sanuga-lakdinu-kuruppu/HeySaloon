import SwiftUI

struct FavoriteTabView: View {

    var userProfile: UserProfileModel?
    var favoriteStylists: [StylistModel]

    var body: some View {
        VStack {
            HStack {
                HeadlineTextView(
                    text:
                        "\(userProfile?.firstName ?? "Guest")'s Favorites"
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

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(favoriteStylists, id: \._id) {
                        stylist in
                        FavoritesCardView(
                            imageUrl: stylist.thumbnailUrl,
                            stylistName:
                                "\(stylist.firstName) \(stylist.lastName)",
                            saloonName: stylist.saloonName,
                            rating: stylist.rating,
                            totalRating: stylist
                                .totalRating,
                            isOpen: stylist.isOpen
                        )
                    }
                }
            }
        }
    }
}

#Preview {
    //    FavoriteTabView()
}
