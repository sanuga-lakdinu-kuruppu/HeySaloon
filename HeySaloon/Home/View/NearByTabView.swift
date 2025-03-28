import SwiftUI

struct NearByTabView: View {

    var nearByStylists: [StylistModel]

    var body: some View {
        VStack {
            HStack {
                HeadlineTextView(
                    text:
                        "Nearby Stylists"
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
                    if nearByStylists.count == 1 {
                        ForEach(nearByStylists, id: \._id) {
                            stylist in
                            FavoritesCardView(
                                imageUrl: stylist
                                    .thumbnailUrl,
                                stylistName:
                                    "\(stylist.firstName) \(stylist.lastName)",
                                saloonName: stylist
                                    .saloonName,
                                rating: stylist.rating,
                                totalRating: stylist
                                    .totalRating,
                                isOpen: stylist.isOpen
                            )
                        }
                    } else {
                        ForEach(nearByStylists, id: \._id) {
                            stylist in
                            NearByStylistCardView(
                                stylist: stylist)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    //    NearByTabView()
}
