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
                            text:
                                "\(stylist.currentRating ?? 0.0)(\(stylist.totalReviewed ?? 0))",
                            foregroundColor: .white
                        )
                    }
                }
                .padding(.bottom, 8)
            }

            //right side
            VStack(alignment: .leading, spacing: 8) {

                CaptionTextView(
                    text: stylist.isOpen ?? false ? "Open Now" : "Closed",
                    foregroundColor: stylist.isOpen ?? false
                        ? Color("AccentColor") : .error
                )

                CalloutTextView(
                    text:
                        stylist.firstName + " " + stylist.lastName,
                    foregroundColor: .mainBackground
                )

                CaptionTextView(
                    text: "From \(stylist.saloonName ?? "")",
                    foregroundColor: .mainBackground
                )

                HStack {
                    Image(systemName: "clock.fill")
                        .foregroundColor(.hint)
                    CaptionTextView(
                        text:
                            "\(stylist.startTime ?? "09:00") - \(stylist.endTime ?? "17:00")",
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
                            "\(stylist.totalQueued ?? 0) Until (\(SupportManager.shared.getFinishTime(finishTime: stylist.queueWillEnd ?? "")))",
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
            stylistId: "",
            firstName: "",
            lastName: "",
            profileUrl: "",
            thumbnailUrl: ""
        )
    )
}
