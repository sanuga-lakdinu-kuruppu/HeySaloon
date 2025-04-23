import SwiftUI

struct ImageBackgroundView: View {

    var imageUrl: String
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width
    @State var screenHeight: CGFloat = UIScreen.main.bounds.height

    var body: some View {
        VStack {
            AsyncImage(
                url: URL(
                    string: imageUrl

                )
            ) { Image in
                Image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                RoundedRectangle(cornerRadius: 0)
                    .foregroundColor(.hint)
                    .frame(
                        maxWidth: screenwidth,
                        maxHeight: screenHeight
                    )
                    .ignoresSafeArea()
            }
            .frame(
                width: screenwidth,
                height: screenHeight * 0.5
            )

            Spacer()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ImageBackgroundView(
        imageUrl:
            "https://images.unsplash.com/photo-1629881544138-c45fc917eb81?q=80&w=3088&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    )
}
