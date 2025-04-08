import SwiftUI

struct StylistProfileCardView: View {

    var thisStylist: StylistModel
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width

    var body: some View {
        HStack {

            //information view
            VStack(
                alignment: .leading,
                spacing: screenwidth * 0.02
            ) {
                CalloutTextView(
                    text:
                        thisStylist.firstName + " "
                        + thisStylist.lastName,
                    foregroundColor: .mainBackground
                )

                CaptionTextView(
                    text: "From \(thisStylist.saloonName)",
                    foregroundColor: .accent
                )

                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(Color("AccentColor"))
                    CaptionTextView(
                        text:
                            "\(thisStylist.rating)(\(thisStylist.totalRating))",
                        foregroundColor: .mainBackground
                    )
                }
            }

            Spacer()

            //image view
            AsyncImage(
                url: URL(
                    string:
                        thisStylist.imageUrl
                )
            ) { Image in
                Image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
            } placeholder: {
                Circle()
                    .foregroundColor(.gray)
            }
            .frame(
                width: screenwidth * 0.15,
                height: screenwidth * 0.15
            )

        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(screenwidth * 0.05)
    }
}

#Preview {
    //    StylistProfileCardView()
}
