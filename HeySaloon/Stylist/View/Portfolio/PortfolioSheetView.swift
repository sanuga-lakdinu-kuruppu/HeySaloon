import SwiftUI

struct PortfolioSheetView: View {

    var stylist: StylistModel?
    @Binding var isShowingPortfolioSheet: Bool
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width
    @State var isLoading: Bool = false
    @State var isShowAlert: Bool = false
    @State var alertMessage: String = ""
    @State var portfolios: [PortfolioModel] = []
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var body: some View {
        ZStack {
            VStack {
                if let stylist = stylist {
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
                                ForEach(portfolios, id: \.portfolioId) {
                                    portfolio in
                                    PortfolioCardView(portfolio: portfolio)
                                }
                            }
                        }

                    }
                    .padding(.top, screenwidth * 0.08)
                    .padding(.horizontal, screenwidth * 0.05)

                    Spacer()
                }

            }

            if isLoading {
                CommonProgressView()
            }
        }
        .onAppear {
            Task {
                isLoading = true
                await getPortfolio(stylistId: stylist?.stylistId ?? "")
                isLoading = false
            }
        }
        .alert(
            alertMessage,
            isPresented: $isShowAlert
        ) {
            Button("OK", role: .cancel) {}
        }
        .presentationDetents([.large])
        .presentationCornerRadius(50)
        .presentationBackground(Color("MainBackgroundColor"))
        .presentationDragIndicator(.hidden)
        .interactiveDismissDisabled(true)
    }

    //to get stylist portfolio
    private func getPortfolio(stylistId: String) async {
        do {
            portfolios =
                try await StylistViewModel.shared
                .getPortfolios(stylistId: stylistId)
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
    //    PortfolioSheetView()
}
