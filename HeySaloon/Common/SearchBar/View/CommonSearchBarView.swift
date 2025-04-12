import SwiftUI

struct CommonSearchBarView: View {

    @Binding var searchText: String
    var hint: String
    var isDisabled: Bool = false

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.hint)
            TextField(
                "",
                text: $searchText,
                prompt: Text(hint)
                    .font(.callout)
                    .foregroundColor(Color("HintColor"))
            )
            .disabled(isDisabled)
            if !searchText.isEmpty && !isDisabled {
                Button {
                    searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.hint)
                }
            } else {
                Image(systemName: "microphone.fill")
                    .foregroundColor(.hint)
            }
        }
        .padding()
        .fontWeight(.semibold)
        .frame(maxWidth: .infinity)
        .foregroundColor(Color("MainBackgroundColor"))
        .background(.white)
        .cornerRadius(15)
    }
}

#Preview {
    //    CommonSearchBarView()
}
