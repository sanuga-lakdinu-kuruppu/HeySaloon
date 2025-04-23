import SwiftUI

struct NearByStylistCardView: View {

    var stylist: StylistModel
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width
    let verticalCardWidth = (0.9 * UIScreen.main.bounds.width - 16) * 0.5
    @State var isFavoriteSelected: Bool = false

    var body: some View {
        VStack(spacing: screenwidth * 0.02) {

            //image
            ZStack {
                AsyncImage(
                    url: URL(
                        string: stylist.thumbnailUrl
                    )
                ) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(
                            width: verticalCardWidth,
                            height: verticalCardWidth * 0.7
                        )
                        .clipShape(
                            RoundedRectangle(cornerRadius: screenwidth * 0.06)
                        )
                        .clipped()
                } placeholder: {
                    RoundedRectangle(cornerRadius: screenwidth * 0.06)
                        .foregroundColor(.hint)
                        .frame(
                            width: verticalCardWidth,
                            height: verticalCardWidth * 0.7
                        )
                }
                VStack {
                    HStack {
                        Spacer()
                        Image(
                            systemName: isFavoriteSelected
                                ? "heart.fill" : "heart"
                        )
                        .foregroundColor(
                            isFavoriteSelected ? .error : .white
                        )
                        .onTapGesture {
                            isFavoriteSelected.toggle()
                        }
                    }
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
                .padding(.top, screenwidth * 0.04)
                .padding(.horizontal, screenwidth * 0.04)
                .padding(.bottom, screenwidth * 0.02)
            }

            //information
            VStack(spacing: screenwidth * 0.02) {
                CaptionTextView(
                    text: stylist.isOpen ?? false ? "Open Now" : "Closed",
                    foregroundColor: stylist.isOpen ?? false
                        ? Color(
                            "AccentColor"
                        ) : .error
                )

                CaptionTextView(
                    text:
                        "(\(stylist.startTime ?? "") - \(stylist.endTime ?? ""))",
                    foregroundColor: .hint
                )

                CalloutTextView(
                    text:
                        "\(stylist.firstName) \(stylist.lastName)",
                    foregroundColor: .white
                )
                CaptionTextView(
                    text: "From \(stylist.saloonName ?? "")",
                    foregroundColor: .white
                )

                HStack {
                    Image(systemName: "person.2.fill")
                        .foregroundColor(.hint)
                    CaptionTextView(
                        text:
                            "\(stylist.totalQueued ?? 0) Until (\(SupportManager.shared.getFinishTime(finishTime: stylist.queueWillEnd ?? "")))",
                        foregroundColor: .hint
                    )
                }

                //book button
                Button {

                } label: {
                    BookNowButtonView()
                }
                .padding(.top, screenwidth * 0.02)
            }

            Spacer()
        }
        .frame(
            width: verticalCardWidth,
            height: screenwidth * 0.8
        )
        .background(.secondaryBackground)
        .cornerRadius(screenwidth * 0.08)
        .overlay(
            RoundedRectangle(cornerRadius: screenwidth * 0.08)
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
            stylistId: "",
            firstName: "",
            lastName: "",
            profileUrl: "",
            thumbnailUrl: ""
        )
    )
}
