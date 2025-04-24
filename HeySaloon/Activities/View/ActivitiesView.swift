import SwiftUI

struct ActivitiesView: View {

    @State var screenwidth: CGFloat = UIScreen.main.bounds.width
    @State var isLoading: Bool = false
    @State var alertMessage: String = ""
    @State var isShowAlert: Bool = false
    @State var bookings: [BookingModel] = []
    @State var isShowBookingIndetailsSheet: Bool = false
    @State var isShowCancelSheet: Bool = false
    @State var selectedBooking: BookingModel? = nil

    var body: some View {
        ZStack {
            MainBackgroundView()

            VStack(spacing: screenwidth * 0.08) {
                HStack {
                    LargeTitleTextView(
                        text:
                            "Activities"
                    )
                    Spacer()
                }

                //card list
                VStack {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: screenwidth * 0.04) {
                            ForEach(bookings, id: \.bookingId) { booking in
                                Button {
                                    selectedBooking = booking
                                    isShowBookingIndetailsSheet.toggle()
                                } label: {
                                    ActivityCardView(booking: booking)
                                }

                            }
                        }
                    }

                }
                Spacer()
            }
            .padding(.top, 32)
            .padding(.horizontal, screenwidth * 0.05)

            if isLoading {
                CommonProgressView()
            }
        }
        .onAppear {
            Task {
                isLoading = true
                await getBookings()
                isLoading = false
            }
        }
        .alert(
            alertMessage,
            isPresented: $isShowAlert
        ) {
            Button("OK", role: .cancel) {}
        }
        .sheet(isPresented: $isShowBookingIndetailsSheet) {
            BookingIndetailSheetView(
                commonGround: CommonGround.shared,
                isShowBookingIndetailsSheet: $isShowBookingIndetailsSheet,
                isShowCancelSheet: $isShowCancelSheet,
                booking: $selectedBooking
            )
            .sheet(isPresented: $isShowCancelSheet) {
                BookingCancellationSheetView(
                    isShowCancelSheet: $isShowCancelSheet
                )
            }
        }

    }

    private func getBookings() async {
        do {
            bookings =
                try await ActivitiesViewModel.shared
                .getBookingsByClientId()
        } catch NetworkError.notAuthorized {
            CommonGround.shared.logout()
            CommonGround.shared.routes
                .append(
                    Route.mainLogin
                )
        } catch {
            showAlert(
                message:
                    "Sorry!, Something went wrong. Please try again later."
            )
        }
    }

    //to show the alert
    private func showAlert(message: String) {
        alertMessage = message
        isShowAlert = true
    }
}

#Preview {
    ActivitiesView()
}
