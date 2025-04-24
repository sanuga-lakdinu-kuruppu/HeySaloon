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

            //near by stylists
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    if nearByStylists.count == 1 {
                        ForEach(nearByStylists, id: \.stylistId) {
                            stylist in
                            FavoritesCardView(stylist: stylist)
                        }
                    } else {
                        ForEach(nearByStylists, id: \.stylistId) {
                            stylist in
                            NearByStylistCardView(
                                stylist: stylist
                            )
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
