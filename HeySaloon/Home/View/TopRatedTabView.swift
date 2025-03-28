import SwiftUI

struct TopRatedTabView: View {

    var topRatedStylists: [StylistModel]

    var body: some View {
        VStack {
            HStack {
                HeadlineTextView(
                    text:
                        "Top Rated Stylists"
                )
                Spacer()
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(topRatedStylists, id: \._id) {
                        stylist in
                        NearByStylistCardView(
                            stylist: stylist)
                    }
                }
            }

        }
    }
}

#Preview {
    //    TopRatedTabView()
}
