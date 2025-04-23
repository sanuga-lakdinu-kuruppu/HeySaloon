import SwiftUI

struct ServiceDetailSheetView: View {

    @Binding var isShowingServiceSheet: Bool
    @Binding var isShowBookingConfirmationSheet: Bool
    @Binding var stylist: StylistModel?
    @Binding var booking: BookingModel?
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width
    let stylistViewModel: StylistViewModel = StylistViewModel.shared

    var body: some View {
        VStack {
            VStack(spacing: screenwidth * 0.08) {

                //title
                CommonSheetTitleView(
                    title: "Our Services",
                    isClosed: $isShowingServiceSheet
                )

                //information
                VStack(spacing: screenwidth * 0.04) {
                    if let services = stylist?.services, !services.isEmpty {
                        //services list
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(spacing: 0) {
                                let servicesBinding = Binding<[ServiceModel]>(
                                    get: { stylist?.services ?? [] },
                                    set: { stylist?.services = $0 }
                                )

                                ForEach(services.indices, id: \.self) { index in
                                    ServiceDetailItemView(
                                        thisService: servicesBinding[index],
                                        booking: $booking
                                    )
                                }
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, screenwidth * 0.05)
                            .frame(maxWidth: .infinity)
                            .background(Color("SecondaryBackgroundColor"))
                            .cornerRadius(
                                services.count == 1
                                    ? screenwidth * 0.05 : screenwidth * 0.08
                            )
                            .overlay(
                                RoundedRectangle(
                                    cornerRadius: services.count == 1
                                        ? screenwidth * 0.05
                                        : screenwidth * 0.08
                                )
                                .stroke(
                                    Color("BorderLineColor"),
                                    lineWidth: 2
                                )
                            )
                        }

                        //join queue button

                        Button {
                            clickJoinQueue()
                        } label: {
                            MainButtonView(
                                text:
                                    "Join the Queue (LKR \(booking?.serviceTotal ?? 0.0))",
                                foregroundColor: Color(
                                    "MainBackgroundColor"
                                ),
                                backgroundColor: .accent,
                                isBoarder: false
                            )
                        }

                    } else {
                        CaptionTextView(
                            text: "No services found"
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

    func clickJoinQueue() {
        booking?.queuedAt = stylistViewModel.calculateNextPosition(
            stylist: stylist
        )
        booking?.bookingTime = SupportManager.shared.getCurrentISOTimeString()
        booking?.estimatedStarting =
            stylist?.queueWillEnd
            ?? SupportManager.shared.getCurrentISOTimeString()
        isShowBookingConfirmationSheet.toggle()
    }
}

#Preview {
    //    ServiceDetailSheetView()
}
