import SwiftUI

struct SearchResultCardView: View {

    var stylist: StylistModel
    let cardHeight = UIScreen.main.bounds.width * 0.45

    var body: some View {
        HStack(spacing: 16) {

            //left side
            ZStack {
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
                            RoundedRectangle(cornerRadius: 24)
                        )
                        .clipped()
                } placeholder: {
                    RoundedRectangle(cornerRadius: 24)
                        .foregroundColor(.hint)
                        .frame(
                            width: cardHeight - 16,
                            height: cardHeight - 16
                        )
                }

                VStack {
                    Spacer()
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(Color("AccentColor"))
                        CaptionTextView(
                            text: "\(stylist.rating)(\(stylist.totalRating))",
                            foregroundColor: .white
                        )
                    }
                }
                .padding(.bottom, 8)
            }

            //right side
            VStack(alignment: .leading, spacing: 8) {

                CaptionTextView(
                    text: stylist.isOpen ? "Open Now" : "Closed",
                    foregroundColor: stylist.isOpen
                        ? Color("AccentColor") : .error
                )

                CalloutTextView(
                    text:
                        stylist.firstName + " " + stylist.lastName,
                    foregroundColor: .mainBackground
                )

                CaptionTextView(
                    text: "From \(stylist.saloonName)",
                    foregroundColor: .mainBackground
                )

                HStack {
                    Image(systemName: "clock.fill")
                        .foregroundColor(.hint)
                    CaptionTextView(
                        text: "\(stylist.start) - \(stylist.end)",
                        foregroundColor: .hint
                    )
                }

                HStack {
                    Image(systemName: "location.fill")
                        .foregroundColor(.hint)
                    CaptionTextView(
                        text: "1.3 Km",
                        foregroundColor: .hint
                    )
                }

                HStack {
                    Image(systemName: "person.2.fill")
                        .foregroundColor(.hint)
                    CaptionTextView(
                        text:
                            "\(stylist.totalQueued) Until (\(SupportManager.shared.getFinishTime(finishTime: stylist.finishedAt)))",
                        foregroundColor: .hint
                    )
                }
            }

            Spacer()

        }
        .padding(8)
        .frame(
            maxWidth: .infinity,
            maxHeight: cardHeight
        )
        .background(.white)
        .cornerRadius(32)
    }
}

#Preview {
    SearchResultCardView(
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
