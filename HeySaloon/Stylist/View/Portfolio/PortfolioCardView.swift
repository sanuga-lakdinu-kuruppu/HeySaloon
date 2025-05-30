import SwiftUI

struct PortfolioCardView: View {

    var portfolio: PortfolioModel
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width
    @State var screenHeight: CGFloat = UIScreen.main.bounds.height

    var body: some View {
        ZStack {

            //first layer image
            AsyncImage(
                url: URL(string: portfolio.imageUrl ?? "")
            ) { Image in
                Image
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: (screenwidth * 0.86) / 2,
                        height: screenwidth * 0.6
                    )
                    .clipShape(
                        RoundedRectangle(
                            cornerRadius: screenwidth * 0.06
                        )
                    )
                    .clipped()
            } placeholder: {
                ProgressView()
                    .foregroundColor(.white)
                    .frame(
                        width: (screenwidth * 0.86) / 2,
                        height: screenwidth * 0.6
                    )
            }

            //second layer with details
            VStack {

                HStack {
                    CaptionTextView(
                        text: "Likes (\(portfolio.likes ?? 0))",
                        fontWeight: .bold
                    )
                    Spacer()
                    Button {
                    } label: {
                        CommonIconView(
                            icon: portfolio.isClientLiked ?? false
                                ? "hand.thumbsup.fill" : "hand.thumbsup",
                            width: screenwidth * 0.04,
                            height: screenwidth * 0.04
                        )
                    }
                }

                Spacer()

                HStack {
                    CaptionTextView(
                        text: "\(portfolio.name ?? "")",
                        fontWeight: .bold
                    )
                    Spacer()
                }

            }
            .padding(screenwidth * 0.04)
            .frame(
                width: (screenwidth * 0.86) / 2,
                height: screenwidth * 0.6
            )
        }
    }
}

#Preview {
    //    PortfolioCardView()
}
