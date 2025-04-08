import SwiftUI

struct ServiceDetailSheetView: View {

    @Binding var isShowingServiceSheet: Bool
    @Binding var isShowBookingConfirmationSheet: Bool
    @Binding var grandTotal: Double
    @Binding var stylist: StylistModel
    @Binding var selectedServices: [ServiceModel]
    @Binding var queuedAt: Int
    @Binding var finishTime: String
    @Binding var serviceTime: Int
    @Binding var createdBooking: BookingModel?
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
                    if !stylist.services.isEmpty {
                        //services list
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(spacing: 0) {
                                ForEach($stylist.services) { $service in
                                    ServiceDetailItemView(
                                        selectedServices: $selectedServices,
                                        thisService: $service,
                                        grandTotal: $grandTotal
                                    )
                                }
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, screenwidth * 0.05)
                            .frame(maxWidth: .infinity)
                            .background(Color("SecondaryBackgroundColor"))
                            .cornerRadius(
                                $stylist.services.count == 1
                                    ? screenwidth * 0.05 : screenwidth * 0.08
                            )
                            .overlay(
                                RoundedRectangle(
                                    cornerRadius: $stylist.services.count == 1
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
                        if createdBooking == nil {
                            Button {
                                clickJoinQueue()
                            } label: {
                                MainButtonView(
                                    text: "Join the Queue (LKR \(grandTotal))",
                                    foregroundColor: Color(
                                        "MainBackgroundColor"
                                    ),
                                    backgroundColor: .accent,
                                    isBoarder: false
                                )
                            }
                        }

                    } else {
                        CaptionTextView(
                            text:
                                "No services found"
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

    private func clickJoinQueue() {
        queuedAt =
            stylistViewModel
            .calculateNextPosition(stylist: stylist)
        serviceTime =
            stylistViewModel
            .calculateServiceTime(
                selectedServices: selectedServices
            )
        finishTime = stylist.finishedAt
        isShowBookingConfirmationSheet.toggle()
    }
}

#Preview {
    //    ServiceDetailSheetView()
}
