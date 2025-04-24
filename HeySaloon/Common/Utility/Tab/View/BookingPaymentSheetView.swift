import SwiftUI

struct BookingPaymentSheetView: View {

    @StateObject var webSocketManager = WebSocketManager.shared
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width

    var body: some View {
        ZStack {
            VStack {
                VStack(spacing: screenwidth * 0.08) {

                    if let booking = webSocketManager.currentBooking {
                        CommonSheetTitleView(
                            title: "Completed",
                            isClosed: $webSocketManager.isCompleted
                        )

                        VStack(spacing: screenwidth * 0.02) {
                            CalloutTextView(text: "Your Grand Total")
                            LargeTitleTextView(
                                text:
                                    "LKR \(booking.serviceTotal)"
                            )
                        }

                        //selected services list
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(spacing: 0) {
                                ForEach(
                                    booking.servicesSelected,
                                    id: \.serviceId
                                ) {
                                    selectedService in

                                    CommonListItemView(
                                        title: selectedService.serviceName,
                                        value:
                                            "LKR \(selectedService.serviceCost)"
                                    )

                                }
                            }
                            .padding(.horizontal, screenwidth * 0.05)
                            .frame(maxWidth: .infinity)
                            .background(Color("SecondaryBackgroundColor"))
                            .cornerRadius(
                                booking.servicesSelected.count == 1
                                    ? screenwidth * 0.05
                                    : screenwidth * 0.08
                            )
                            .overlay(
                                RoundedRectangle(
                                    cornerRadius: booking.servicesSelected
                                        .count
                                        == 1
                                        ? screenwidth * 0.05
                                        : screenwidth * 0.08
                                )
                                .stroke(
                                    Color("BorderLineColor"),
                                    lineWidth: 2
                                )
                            )
                        }
                    }

                }
                .padding(.top, screenwidth * 0.08)
                .padding(.horizontal, screenwidth * 0.05)

                Spacer()
            }
            .presentationDetents([.medium])
            .presentationCornerRadius(50)
            .presentationBackground(Color("MainBackgroundColor"))
            .presentationDragIndicator(.hidden)
            .interactiveDismissDisabled(true)
        }
    }
}

#Preview {
    //    BookingPaymentSheetView()
}
