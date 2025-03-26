import SwiftUI

struct OtpInputView: View {

    @State var screenwidth: CGFloat = UIScreen.main.bounds.width
    @Binding var input: String

    var body: some View {
        TextField(
            "", text: $input
        ).padding()
            .frame(
                width: screenwidth * 0.15,
                height: screenwidth * 0.15, alignment: .center
            )
            .foregroundColor(Color.white)
            .background(Color("SecondaryBackgroundColor"))
            .cornerRadius(15)
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(
                        Color("BorderLineColor"),
                        lineWidth: 2
                    )
            )
    }
}

struct OtpInputCombinedView: View {

    @Binding var otp: [String]
    @FocusState var focusedIndex: Int?

    var body: some View {
        HStack {
            ForEach(0..<4, id: \.self) { index in
                OtpInputView(input: $otp[index])
                    .focused($focusedIndex, equals: index)
                    .onChange(of: otp[index]) { value in
                        if otp[index].count > 1 {
                            otp[index] = String(
                                value.prefix(1))
                        }

                        if !otp[index].isEmpty {
                            focusedIndex =
                                (index < 3) ? index + 1 : nil
                        }
                    }
            }
            Spacer()
        }
    }
}

#Preview {
    PreviewOtpInputView()
}

struct PreviewOtpInputView: View {
    @State var temp: String = ""
    var body: some View {
        OtpInputView(input: $temp)
    }
}
