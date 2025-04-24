import MapKit
import SwiftUI

struct MapInstructionView: View {

    @ObservedObject var commonGround: CommonGround
    @Environment(\.dismiss) var dismiss
    @Binding var steps: [MKRoute.Step]
    @Binding var currentStepIndex: Int
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width
    @State var screenHeight: CGFloat = UIScreen.main.bounds.height

    var body: some View {
        VStack {

            //top current step
            VStack {
                Spacer()

                HStack {
                    Image(
                        systemName: SupportManager.shared.getIcon(
                            instruction: steps.count > 0
                                ? steps[currentStepIndex]
                                    .instructions : ""
                        )
                    )
                    .padding(.trailing)
                    VStack(alignment: .leading) {
                        CalloutTextView(
                            text:
                                "\(steps.count > 0 ? steps[currentStepIndex].instructions : "") in \( steps.count > 0 ? steps[currentStepIndex].distance : 0.0)"
                        )

                    }
                    Spacer()

                    //button list
                    HStack(spacing: screenwidth * 0.02) {

                        //next button
                        if currentStepIndex != 0 {
                            Button {
                                currentStepIndex =
                                    currentStepIndex > 0
                                    ? currentStepIndex - 1 : 0
                            } label: {
                                CommonIconView(
                                    icon: "chevron.backward.circle.fill",
                                    width: screenwidth * 0.08,
                                    height: screenwidth * 0.08
                                )

                            }
                        }

                        //back button
                        if currentStepIndex != steps.count - 1 {
                            Button {
                                currentStepIndex =
                                    currentStepIndex < steps.count - 1
                                    ? currentStepIndex + 1 : steps.count - 1
                            } label: {
                                CommonIconView(
                                    icon: "chevron.forward.circle.fill",
                                    width: screenwidth * 0.08,
                                    height: screenwidth * 0.08
                                )
                            }
                        }

                    }
                    .padding(.leading, screenwidth * 0.02)
                }

            }
            .padding(.bottom, screenwidth * 0.06)
            .padding(.horizontal, screenwidth * 0.05)
            .frame(width: screenwidth, height: screenHeight * 0.2)
            .background(Color("MainBackgroundColor"))

            Spacer()

            //bottom list of all steps
            VStack {
                VStack(spacing: screenwidth * 0.08) {

                    //end route button
                    Button {
                        dismiss()
                    } label: {
                        MainButtonView(
                            text: "End the Route",
                            foregroundColor: Color.black,
                            backgroundColor: Color.white,
                            isBoarder: false
                        )
                    }

                    //list of instructions
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 0) {
                            ForEach(steps, id: \.description) { step in
                                StepItemView(
                                    icon: SupportManager.shared.getIcon(
                                        instruction: step.instructions
                                    ),
                                    instructions: step.instructions,
                                    distance: "\(step.distance)"
                                )

                            }
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, screenwidth * 0.05)
                        .frame(maxWidth: .infinity)
                        .background(Color("SecondaryBackgroundColor"))
                        .cornerRadius(
                            steps.count == 1
                                ? screenwidth * 0.05 : screenwidth * 0.08
                        )
                        .overlay(
                            RoundedRectangle(
                                cornerRadius: steps.count == 1
                                    ? screenwidth * 0.05
                                    : screenwidth * 0.08
                            )
                            .stroke(
                                Color("BorderLineColor"),
                                lineWidth: 2
                            )
                        )
                    }
                }
                Spacer()
            }
            .padding(.vertical, screenwidth * 0.08)
            .padding(.horizontal, screenwidth * 0.05)
            .frame(width: screenwidth, height: screenHeight * 0.35)
            .background(Color("MainBackgroundColor"))
            .clipShape(
                .rect(
                    topLeadingRadius: 50,
                    bottomLeadingRadius: 0,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: 50
                )
            )
        }
        .ignoresSafeArea()
    }
}

#Preview {
    //    MapInstructionView()
}
