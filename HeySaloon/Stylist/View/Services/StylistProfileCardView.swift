import SwiftUI

struct StylistProfileCardView: View {

    var booking: BookingModel?
    var isShowStatus: Bool = true
    var backgroundColor: Color = .white
    var nameColor: Color = .mainBackground
    var saloonColor: Color = .accentColor
    var ratingColor: Color = .mainBackground
    var startColor: Color = .accentColor
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width

    var body: some View {
        HStack {

            //information view
            if let booking = booking, let stylist = booking.stylist {
                VStack(
                    alignment: .leading,
                    spacing: screenwidth * 0.02
                ) {
                    CalloutTextView(
                        text: [stylist.firstName, stylist.lastName]
                            .compactMap { $0 }
                            .joined(separator: " "),
                        foregroundColor: nameColor
                    )

                    CaptionTextView(
                        text: "From \(booking.stylist?.saloonName ?? "")",
                        foregroundColor: saloonColor
                    )

                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(startColor)
                        CaptionTextView(
                            text:
                                "\(stylist.currentRating ?? 0.0)(\(booking.stylist?.totalReviewed ?? 0))",
                            foregroundColor: ratingColor
                        )

                        if isShowStatus {
                            HStack {
                                Circle()
                                    .frame(
                                        width: screenwidth * 0.04,
                                        height: screenwidth * 0.04
                                    )
                                    .foregroundColor(
                                        getColorCode(
                                            status: booking.status
                                        )
                                    )
                                CaptionTextView(
                                    text:

                                        booking.status,
                                    foregroundColor: .mainBackground
                                )
                            }
                            .padding(.leading, screenwidth * 0.04)
                        }

                    }
                }

                Spacer()

                //image view
                AsyncImage(
                    url: URL(
                        string:
                            stylist.profileUrl ?? ""
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

        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(backgroundColor)
        .cornerRadius(screenwidth * 0.06)
    }

    func getColorCode(status: String) -> Color {
        if status == "QUEUED" {
            return .accent
        } else if status == "COMPLETED" {
            return Color("SuccessColor")
        } else {
            return .error
        }
    }
}

#Preview {
    //    StylistProfileCardView()
}
