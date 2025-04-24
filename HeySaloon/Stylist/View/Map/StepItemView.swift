import SwiftUI

struct StepItemView: View {

    var icon: String
    var instructions: String
    var distance: String
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width

    var body: some View {
        VStack(spacing: screenwidth * 0.05) {

            HStack {
                //instruction
                Image(systemName: icon)
                    .padding(.trailing)
                VStack(alignment: .leading) {
                    CaptionTextView(
                        text: instructions
                    )

                }
                Spacer()

                //value
                VStack(alignment: .leading) {
                    CaptionTextView(
                        text:
                            "in \(distance) m"
                    )
                }
            }

            CommonDividerView()
        }
        .padding(.top, screenwidth * 0.05)
    }
}

#Preview {
    StepItemView(icon: "xmark", instructions: "instruction", distance: "32.324")
}
