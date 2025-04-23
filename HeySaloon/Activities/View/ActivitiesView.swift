import SwiftUI

struct ActivitiesView: View {

    @State var screenwidth: CGFloat = UIScreen.main.bounds.width

    var body: some View {
        ZStack {
            MainBackgroundView()

            VStack(spacing: screenwidth * 0.08) {
                HStack {
                    LargeTitleTextView(
                        text:
                            "Activities"
                    )
                    Spacer()
                }

                VStack {

                    VStack {

                    }

                }
                Spacer()
            }
            .padding(.top, 32)
            .padding(.horizontal, screenwidth * 0.05)
        }
    }
}

#Preview {
    ActivitiesView()
}
