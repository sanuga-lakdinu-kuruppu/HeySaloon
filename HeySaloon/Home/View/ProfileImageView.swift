import SwiftUI

struct ProfileImageView: View {

    var url: String
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width

    var body: some View {
        AsyncImage(
            url: URL(
                string:
                    url
            )
        ) { Image in
            Image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
        } placeholder: {
            Circle()
                .foregroundColor(.white)
        }
        .frame(
            width: screenwidth * 0.16, height: screenwidth * 0.16)
    }
}

#Preview {
    ProfileImageView(
        url:
            "https://images.steamusercontent.com/ugc/911296978235152360/207DDF4FA102E150CDEA409026DB6B5905F08F84/?imw=5000&imh=5000&ima=fit&impolicy=Letterbox&imcolor=%23000000&letterbox=false"
    )
}
