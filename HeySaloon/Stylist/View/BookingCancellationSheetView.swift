import SwiftUI

struct BookingCancellationSheetView: View {

    @Binding var isShowCancelSheet: Bool
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width

    var body: some View {
        ZStack {
            VStack {

                VStack(spacing: screenwidth * 0.08) {
                    HStack {
                        HeadlineTextView(text: "Booking Cancellation")
                    }

                    CaptionTextView(
                        text:
                            "By clicking the following “Cancel Booking” button, the booking you have made, will be removed. This process cannot be undo. "
                    )

                    VStack {
                        //no need to cancel button
                        Button {
                            isShowCancelSheet.toggle()
                        } label: {
                            MainButtonView(
                                text: "No Need to Cancel",
                                foregroundColor: Color.black,
                                backgroundColor: Color.white,
                                isBoarder: false
                            )
                        }

                        //cancel button
                        Button {
                        } label: {
                            MainButtonView(
                                text: "Cancel Booking",
                                foregroundColor: Color.white,
                                backgroundColor: Color(
                                    "SecondaryBackgroundColor"
                                ),
                                isBoarder: true
                            )
                        }
                    }

                }
                .padding(.top, screenwidth * 0.08)
                .padding(.horizontal, screenwidth * 0.05)

                Spacer()
            }
            .presentationDetents([.medium])
            .presentationCornerRadius(50)
            .presentationBackground(Color("MainBackgroundColor"))
            .presentationDragIndicator(.hidden)
            .interactiveDismissDisabled(true)
        }
    }
}

#Preview {
    //    BookingCancellationSheetView()
}
