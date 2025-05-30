import SwiftUI

struct FuctionListView: View {

    @ObservedObject var commonGround: CommonGround
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width
    @Binding var isShowingServiceSheet: Bool
    @Binding var isShowingPortfolioSheet: Bool

    var body: some View {
        VStack(spacing: screenwidth * 0.04) {
            HStack {

                Button {
                    commonGround.routes
                        .append(Route.ar)
                } label: {
                    FuctionButtonView(
                        icon: "arkit",
                        text: "Try On"
                    )
                }

                Button {
                    isShowingServiceSheet.toggle()
                } label: {
                    FuctionButtonView(
                        icon: "list.clipboard.fill",
                        text: "Services"
                    )
                }

                Button {
                    isShowingPortfolioSheet.toggle()
                } label: {
                    FuctionButtonView(
                        icon: "folder.fill.badge.person.crop",
                        text: "Portfolio"
                    )
                }

                Button {
                    commonGround.routes
                        .append(Route.direction)
                } label: {
                    FuctionButtonView(
                        icon: "location.fill",
                        text: "Direction"
                    )
                }

                Spacer()

            }

            HStack {

                Button {

                } label: {
                    FuctionButtonView(
                        icon: "person.2.wave.2",
                        text: "Reviews"
                    )
                }

                Button {

                } label: {
                    FuctionButtonView(
                        icon: "square.and.arrow.up.fill",
                        text: "Share"
                    )
                }

                Button {

                } label: {
                    FuctionButtonView(
                        icon: "phone.fill",
                        text: "Call"
                    )
                }

                Spacer()

            }
        }
    }
}

#Preview {
    //    FuctionListView()
}
