import SwiftUI

struct QueueDetailView: View {

    var stylist: StylistModel
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
                            text: "\(stylist.totalQueued) People Queued")
                        CaptionTextView(
                            text:
                                "Wait 20 min (\(getFinishTime(finishTime: stylist.finishedAt)))"
                        )
                    }
                    Spacer()

                    Button {
                        print("View button clicked")
                    } label: {
                        ViewButtonView()
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

    //to convert the time string to the desired format
    func getFinishTime(finishTime: String) -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [
            .withInternetDateTime, .withFractionalSeconds,
        ]

        if let date = formatter.date(from: finishTime) {
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm"
            let timeOnly = timeFormatter.string(from: date)
            return timeOnly
        } else {
            return ""
        }
    }
}

#Preview {
    //    QueueDetailView()
}
