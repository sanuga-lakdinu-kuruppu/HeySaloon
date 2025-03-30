import SwiftUI

struct SearchViewTitleView: View {

    @Binding var isShowingSearchSheet: Bool
    @Binding var isShowingSearchResult: Bool

    var body: some View {
        HStack {
            Spacer()
            HeadlineTextView(
                text: isShowingSearchResult
                    ? "Stylists Nearby"
                    : "Find a Stylist"
            )
            Spacer()
            Button {
                if isShowingSearchResult {
                    isShowingSearchResult.toggle()
                } else {
                    isShowingSearchSheet.toggle()
                }
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(Color.white)

            }
        }
    }
}

#Preview {
//    SearchViewTitleView()
}
