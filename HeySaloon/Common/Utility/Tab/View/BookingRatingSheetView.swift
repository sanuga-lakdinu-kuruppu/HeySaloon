import SwiftUI

struct BookingRatingSheetView: View {

    @State var screenwidth: CGFloat = UIScreen.main.bounds.width
    @StateObject var webSocketManager = WebSocketManager.shared
    @State var rating: Int = 0

    var body: some View {
        ZStack {
            VStack {
                if let booking = webSocketManager.currentBooking {
                    VStack(spacing: screenwidth * 0.08) {
                        CommonSheetTitleView(
                            title: "Rate the Stylist",
                            isClosed: $webSocketManager.isPaid
                        )

                        VStack(spacing: screenwidth * 0.04) {
                            //image view
                            AsyncImage(
                                url: URL(
                                    string:
                                        booking.stylist?.profileUrl ?? ""
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
                                width: screenwidth * 0.4,
                                height: screenwidth * 0.4
                            )

                            CalloutTextView(
                                text:
                                    "\(booking.stylist?.firstName ?? "") \(booking.stylist?.lastName ?? "")"
                            )
                            CaptionTextView(
                                text:
                                    "From \(booking.stylist?.saloonName ?? "")",
                                foregroundColor: .accent
                            )
                        }

                        VStack(spacing: screenwidth * 0.04) {

                            //rating bar
                            HStack(spacing: screenwidth * 0.03) {
                                ForEach(1...5, id: \.self) { index in
                                    Button {
                                        rating = index
                                    } label: {
                                        Image(
                                            systemName: index <= rating
                                                && index > 0
                                                ? "star.fill" : "star"
                                        )
                                        .resizable()
                                        .frame(
                                            width: screenwidth * 0.08,
                                            height: screenwidth * 0.08
                                        )
                                        .foregroundColor(.yellow)
                                    }
                                }

                            }

                            //rating button
                            Button {
                            } label: {
                                MainButtonView(
                                    text:
                                        "Rate & Review",
                                    foregroundColor: Color(
                                        "MainBackgroundColor"
                                    ),
                                    backgroundColor: .accent,
                                    isBoarder: false
                                )
                            }
                        }

                    }
                    .padding(.top, screenwidth * 0.08)
                    .padding(.horizontal, screenwidth * 0.05)

                }

                Spacer()
            }
            .presentationDetents([.fraction(0.7)])
            .presentationCornerRadius(50)
            .presentationBackground(Color("SecondaryBackgroundColor"))
            .presentationDragIndicator(.hidden)
            .interactiveDismissDisabled(true)
        }
    }
}

#Preview {
    BookingRatingSheetView()
}
