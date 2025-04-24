import ARKit
import RealityKit
import SwiftUI

struct ArFaceView: UIViewRepresentable {

    @Binding var selectedModel: ArModel?

    class Coordinator {
        var currentAnchor: AnchorEntity?
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        let faceTrackingConfiguration = ARFaceTrackingConfiguration()
        arView.session.run(faceTrackingConfiguration)

        let anchor = AnchorEntity(.face)
        arView.scene.addAnchor(anchor)

        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {
        guard let selectedModel = selectedModel else { return }

        if let currentAnchor = context.coordinator.currentAnchor {
            currentAnchor.removeFromParent()
        }

        //set hair model into the correct position with x,y,z coordinates
        if let hairModel = try? Entity.load(named: selectedModel.modelName) {
            hairModel.position = SIMD3<Float>(
                selectedModel.xValue,
                selectedModel.yValue,
                selectedModel.zValue
            )

            let newAnchor = AnchorEntity(.face)
            newAnchor.addChild(hairModel)
            uiView.scene.addAnchor(newAnchor)

            context.coordinator.currentAnchor = newAnchor
        }
    }
}

#Preview {
    //    ArFaceView()
}
