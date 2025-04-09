import SwiftUI

struct ArView: View {

    let arModelList: [ArModel] = SupportManager.shared.arModelList
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width
    @State var selectedModel: ArModel? = nil

    var body: some View {
        ZStack {
            //ar view
            ArFaceView(selectedModel: $selectedModel)
                .ignoresSafeArea(edges: .all)

            //selection view
            VStack {
                HeadlineTextView(text: selectedModel?.name ?? "")
                Spacer()
                HStack(spacing: screenwidth * 0.04) {

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: screenwidth * 0.04) {
                            ForEach(arModelList) { model in
                                Button {
                                    selectedModel = model
                                } label: {
                                    HairCutButtonView(model: model)
                                }
                                .disabled(model.isPro)
                            }
                        }
                    }

                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(.white)
                .cornerRadius(screenwidth * 0.06)
            }
            .padding(.horizontal, screenwidth * 0.05)
        }
    }
}

#Preview {
    ArView()
}
