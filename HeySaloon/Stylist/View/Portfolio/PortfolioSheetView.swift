import SwiftUI

struct PortfolioSheetView: View {

    var stylist: StylistModel
    @Binding var isShowingPortfolioSheet: Bool
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var body: some View {
        VStack {
            VStack(spacing: screenwidth * 0.08) {

                //title
                CommonSheetTitleView(
                    title:
                        "\(stylist.firstName)'s Portfolio",
                    isClosed: $isShowingPortfolioSheet
                )

                //portfolios
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(stylist.portfolio, id: \.id) { item in
                            PortfolioCardView(portfolio: item)
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

#Preview {
    //    PortfolioSheetView()
}
