import SwiftUI

struct CommonSheetTitleView: View {

    var title: String
    @Binding var isClosed: Bool

    var body: some View {
        HStack {
            Spacer()
            HeadlineTextView(text: title)
            Spacer()
            Button {
                isClosed.toggle()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(Color.white)

            }
        }
    }
}

#Preview {
    //    CommonSheetTitleView()
}
