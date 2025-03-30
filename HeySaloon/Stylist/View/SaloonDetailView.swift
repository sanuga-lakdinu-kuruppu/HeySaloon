import SwiftUI

struct SaloonDetailView: View {

    @State var screenwidth: CGFloat = UIScreen.main.bounds.width

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: screenwidth * 0.04) {

                SingleLineDetailItemView(
                    icon: "house.fill", text: "From Sayoona Saloon")

                SingleLineDetailItemView(
                    icon: "clock.badge.fill",
                    text: "Open From 09:00 - 20:00")

                SingleLineDetailItemView(
                    icon: "location.circle",
                    text: "1.3 Km Away From Rajagiriya")

                SingleLineDetailItemView(
                    icon: "bag.fill", text: "1032 Jobs Completed")

                SingleLineDetailItemView(
                    icon: "calendar.badge.clock",
                    text: "Since 22nd of September 2020")

            }
        }
    }
}

#Preview {
    SaloonDetailView()
}
