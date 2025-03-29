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
                            height: cardHeight - 16)
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
                            "\(stylist.totalQueued) Until (\(getFinishTime(finishTime: stylist.finishedAt)))",
                        foregroundColor: .hint
                    )
                }
            }

            Spacer()

        }
        .padding(8)
        .frame(
            maxWidth: .infinity, maxHeight: cardHeight
        )
        .background(.white)
        .cornerRadius(32)
    }

    //to convert the time string to the desired format
    func getFinishTime(finishTime: String) -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [
            .withInternetDateTime, .withFractionalSeconds,
        ]

        if let date = formatter.date(from: finishTime) {
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm"
            let timeOnly = timeFormatter.string(from: date)
            return timeOnly
        } else {
            return ""
        }
    }
}

#Preview {
    SearchResultCardView(
        stylist: .init(
            _id: "fds",
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
            finishedAt: "2024-03-28T16:30:00.000Z"
        ))
}
