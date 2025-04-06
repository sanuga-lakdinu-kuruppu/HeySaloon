import SwiftUI

struct BookingConfirmatinSheetView: View {

    @ObservedObject var commonGround: CommonGround
    @Binding var isShowBookingConfirmationSheet: Bool
    @Binding var grandTotal: Double
    @Binding var selectedServices: [ServiceModel]
    @Binding var queuedAt: Int
    @Binding var finishTime: String
    @Binding var serviceTime: Int
    @Binding var stylist: StylistModel
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width
    @State var isLoading: Bool = false
    @State var alertMessage: String = ""
    @State var isShowAlert: Bool = false
    @Binding var createdBooking: BookingModel?

    var body: some View {
        ZStack {
            VStack {
                VStack(spacing: screenwidth * 0.08) {

                    CommonSheetTitleView(
                        title: "Booking Confirmation",
                        isClosed: $isShowBookingConfirmationSheet
                    )

                    VStack(spacing: screenwidth * 0.04) {
                        if !selectedServices.isEmpty {

                            //Meta data
                            VStack(spacing: 0) {
                                CommonListItemView(
                                    title: "Queued at",
                                    value: "\(queuedAt) st"
                                )
                                CommonListItemView(
                                    title: "Need to wait",
                                    value:
                                        "\(SupportManager.shared.getTimeDifference(finishTime: finishTime)) min (until \(SupportManager.shared.getFinishTime(finishTime: finishTime)))"
                                )
                                CommonListItemView(
                                    title: "Service will take",
                                    value: "Aprox. \(serviceTime) min"
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
                                    ForEach(selectedServices) {
                                        selectedService in

                                        CommonListItemView(
                                            title: selectedService.name,
                                            value:
                                                "LKR \(selectedService.price)"
                                        )

                                    }
                                }
                                .padding(.horizontal, screenwidth * 0.05)
                                .frame(maxWidth: .infinity)
                                .background(Color("SecondaryBackgroundColor"))
                                .cornerRadius(
                                    selectedServices.count == 1
                                        ? screenwidth * 0.05
                                        : screenwidth * 0.08
                                )
                                .overlay(
                                    RoundedRectangle(
                                        cornerRadius: selectedServices.count
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
                                    value: "LKR \(grandTotal)"
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
                                    "No selected services found"
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
            createdBooking = try await StylistViewModel.shared.createBooking(
                stylist: stylist,
                selectedServices: selectedServices
            )
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
