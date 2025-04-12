import SwiftUI

struct CommonIconView: View {

    var icon: String
    var width: CGFloat
    var height: CGFloat
    var foregroundColor: Color = .white

    var body: some View {
        Image(systemName: icon)
            .resizable()
            .foregroundColor(foregroundColor)
            .frame(width: width, height: height)
    }
}

#Preview {
    //    CommonIconView()
}
