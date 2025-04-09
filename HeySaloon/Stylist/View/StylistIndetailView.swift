import SwiftUI

struct StylistIndetailView: View {

    @ObservedObject var commonGround: CommonGround
    @State var stylist: StylistModel
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width
    @State var screenHeight: CGFloat = UIScreen.main.bounds.height
    @State var isShowingServiceSheet: Bool = false
    @State var isShowingPortfolioSheet: Bool = false
    @State var isShowBookingConfirmationSheet: Bool = false
    @State var isShowBookingIndetailsSheet: Bool = false
    @State var isShowCancelSheet: Bool = false
    @State var selectedServices: [ServiceModel] = []
    @State var grandTotal: Double = 0.00
    @State var queuedAt: Int = 0
    @State var finishTime: String = ""
    @State var serviceTime: Int = 0
    @State var createdBooking: BookingModel? = nil
    @State var isLoading: Bool = false
    @State var alertMessage: String = ""
    @State var isShowAlert: Bool = false
    let stylistViewModel: StylistViewModel = StylistViewModel.shared

    var body: some View {
        ZStack {

            //1st layer
            ImageBackgroundView(
                imageUrl:
                    stylist.thumbnailUrl
            )

            //2nd layer
            GradientColorView()

            //3rd layer
            ProfileDetailsView(stylist: stylist)

            //4th layer
            QueueDetailView(
                stylist: stylist,
                createdBooking: $createdBooking,
                isShowBookingIndetailsSheet: $isShowBookingIndetailsSheet
            )

            //5th layer
            VStack {
                Spacer()
                VStack(spacing: screenwidth * 0.08) {
                    FuctionListView(
                        commonGround: commonGround,
                        isShowingServiceSheet: $isShowingServiceSheet,
                        isShowingPortfolioSheet: $isShowingPortfolioSheet
                    )

                    SaloonDetailView()

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
            getAppointment()
        }
        .onDisappear {
            commonGround.commingFrom = Route.stylistIndetail
        }
        .sheet(isPresented: $isShowingServiceSheet) {
            ServiceDetailSheetView(
                isShowingServiceSheet: $isShowingServiceSheet,
                isShowBookingConfirmationSheet: $isShowBookingConfirmationSheet,
                grandTotal: $grandTotal,
                stylist: $stylist,
                selectedServices: $selectedServices,
                queuedAt: $queuedAt,
                finishTime: $finishTime,
                serviceTime: $serviceTime,
                createdBooking: $createdBooking
            )
            .sheet(isPresented: $isShowBookingConfirmationSheet) {
                BookingConfirmatinSheetView(
                    commonGround: commonGround,
                    isShowBookingConfirmationSheet:
                        $isShowBookingConfirmationSheet,
                    isShowBookingIndetailsSheet: $isShowBookingIndetailsSheet,
                    isShowingServiceSheet: $isShowingServiceSheet,
                    grandTotal: $grandTotal,
                    selectedServices: $selectedServices,
                    queuedAt: $queuedAt,
                    finishTime: $finishTime,
                    serviceTime: $serviceTime,
                    stylist: $stylist,
                    createdBooking: $createdBooking
                )

            }

        }
        .sheet(isPresented: $isShowBookingIndetailsSheet) {
            BookingIndetailSheetView(
                commonGround: commonGround,
                thisBooking: $createdBooking,
                isShowBookingIndetailsSheet:
                    $isShowBookingIndetailsSheet,
                thisStylist: $stylist,
                isShowCancelSheet: $isShowCancelSheet
            )
            .sheet(isPresented: $isShowCancelSheet) {
                BookingCancellationSheetView(
                    isShowCancelSheet: $isShowCancelSheet
                )
            }
        }
    }

    private func getAppointment() {
        Task {
            await getBooking()
        }
    }

    //to get appointment details
    private func getBooking() async {
        do {
            createdBooking =
                try await stylistViewModel
                .getAppointment(stylist: stylist)
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

    //to show the alert
    private func showAlert(message: String) {
        alertMessage = message
        isShowAlert = true
    }
}

#Preview {
    StylistIndetailView(
        commonGround: CommonGround.shared,
        stylist: .init(
            _id: "fds",
            stylistId: 432,
            firstName: "jfadls",
            lastName: "kjladfs",
            thumbnailUrl: "fjdalks",
            imageUrl: "fkjadls",
            saloonName: "jfdslake",
            location: .init(coordinates: [3, 3]),
            rating: 432.423,
            totalRating: 23,
            isOpen: true,
            start: "42",
            end: "ffds",
            totalQueued: 22,
            finishedAt: "2025-04-02T6:30:00.000Z",
            services: [
                .init(id: 1, name: "Crew Cut", price: 1200.00, minutes: 25),
                .init(id: 2, name: "Buzz Cut", price: 1300.00, minutes: 30),
                .init(
                    id: 3,
                    name: "Beard Trim & Shaping",
                    price: 900.00,
                    minutes: 15
                ),
            ]
        )
    )
}
