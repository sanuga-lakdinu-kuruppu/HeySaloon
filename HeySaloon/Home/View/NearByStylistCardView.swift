import SwiftUI

struct NearByStylistCardView: View {

    var stylist: StylistModel
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width
    let verticalCardWidth = (0.9 * UIScreen.main.bounds.width - 16) * 0.5
    @State var isFavoriteSelected: Bool = false

    var body: some View {
        VStack(spacing: 8) {

            //image
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
                            maxWidth: verticalCardWidth - 16,
                            maxHeight: verticalCardWidth * 0.8
                        )
                        .clipShape(
                            RoundedRectangle(cornerRadius: 24)
                        )
                        .clipped()

                } placeholder: {
                    RoundedRectangle(cornerRadius: 24)
                        .foregroundColor(.hint)
                        .frame(
                            maxWidth: verticalCardWidth - 16,
                            maxHeight: verticalCardWidth * 0.8
                        )
                }

                VStack {
                    HStack {
                        Spacer()
                        Image(
                            systemName: isFavoriteSelected
                                ? "heart.fill" : "heart"
                        )
                        .foregroundColor(isFavoriteSelected ? .error : .white)
                        .onTapGesture {
                            isFavoriteSelected.toggle()
                        }
                    }
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
                .padding(.horizontal, 24)
                .padding(.top, 24)
                .padding(.bottom, 8)
            }

            //information
            VStack(spacing: 8) {
                CaptionTextView(
                    text: stylist.isOpen ? "Open Now" : "Closed",
                    foregroundColor: stylist.isOpen
                        ? Color(
                            "AccentColor"
                        ) : .error
                )

                CaptionTextView(
                    text: "(\(stylist.start) - \(stylist.end))",
                    foregroundColor: .hint
                )

                CalloutTextView(
                    text:
                        "\(stylist.firstName) \(stylist.lastName)",
                    foregroundColor: .white
                )
                CaptionTextView(
                    text: "From \(stylist.saloonName)",
                    foregroundColor: .white
                )

                HStack {
                    Image(systemName: "person.2.fill")
                        .foregroundColor(.hint)
                    CaptionTextView(
                        text:
                            "\(stylist.totalQueued) Until (\(SupportManager.shared.getFinishTime(finishTime: stylist.finishedAt)))",
                        foregroundColor: .hint
                    )
                }

                //book button
                Button {

                } label: {
                    BookNowButtonView()
                }
                .padding(.top, 8)
            }
            .padding(.horizontal, 8)

            Spacer()
        }
        .frame(
            width: verticalCardWidth,
            height: screenwidth * 0.8
        )
        .padding(.top, 8)
        .background(.secondaryBackground)
        .cornerRadius(32)
        .overlay(
            RoundedRectangle(cornerRadius: 32)
                .stroke(
                    Color("BorderLineColor"),
                    lineWidth: 2
                )
        )
    }
}

#Preview {
    NearByStylistCardView(
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
