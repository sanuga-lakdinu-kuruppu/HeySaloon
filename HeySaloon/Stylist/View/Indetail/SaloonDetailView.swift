import SwiftUI

struct SaloonDetailView: View {

    var stylist: StylistModel
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: screenwidth * 0.04) {

                SingleLineDetailItemView(
                    icon: "house.fill",
                    text: "From \(stylist.saloonName ?? "")"
                )

                SingleLineDetailItemView(
                    icon: "clock.badge.fill",
                    text:
                        "Open From \(stylist.startTime ?? "") - \(stylist.endTime ?? "")"
                )

                if let address = stylist.address {
                    if let no = address.no, let address1 = address.address1,
                        let address2 = address.address2
                    {
                        SingleLineDetailItemView(
                            icon: "location.circle",
                            text: "\(no), \(address1), \(address2)."
                        )
                    }
                }

                SingleLineDetailItemView(
                    icon: "bag.fill",
                    text: "\(stylist.totalReviewed ?? 0) Jobs Reviewed"
                )

                if let createdAt = stylist.createdAt {
                    SingleLineDetailItemView(
                        icon: "calendar.badge.clock",
                        text:
                            "Since \(SupportManager.shared.convertIOSStringToMyFormatWithoutTime(  createdAt) ?? "")"
                    )
                }

            }
        }
    }
}

#Preview {
    //    SaloonDetailView()
}
