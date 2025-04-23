import SwiftUI

struct BookingIndetailSheetView: View {

    @ObservedObject var commonGround: CommonGround
    @Binding var isShowBookingIndetailsSheet: Bool
    @Binding var isShowCancelSheet: Bool
    @Binding var booking: BookingModel?
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width
    @State var screenHeight: CGFloat = UIScreen.main.bounds.height

    var body: some View {
        ZStack {
            VStack {
                VStack(spacing: screenwidth * 0.08) {

                    CommonSheetTitleView(
                        title:
                            "\(commonGround.userProfile?.firstName ?? "User")'s Bookings",
                        isClosed: $isShowBookingIndetailsSheet
                    )

                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: screenwidth * 0.08) {

                            //top part
                            VStack(spacing: screenwidth * 0.04) {

                                //top stylists card view
                                StylistProfileCardView(booking: booking)

                                //direction button
                                Button {
                                    isShowBookingIndetailsSheet.toggle()
                                    commonGround.routes
                                        .append(Route.direction)
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
                            if let booking = booking {
                                VStack(spacing: screenwidth * 0.04) {
                                    if !booking.servicesSelected.isEmpty {

                                        //booking time
                                        VStack(spacing: 0) {
                                            CommonListItemView(
                                                title: "Booking Time",
                                                value: booking.bookingTime
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
                                                    "\(booking.queuedAt) st"
                                            )
                                            CommonListItemView(
                                                title: "Need to wait",
                                                value:
                                                    "\(SupportManager.shared.getTimeDifference(finishTime: booking.estimatedStarting)) min (until \(SupportManager.shared.getFinishTime(finishTime: booking.estimatedStarting)))"
                                            )
                                            CommonListItemView(
                                                title: "Service will take",
                                                value:
                                                    "Aprox. \(booking.serviceWillTake) min"
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
                                                    booking.servicesSelected,
                                                    id: \.serviceId
                                                ) {
                                                    selectedService in

                                                    CommonListItemView(
                                                        title: selectedService
                                                            .serviceName,
                                                        value:
                                                            "LKR \(selectedService.serviceCost)"
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
                                                booking.servicesSelected
                                                    .count
                                                    == 1
                                                    ? screenwidth * 0.05
                                                    : screenwidth * 0.08
                                            )
                                            .overlay(
                                                RoundedRectangle(
                                                    cornerRadius: booking
                                                        .servicesSelected.count
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
                                                    "LKR \(booking.serviceTotal)"
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
    //    BookingIndetailPreview()
}
