import SwiftUI

struct CircleIconView: View {

    var icon: String
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width

    var body: some View {
        VStack {
            Image(
                systemName: icon
            )
            .resizable()
            .frame(
                width: screenwidth * 0.06,
                height: screenwidth * 0.06)
        }
        .foregroundColor(Color("MainBackgroundColor"))
        .frame(
            width: screenwidth * 0.12,
            height: screenwidth * 0.12
        )
        .background(.white)
        .cornerRadius(50)
    }
}

#Preview {
    CircleIconView(icon: "xmark")
}
