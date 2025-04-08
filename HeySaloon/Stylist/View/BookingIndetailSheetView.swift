import SwiftUI

struct BookingIndetailSheetView: View {

    @ObservedObject var commonGround: CommonGround
    @Binding var thisBooking: BookingModel?
    @Binding var isShowBookingIndetailsSheet: Bool
    @Binding var thisStylist: StylistModel
    @Binding var isShowCancelSheet: Bool
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width
    @State var screenHeight: CGFloat = UIScreen.main.bounds.height

    var body: some View {
        ZStack {
            VStack {
                VStack(spacing: screenwidth * 0.08) {

                    CommonSheetTitleView(
                        title:
                            "\(commonGround.userProfile?.firstName ?? "User")'s Appointments",
                        isClosed: $isShowBookingIndetailsSheet
                    )

                    ScrollView(
                        .vertical,
                        showsIndicators: false
                    ) {
                        VStack(spacing: screenwidth * 0.08) {

                            //top part
                            VStack(spacing: screenwidth * 0.04) {

                                //top stylists card view
                                StylistProfileCardView(thisStylist: thisStylist)

                                //direction button
                                Button {

                                } label: {
                                    MainButtonView(
                                        text: "Get Me To This Saloon",
                                        foregroundColor: Color(
                                            "MainBackgroundColor"
                                        ),
                                        backgroundColor: .accent,
                                        isBoarder: false
                                    )
                                }
                            }

                            //bottom cards
                            if let thisBooking = thisBooking {
                                VStack(spacing: screenwidth * 0.04) {
                                    if !thisBooking.selectedServices.isEmpty {

                                        //booking time
                                        VStack(spacing: 0) {
                                            CommonListItemView(
                                                title: "Booking Time",
                                                value: thisBooking.bookingTime
                                            )
                                        }
                                        .padding(
                                            .horizontal,
                                            screenwidth * 0.05
                                        )
                                        .frame(maxWidth: .infinity)
                                        .background(
                                            Color("SecondaryBackgroundColor")
                                        )
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

                                        //Meta data
                                        VStack(spacing: 0) {
                                            CommonListItemView(
                                                title: "Queued at",
                                                value:
                                                    "\(thisBooking.queuedAt) st"
                                            )
                                            CommonListItemView(
                                                title: "Need to wait",
                                                value:
                                                    "\(SupportManager.shared.getTimeDifference(finishTime: thisBooking.serviceAt)) min (until \(SupportManager.shared.getFinishTime(finishTime: thisBooking.serviceAt)))"
                                            )
                                            CommonListItemView(
                                                title: "Service will take",
                                                value:
                                                    "Aprox. \(thisBooking.serviceTime) min"
                                            )
                                        }
                                        .padding(
                                            .horizontal,
                                            screenwidth * 0.05
                                        )
                                        .frame(maxWidth: .infinity)
                                        .background(
                                            Color("SecondaryBackgroundColor")
                                        )
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
                                        ScrollView(
                                            .vertical,
                                            showsIndicators: false
                                        ) {
                                            VStack(spacing: 0) {
                                                ForEach(
                                                    thisBooking.selectedServices
                                                ) {
                                                    selectedService in

                                                    CommonListItemView(
                                                        title: selectedService
                                                            .name,
                                                        value:
                                                            "LKR \(selectedService.price)"
                                                    )

                                                }
                                            }
                                            .padding(
                                                .horizontal,
                                                screenwidth * 0.05
                                            )
                                            .frame(maxWidth: .infinity)
                                            .background(
                                                Color(
                                                    "SecondaryBackgroundColor"
                                                )
                                            )
                                            .cornerRadius(
                                                thisBooking.selectedServices
                                                    .count
                                                    == 1
                                                    ? screenwidth * 0.05
                                                    : screenwidth * 0.08
                                            )
                                            .overlay(
                                                RoundedRectangle(
                                                    cornerRadius: thisBooking
                                                        .selectedServices.count
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
                                                value:
                                                    "LKR \(thisBooking.serviceTotal)"
                                            )
                                        }
                                        .padding(
                                            .horizontal,
                                            screenwidth * 0.05
                                        )
                                        .frame(maxWidth: .infinity)
                                        .background(
                                            Color("SecondaryBackgroundColor")
                                        )
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

                                        //cancel button
                                        Button {
                                            isShowCancelSheet.toggle()
                                        } label: {
                                            MainButtonView(
                                                text: "Cancel the Booking",
                                                foregroundColor: Color.white,
                                                backgroundColor: Color(
                                                    "SecondaryBackgroundColor"
                                                ),
                                                isBoarder: true
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
        }
    }
}

#Preview {
    BookingIndetailPreview()
}

struct BookingIndetailPreview: View {

    @State var thisBooking: BookingModel? = .init(
        bookingId: 43,
        userId: 43,
        stylistId: 43,
        bookingTime: "423",
        queuedAt: 3,
        serviceAt: "34423",
        serviceTime: 31,
        bookingStatus: "",
        selectedServices: [],
        serviceTotal: 332
    )
    @State var isShowBookingIndetailsSheet: Bool = false
    @State var isShowBookingConfirmationSheet: Bool = false
    @State var isShowingServiceSheet: Bool = false
    @State var temp = false
    @State var thisStylists: StylistModel = .init(
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

    var body: some View {
        BookingIndetailSheetView(
            commonGround: CommonGround.shared,
            thisBooking: $thisBooking,
            isShowBookingIndetailsSheet: $isShowBookingIndetailsSheet,
            thisStylist: $thisStylists,
            isShowCancelSheet: $temp
        )
    }
}
