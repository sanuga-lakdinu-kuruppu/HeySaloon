import SwiftUI

struct NearByStylistCardView: View {

    var stylist: StylistModel
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width
    let verticalCardWidth = (0.9 * UIScreen.main.bounds.width - 16) * 0.5

    var body: some View {
        VStack(spacing: 8) {

            //image
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
            .padding(.top, 8)

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
                    text: "(\(stylist.start) - \(stylist.end)",
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
                        text: "\(stylist.totalQueued) Until (17:20)",
                        foregroundColor: .hint
                    )
                }

                //book button
                Button {

                } label: {
                    Text("Book Now")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(
                            Color("MainBackgroundColor")
                        )
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(.white)
                        .cornerRadius(50)
                        .accessibilityLabel("")
                        .accessibilityHint("Tap to continue")
                        .accessibilityAddTraits(.isButton)
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
    //    NearByStylistCardView()
}
