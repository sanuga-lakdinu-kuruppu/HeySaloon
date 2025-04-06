import SwiftUI

struct FavoritesCardView: View {

    var stylist: StylistModel
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width
    let cardHeight = UIScreen.main.bounds.width * 0.22

    var body: some View {
        HStack(spacing: 16) {

            //left side
            AsyncImage(
                url: URL(
                    string:
                        stylist.thumbnailUrl
                )
            ) { Image in
                Image
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: cardHeight - 16,
                        height: cardHeight - 16
                    )
                    .clipShape(
                        RoundedRectangle(cornerRadius: 16)
                    )
                    .clipped()
            } placeholder: {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(.hint)
                    .frame(
                        width: cardHeight - 16,
                        height: cardHeight - 16
                    )
            }
            .padding(.leading, 8)

            //right side
            VStack(alignment: .leading) {
                //top
                CalloutTextView(
                    text:
                        stylist.firstName + " " + stylist.lastName,
                    foregroundColor: .mainBackground
                )
                CaptionTextView(
                    text: "From \(stylist.saloonName)",
                    foregroundColor: .mainBackground
                )
                Spacer()

                //bottom
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(Color("AccentColor"))
                    CaptionTextView(
                        text: "\(stylist.rating)(\(stylist.totalRating))",
                        foregroundColor: .hint
                    )
                    CaptionTextView(
                        text: stylist.isOpen ? "Open Now" : "Closed",
                        foregroundColor: stylist.isOpen
                            ? Color("AccentColor") : .error
                    )
                }
            }
            .padding(.vertical, 8)

            Spacer()

        }
        .frame(
            width: screenwidth * 0.8,
            height: cardHeight
        )
        .background(.white)
        .cornerRadius(24)
    }
}

#Preview {
    FavoritesCardView(
        stylist: .init(
            _id: "fds",
            stylistId: 432,
            firstName: "jfadls",
            lastName: "kjladfs",
            thumbnailUrl: "fjdalks",
            imageUrl: "fkjadls",
            saloonName: "jfdslake",
            location: .init(coordinates: [3, 3]),
            rating: 432.423,
            totalRating: 23,
            isOpen: true,
            start: "42",
            end: "ffds",
            totalQueued: 22,
            finishedAt: "2024-03-28T16:30:00.000Z",
            services: [
                .init(id: 1, name: "Crew Cut", price: 1200.00, minutes: 25),
                .init(id: 2, name: "Buzz Cut", price: 1300.00, minutes: 30),
                .init(
                    id: 3,
                    name: "Beard Trim & Shaping",
                    price: 900.00,
                    minutes: 15
                ),
            ]
        )
    )
}
