import SwiftUI

struct ServiceDetailItemView: View {

    @Binding var selectedServices: [ServiceModel]
    @Binding var thisService: ServiceModel
    @Binding var grandTotal: Double
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width
    @State var isThisSelected: Bool = false

    var body: some View {
        VStack(spacing: screenwidth * 0.05) {

            HStack {
                VStack(alignment: .leading) {
                    CaptionTextView(text: thisService.name)
                    HStack(spacing: screenwidth * 0.04) {
                        CaptionTextView(
                            text: "LKR \(thisService.price)",
                            fontWeight: .bold
                        )
                        CaptionTextView(
                            text: "\(thisService.minutes) min.",
                            fontWeight: .bold
                        )
                    }

                }

                Spacer()

                Button {
                    if isThisSelected {
                        isThisSelected = false
                        selectedServices.removeAll { $0.id == thisService.id }
                    } else {
                        isThisSelected = true
                        selectedServices.append(thisService)
                    }

                    grandTotal = selectedServices.reduce(0) { $0 + $1.price }
                } label: {
                    Image(
                        systemName: isThisSelected
                            ? "checkmark.circle.fill" : "plus"
                    )
                    .resizable()
                    .frame(
                        width: screenwidth * 0.04, height: screenwidth * 0.04
                    )
                    .foregroundColor(isThisSelected ? .accent : .white)
                }
            }

            CommonDividerView()
        }
        .padding(.top, screenwidth * 0.05)
        .onAppear {
            isThisSelected = selectedServices.contains {
                $0.id == thisService.id
            }
        }
    }

}

#Preview {
    //    ServiceDetailItemView(
    //        service: .init(
    //            name: "Crew Cut",
    //            price: 1200.00,
    //            minutes: 30,
    //            isSelected: false
    //        )
    //    )
}
