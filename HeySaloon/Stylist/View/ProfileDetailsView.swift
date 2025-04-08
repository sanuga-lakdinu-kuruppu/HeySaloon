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
                    string:
                        stylist.imageUrl
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
            TitleTextView(text: stylist.firstName + " " + stylist.lastName)

            //extra data
            HStack(spacing: screenwidth * 0.04) {
                HStack {
                    Circle()
                        .frame(
                            width: screenwidth * 0.04,
                            height: screenwidth * 0.04
                        )
                        .foregroundColor(
                            stylist.isOpen ? Color("SuccessColor") : .error
                        )
                    CaptionTextView(
                        text: stylist.isOpen ? "Open Now" : "Closed",
                        foregroundColor: .white
                    )
                }

                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(Color("AccentColor"))
                    CaptionTextView(
                        text: "\(stylist.rating)(\(stylist.totalRating))",
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
