import SwiftUI

struct BookingConfirmatinSheetView: View {

    @ObservedObject var commonGround: CommonGround
    @Binding var isShowBookingConfirmationSheet: Bool
    @Binding var isShowingServiceSheet: Bool
    @Binding var isShowBookingIndetailsSheet: Bool
    @Binding var booking: BookingModel?
    @Binding var stylist: StylistModel?
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width
    let supportManager: SupportManager = SupportManager.shared
    let stylistViewModel: StylistViewModel = StylistViewModel.shared
    @State var isLoading: Bool = false
    @State var isShowAlert: Bool = false
    @State var alertMessage: String = ""

    var body: some View {
        ZStack {
            VStack {
                VStack(spacing: screenwidth * 0.08) {

                    CommonSheetTitleView(
                        title: "Booking Confirmation",
                        isClosed: $isShowBookingConfirmationSheet
                    )

                    VStack(spacing: screenwidth * 0.04) {
                        if let booking = booking {

                            //Meta data
                            VStack(spacing: 0) {
                                CommonListItemView(
                                    title: "Queued at",
                                    value: "\(booking.queuedAt)"
                                )
                                CommonListItemView(
                                    title: "Need to wait",
                                    value:
                                        "\(supportManager.getTimeDifference(finishTime: booking.estimatedStarting)) min (until \(supportManager.getFinishTime(finishTime: booking.estimatedStarting)))"
                                )
                                CommonListItemView(
                                    title: "Service will take",
                                    value:
                                        "Aprox. \(booking.serviceWillTake) min"
                                )
                            }
                            .padding(.horizontal, screenwidth * 0.05)
                            .frame(maxWidth: .infinity)
                            .background(Color("SecondaryBackgroundColor"))
                            .cornerRadius(screenwidth * 0.08)
                            .overlay(
                                RoundedRectangle(
                                    cornerRadius: screenwidth * 0.08
                                )
                                .stroke(
                                    Color("BorderLineColor"),
                                    lineWidth: 2
                                )
                            )

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

                            //grand total
                            VStack(spacing: 0) {
                                CommonListItemView(
                                    title: "Grand Total",
                                    value: "LKR \(booking.serviceTotal)"
                                )
                            }
                            .padding(.horizontal, screenwidth * 0.05)
                            .frame(maxWidth: .infinity)
                            .background(Color("SecondaryBackgroundColor"))
                            .cornerRadius(screenwidth * 0.05)
                            .overlay(
                                RoundedRectangle(
                                    cornerRadius: screenwidth * 0.05
                                )
                                .stroke(
                                    Color("BorderLineColor"),
                                    lineWidth: 2
                                )
                            )

                            //confirm button
                            Button {
                                Task {
                                    isLoading = true
                                    await createBooking()
                                    isLoading = false
                                }
                            } label: {
                                MainButtonView(
                                    text: "Confirm",
                                    foregroundColor: Color(
                                        "MainBackgroundColor"
                                    ),
                                    backgroundColor: .accent,
                                    isBoarder: false
                                )
                            }
                        } else {
                            CaptionTextView(
                                text:
                                    "No booking found"
                            )
                        }
                    }

                }
                .padding(.top, screenwidth * 0.08)
                .padding(.horizontal, screenwidth * 0.05)

                Spacer()
            }
            .presentationDetents([.large])
            .presentationCornerRadius(50)
            .presentationBackground(Color("MainBackgroundColor"))
            .presentationDragIndicator(.hidden)
            .interactiveDismissDisabled(true)

            if isLoading {
                CommonProgressView()
            }
        }
        .alert(
            alertMessage,
            isPresented: $isShowAlert
        ) {
            Button("OK", role: .cancel) {}
        }
    }

    //to show the alert
    private func showAlert(message: String) {
        alertMessage = message
        isShowAlert = true
    }

    //creation of a booking
    private func createBooking() async {
        do {
            booking = try await stylistViewModel.createBooking(
                stylist: stylist!,
                booking: booking!
            )
            //clearing

            isShowingServiceSheet = false
            isShowBookingIndetailsSheet = true

        } catch NetworkError.notAuthorized {
            commonGround.logout()
            commonGround.routes
                .append(
                    Route.mainLogin
                )
        } catch BookingCreationError.stylistNotFound {
            showAlert(
                message:
                    "This stylist is not available right now!"
            )
        } catch {
            showAlert(
                message:
                    "Sorry!, Something went wrong. Please try again later."
            )
        }
    }
}

//#Preview {
//    BookingConfirmationPreview()
//}
//
//struct BookingConfirmationPreview: View {
//    @State var grandTotal: Double = 0
//    @State var selectedServices: [ServiceModel] = [
//        .init(id: 1, name: "jdwkl", price: 32.32, minutes: 32),
//        .init(id: 1, name: "jdwkl", price: 32.32, minutes: 32),
//        .init(id: 1, name: "jdwkl", price: 32.32, minutes: 32),
//        .init(id: 1, name: "jdwkl", price: 32.32, minutes: 32),
//    ]
//    @State var isShowBookingConfirmationSheet: Bool = true
//    @State var queuedAt: Int = 0
//    @State var finishTime: String = ""
//    @State var serviceTime: Int = 0
//
//    var body: some View {
//        BookingConfirmatinSheetView(
//            isShowBookingConfirmationSheet: $isShowBookingConfirmationSheet,
//            grandTotal: $grandTotal,
//            selectedServices: $selectedServices,
//            queuedAt: $queuedAt,
//            finishTime: $finishTime,
//            serviceTime: $serviceTime
//        )
//    }
//}
