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
    @State var selectedServices: [ServiceModel] = []
    @State var grandTotal: Double = 0.00
    @State var queuedAt: Int = 0
    @State var finishTime: String = ""
    @State var serviceTime: Int = 0
    @State var createdBooking: BookingModel? = nil

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
            QueueDetailView(stylist: stylist)

            //5th layer
            VStack {
                Spacer()
                VStack(spacing: screenwidth * 0.08) {
                    FuctionListView(
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
                serviceTime: $serviceTime
            )
            .sheet(isPresented: $isShowBookingConfirmationSheet) {
                BookingConfirmatinSheetView(
                    commonGround: commonGround,
                    isShowBookingConfirmationSheet:
                        $isShowBookingConfirmationSheet,
                    grandTotal: $grandTotal,
                    selectedServices: $selectedServices,
                    queuedAt: $queuedAt,
                    finishTime: $finishTime,
                    serviceTime: $serviceTime,
                    stylist: $stylist,
                    createdBooking: $createdBooking
                )
                .sheet(isPresented: $isShowBookingIndetailsSheet) {
                    
                }
            }

        }
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

//@State var services: [ServiceModel] = [
//    .init(name: "Crew Cut", price: 1200.00, minutes: 25),
//    .init(name: "Buzz Cut", price: 1300.00, minutes: 30),
//    .init(name: "Beard Trim & Shaping", price: 900.00, minutes: 15),
//]
