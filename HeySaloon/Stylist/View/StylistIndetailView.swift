import SwiftUI

struct StylistIndetailView: View {

    @ObservedObject var commonGround: CommonGround
    var stylist: StylistModel
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width
    @State var screenHeight: CGFloat = UIScreen.main.bounds.height

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
                    FuctionListView()

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
    }
}

#Preview {
    StylistIndetailView(
        commonGround: CommonGround.shared,
        stylist: .init(
            _id: "fds",
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
            finishedAt: "2024-03-28T16:30:00.000Z"
        ))
}
