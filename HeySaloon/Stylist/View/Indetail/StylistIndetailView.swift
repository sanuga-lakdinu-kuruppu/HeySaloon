import SwiftUI

struct StylistIndetailView: View {

    @ObservedObject var commonGround: CommonGround
    var stylistId: String
    let stylistViewModel: StylistViewModel = StylistViewModel.shared
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width
    @State var screenHeight: CGFloat = UIScreen.main.bounds.height
    @State var stylist: StylistModel? = nil
    @State var isShowingServiceSheet: Bool = false
    @State var isShowBookingConfirmationSheet: Bool = false
    @State var isShowBookingIndetailsSheet: Bool = false
    @State var isShowCancelSheet: Bool = false
    @State var isShowingPortfolioSheet: Bool = false
    @State var isLoading: Bool = false
    @State var isShowAlert: Bool = false
    @State var alertMessage: String = ""
    @State var booking: BookingModel? = nil

    var body: some View {
        ZStack {
            MainBackgroundView()
            if let stylist = stylist {
                //1st layer
                ImageBackgroundView(imageUrl: stylist.thumbnailUrl)

                //2nd layer
                GradientColorView()

                //3rd layer
                ProfileDetailsView(stylist: stylist)

                //4th layer
                QueueDetailView(stylist: stylist)

                //5th layer
                VStack {
                    Spacer()
                    VStack(spacing: screenwidth * 0.08) {
                        FuctionListView(
                            commonGround: commonGround,
                            isShowingServiceSheet: $isShowingServiceSheet,
                            isShowingPortfolioSheet: $isShowingPortfolioSheet
                        )

                        SaloonDetailView(stylist: stylist)

                        Spacer()
                    }
                    .padding(.vertical, screenwidth * 0.08)
                    .padding(.horizontal, screenwidth * 0.05)
                    .frame(width: screenwidth, height: screenHeight * 0.48)
                    .background(Color("MainBackgroundColor"))
                    .clipShape(
                        .rect(
                            topLeadingRadius: 50,
                            bottomLeadingRadius: 0,
                            bottomTrailingRadius: 0,
                            topTrailingRadius: 50
                        )
                    )
                }
                .ignoresSafeArea()
            }

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
        .onAppear {
            getStylistIndetailData()
        }
        .onDisappear {
            commonGround.commingFrom = Route.stylistIndetail
        }
        .sheet(isPresented: $isShowingServiceSheet) {
            ServiceDetailSheetView(
                isShowingServiceSheet: $isShowingServiceSheet,
                isShowBookingConfirmationSheet: $isShowBookingConfirmationSheet,
                stylist: $stylist,
                booking: $booking
            )
            .sheet(isPresented: $isShowBookingConfirmationSheet) {
                BookingConfirmatinSheetView(
                    commonGround: commonGround,
                    isShowBookingConfirmationSheet:
                        $isShowBookingConfirmationSheet,
                    isShowingServiceSheet: $isShowingServiceSheet,
                    isShowBookingIndetailsSheet: $isShowBookingIndetailsSheet,
                    booking: $booking,
                    stylist: $stylist,
                )

            }

        }
        .sheet(isPresented: $isShowBookingIndetailsSheet) {
            BookingIndetailSheetView(
                commonGround: commonGround,
                isShowBookingIndetailsSheet: $isShowBookingIndetailsSheet,
                isShowCancelSheet: $isShowCancelSheet,
                booking: $booking
            )
            .sheet(isPresented: $isShowCancelSheet) {
                BookingCancellationSheetView(
                    isShowCancelSheet: $isShowCancelSheet
                )
            }

        }
        .sheet(isPresented: $isShowingPortfolioSheet) {
            PortfolioSheetView(
                stylist: stylist,
                isShowingPortfolioSheet: $isShowingPortfolioSheet
            )
        }
    }

    private func getStylistIndetailData() {
        Task {
            isLoading = true
            await getStylist(stylistId: stylistId)
            isLoading = false
        }
    }

    //to get stylist details
    private func getStylist(stylistId: String) async {
        do {
            stylist =
                try await stylistViewModel
                .getStylist(stylistId: stylistId)
        } catch NetworkError.notAuthorized {
            commonGround.logout()
            commonGround.routes
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

    //    //to get appointment details
    //    private func getBooking() async {
    //        do {
    //            createdBooking =
    //                try await stylistViewModel
    //                .getAppointment(stylist: stylist)
    //        } catch NetworkError.notAuthorized {
    //            commonGround.logout()
    //            commonGround.routes
    //                .append(
    //                    Route.mainLogin
    //                )
    //        } catch {
    //            showAlert(
    //                message:
    //                    "Sorry!, Something went wrong. Please try again later."
    //            )
    //        }
    //    }

    //to show the alert
    private func showAlert(message: String) {
        alertMessage = message
        isShowAlert = true
    }
}

#Preview {
    StylistIndetailView(
        commonGround: CommonGround.shared,
        stylistId: "",
        stylist: .init(
            stylistId: "",
            firstName: "",
            lastName: "",
            profileUrl: "",
            thumbnailUrl: ""
        )
    )
}
