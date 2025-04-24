import SwiftUI

struct ServiceDetailItemView: View {

    @Binding var thisService: ServiceModel
    @Binding var booking: BookingModel?
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width
    var isSelected: Bool {
        booking?.servicesSelected.contains(where: {
            $0.serviceId == thisService.serviceId
        }) ?? false
    }

    var body: some View {
        VStack(spacing: screenwidth * 0.05) {

            HStack {
                //service details
                VStack(alignment: .leading) {
                    CaptionTextView(text: thisService.serviceName)
                    HStack(spacing: screenwidth * 0.04) {
                        CaptionTextView(
                            text: "LKR \(thisService.serviceCost)",
                            fontWeight: .bold
                        )
                        CaptionTextView(
                            text: "\(thisService.serviceWillTake) min.",
                            fontWeight: .bold
                        )
                    }

                }

                Spacer()

                //service add ,remove button
                Button {
                    toggleServiceSelection()
                } label: {
                    Image(
                        systemName: isSelected
                            ? "checkmark.circle.fill" : "plus"
                    )
                    .resizable()
                    .frame(
                        width: screenwidth * 0.04,
                        height: screenwidth * 0.04
                    )
                    .foregroundColor(isSelected ? .accent : .white)
                }
            }

            CommonDividerView()
        }
        .padding(.top, screenwidth * 0.05)
    }

    //change service selection in the booking process
    private func toggleServiceSelection() {
        var currentBooking =
            booking
            ?? BookingModel(
                bookingId: "SAMPLE_BOOKING_ID",
                bookingTime: "SAMPLE_BOOKING_TIME",
                status: "CREATING",
                servicesSelected: [],
                queuedAt: 0,
                serviceWillTake: 0,
                estimatedStarting: "SAMPLE_BOOKING_ESTIMATED_STARTING",
                serviceTotal: 0.0,
                stylist: .init(stylistId: "fjldska")
            )

        if isSelected {
            currentBooking.servicesSelected.removeAll {
                $0.serviceId == thisService.serviceId
            }
        } else {
            currentBooking.servicesSelected.append(thisService)
        }

        currentBooking.serviceTotal = currentBooking.servicesSelected.reduce(0)
        { $0 + $1.serviceCost }
        currentBooking.serviceWillTake = currentBooking.servicesSelected.reduce(
            0
        ) { $0 + $1.serviceWillTake }
        booking = currentBooking
    }

}

#Preview {
    //    ServiceDetailItemView(
    //        service: .init(
    //            name: "Crew Cut",
    //            price: 1200.00,
    //            minutes: 30,
    //            isSelected: false
    //        )
    //    )
}
