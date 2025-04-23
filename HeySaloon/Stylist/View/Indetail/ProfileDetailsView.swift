import SwiftUI

struct ProfileDetailsView: View {

    var stylist: StylistModel
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width
    @State var screenHeight: CGFloat = UIScreen.main.bounds.height

    var body: some View {
        VStack(alignment: .leading, spacing: screenwidth * 0.02) {

            //favorite icon
            HStack {
                Spacer()
                Image(systemName: "heart")
                    .resizable()
                    .frame(
                        width: screenwidth * 0.05,
                        height: screenwidth * 0.05
                    )
                    .foregroundColor(.white)
            }
            .padding(.top, screenwidth * 0.02)

            //profile image
            AsyncImage(
                url: URL(
                    string: stylist.profileUrl
                )
            ) { Image in
                Image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
            } placeholder: {
                Circle()
                    .foregroundColor(.white)
            }
            .frame(
                width: screenwidth * 0.25,
                height: screenwidth * 0.25
            )
            .padding(.top, screenwidth * 0.06)

            //name
            TitleTextView(
                text: (stylist.firstName) + " "
                    + (stylist.lastName)
            )

            //extra data
            HStack(spacing: screenwidth * 0.04) {
                HStack {
                    Circle()
                        .frame(
                            width: screenwidth * 0.04,
                            height: screenwidth * 0.04
                        )
                        .foregroundColor(
                            stylist.isOpen ?? false
                                ? Color("SuccessColor") : .error
                        )
                    CaptionTextView(
                        text: stylist.isOpen ?? false ? "Open Now" : "Closed",
                        foregroundColor: .white
                    )
                }

                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(Color("AccentColor"))
                    CaptionTextView(
                        text:
                            "\(stylist.currentRating ?? 0.0)(\(stylist.totalReviewed ?? 0))",
                        foregroundColor: .white
                    )
                }
            }

            Spacer()
        }
        .padding(.horizontal, screenwidth * 0.05)
    }
}

#Preview {
    ProfileDetailsView(
        stylist: .init(
            stylistId: "",
            firstName: "",
            lastName: "",
            profileUrl: "",
            thumbnailUrl: ""
        )
    )
}
