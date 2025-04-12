import SwiftUI

struct MapControlButtonView: View {

    var icon: String
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width

    var body: some View {
        Image(systemName: icon)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(.black)
            .frame(
                width: UIScreen.main.bounds.width * 0.04,
                height: UIScreen.main.bounds.width * 0.04
            )
            .padding(10)
            .background(
                .white,
                in: .rect
            )
            .cornerRadius(screenwidth * 0.02)
    }
}

#Preview {
    MapControlButtonView(icon: "xmark")
}
