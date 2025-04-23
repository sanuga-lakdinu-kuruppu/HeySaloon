import SwiftUI

struct SpecialSearchBarView: View {

    @Binding var searchText: String
    var hint: String
    @Binding var isTapped: Bool

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.hint)
            CalloutTextView(text: hint, foregroundColor: .hint)
            Spacer()
            Image(systemName: "microphone")
                .foregroundColor(.hint)
        }
        .padding()
        .fontWeight(.semibold)
        .frame(maxWidth: .infinity)
        .foregroundColor(Color.white)
        .background(Color("SecondaryBackgroundColor"))
        .cornerRadius(50)
        .overlay(
            RoundedRectangle(cornerRadius: 50)
                .stroke(
                    Color("BorderLineColor"),
                    lineWidth: 2
                )
        )
        .simultaneousGesture(
            TapGesture().onEnded {
                isTapped = true
            }
        )
    }
}

#Preview {
    //    SpecialSearchBarView()
}
