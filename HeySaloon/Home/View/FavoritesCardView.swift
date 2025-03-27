import SwiftUI

struct FavoritesCardView: View {

    @State var screenwidth: CGFloat = UIScreen.main.bounds.width
    var imageUrl: String
    var stylistName: String
    var saloonName: String
    var rating: Double
    var totalRating: Int
    var isOpen: Bool

    var body: some View {
        HStack(spacing: 16) {

            //left side
            AsyncImage(
                url: URL(
                    string:
                        imageUrl
                )
            ) { Image in
                Image
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: screenwidth * 0.21,
                        height: screenwidth * 0.21
                    )
                    .clipShape(
                        RoundedRectangle(cornerRadius: 24)
                    )
                    .clipped()
            } placeholder: {
                RoundedRectangle(cornerRadius: 24)
                    .foregroundColor(.hint)
                    .frame(
                        width: screenwidth * 0.21,
                        height: screenwidth * 0.21)
            }

            //right side
            VStack(alignment: .leading) {
                //top
                CalloutTextView(
                    text:
                        stylistName,
                    foregroundColor: .mainBackground
                )
                CaptionTextView(
                    text: "From \(saloonName)",
                    foregroundColor: .mainBackground
                )
                Spacer()

                //bottom
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(Color("AccentColor"))
                    CaptionTextView(
                        text: "\(rating)(\(totalRating))",
                        foregroundColor: .hint
                    )
                    CaptionTextView(
                        text: isOpen ? "Open Now" : "Closed",
                        foregroundColor: isOpen ? Color("AccentColor") : .error
                    )
                }
            }

            Spacer()

        }
        .padding(16)
        .frame(
            width: screenwidth * 0.8, height: screenwidth * 0.27
        )
        .background(.white)
        .cornerRadius(32)
    }
}

#Preview {
    FavoritesCardView(
        imageUrl: "",
        stylistName: "Mr. Michael DeMoya",
        saloonName: "Sayona Saloon",
        rating: 4.7,
        totalRating: 422,
        isOpen: true
    )
}
