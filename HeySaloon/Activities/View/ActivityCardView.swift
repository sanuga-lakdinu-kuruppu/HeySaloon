import SwiftUI

struct ActivityCardView: View {

    var booking: BookingModel
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width

    var body: some View {
        VStack {
            StylistProfileCardView(
                booking: booking,
                isShowStatus: false,
                backgroundColor: .accentColor,
                nameColor: .mainBackground,
                saloonColor: .mainBackground,
                ratingColor: .white,
                startColor: .white,
            )

            //status bar
            HStack {
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
                Spacer()
            }
            .padding(.leading, 8)

            //booking time bar
            HStack {
                HStack {
                    Image(systemName: "clock")
                        .frame(
                            width: screenwidth * 0.04,
                            height: screenwidth * 0.04
                        )
                        .foregroundColor(
                            .mainBackground
                        )

                    CaptionTextView(
                        text: booking.bookingTime,
                        foregroundColor: .mainBackground
                    )

                    Spacer()
                }
                Spacer()
            }
            .padding(.leading, 8)
            .padding(.bottom, 8)

        }
        .padding(8)
        .background(.white)
        .cornerRadius(screenwidth * 0.07)

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
    //    ActivityCardView()
}
