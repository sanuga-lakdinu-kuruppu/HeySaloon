import SwiftUI

struct QueueDetailView: View {

    var stylist: StylistModel
    @Binding var createdBooking: BookingModel?
    @Binding var isShowBookingIndetailsSheet: Bool
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width
    @State var screenHeight: CGFloat = UIScreen.main.bounds.height

    var body: some View {
        VStack {
            Spacer()
            VStack {
                HStack(spacing: screenwidth * 0.04) {
                    CircleIconView(icon: "clock.fill")

                    VStack(alignment: .leading, spacing: screenwidth * 0.02) {
                        CaptionTextView(
                            text: "\(stylist.totalQueued) People Queued"
                        )
                        CaptionTextView(
                            text:
                                "Wait \(SupportManager.shared.getTimeDifference(finishTime: stylist.finishedAt)) min (\(SupportManager.shared.getFinishTime(finishTime: stylist.finishedAt)))"
                        )
                    }
                    Spacer()

                    if createdBooking != nil {
                        Button {
                            isShowBookingIndetailsSheet.toggle()
                        } label: {
                            ViewButtonView()
                        }
                    }

                }
                Spacer()
            }
            .padding(.vertical, screenwidth * 0.08)
            .padding(.horizontal, screenwidth * 0.05)
            .frame(width: screenwidth, height: screenHeight * 0.6)
            .background(Color("SecondaryBackgroundColor"))
            .clipShape(
                .rect(
                    topLeadingRadius: 50,
                    bottomLeadingRadius: 0,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: 50
                )
            )
        }
        .ignoresSafeArea()
    }
}

#Preview {
    //    QueueDetailView()
}
