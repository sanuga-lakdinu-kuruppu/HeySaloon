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
                    text: "From \(stylist.saloonName ?? "")",
                    foregroundColor: .mainBackground
                )
                Spacer()

                //bottom
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(Color("AccentColor"))
                    CaptionTextView(
                        text:
                            "\(stylist.currentRating ?? 0.0)(\(stylist.totalReviewed ?? 0))",
                        foregroundColor: .hint
                    )
                    CaptionTextView(
                        text: stylist.isOpen ?? false ? "Open Now" : "Closed",
                        foregroundColor: stylist.isOpen ?? false
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
            stylistId: "",
            firstName: "",
            lastName: "",
            profileUrl: "",
            thumbnailUrl: ""
        )
    )
}
