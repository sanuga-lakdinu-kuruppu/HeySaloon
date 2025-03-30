import SwiftUI

struct SingleLineDetailItemView: View {

    var icon: String
    var text: String
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width

    var body: some View {
        HStack {
            Image(systemName: icon)
                .frame(width: screenwidth * 0.08, height: screenwidth * 0.08)
                .foregroundColor(.white)

            CaptionTextView(text: text)

            Spacer()
        }
    }
}

#Preview {
    SingleLineDetailItemView(icon: "house.fill", text: "From Sayoonaa Saloon")
}
