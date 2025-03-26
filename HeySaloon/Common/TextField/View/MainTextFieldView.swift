import SwiftUI

struct MainTextFieldView: View {

    @Binding var input: String
    var hint: String

    var body: some View {
        HStack {
            TextField(
                "", text: $input,
                prompt: Text(hint)
                    .font(.callout)
                    .foregroundColor(Color("HintColor"))
            )
            Spacer()
            if !input.isEmpty {
                Button {
                    input = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color.white)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .foregroundColor(Color.white)
        .background(Color("SecondaryBackgroundColor"))
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(
                    input.isEmpty ? Color("BorderLineColor") : Color.white,
                    lineWidth: 2
                )
        )
    }
}

#Preview {
    PreviewMainTextFieldView()
}

struct PreviewMainTextFieldView: View {
    @State var text: String = ""
    var body: some View {
        MainTextFieldView(input: $text, hint: "Enter text here")
    }
}
