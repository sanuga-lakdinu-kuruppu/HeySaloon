import SwiftUI

struct StylistProfileCardView: View {

    var booking: BookingModel?
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
                        foregroundColor: .mainBackground
                    )

                    CaptionTextView(
                        text: "From \(booking.stylist?.saloonName ?? "")",
                        foregroundColor: .accent
                    )

                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(Color("AccentColor"))
                        CaptionTextView(
                            text:
                                "\(stylist.currentRating ?? 0.0)(\(booking.stylist?.totalReviewed ?? 0))",
                            foregroundColor: .mainBackground
                        )

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
        .background(.white)
        .cornerRadius(screenwidth * 0.05)
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
