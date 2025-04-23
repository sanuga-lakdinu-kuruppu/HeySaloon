import MapKit
import SwiftUI

struct StylistMapView: View {

    @ObservedObject var commonGround: CommonGround
    @ObservedObject var sharedLocationManager: LocationManager
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width
    @State var screenHeight: CGFloat = UIScreen.main.bounds.height
    @State var isShowingDirectionSheet: Bool = true
    @State var selectecStylist: StylistModel? = CommonGround.shared
        .selectedStylist
    @State var steps: [MKRoute.Step] = []
    @State var currentStepIndex: Int = 0

    var body: some View {
        ZStack {

            //main map view
            MapRouteView(
                locationManager: sharedLocationManager,
                selectecStylist: selectecStylist!,
                steps: $steps
            )
            .ignoresSafeArea()
            .onAppear {
                sharedLocationManager.checkIfLocationServiceIsEnabled()
            }

            MapInstructionView(
                commonGround: commonGround,
                steps: $steps,
                currentStepIndex: $currentStepIndex
            )

        }
    }
}

#Preview {
    StylistMapView(
        commonGround: CommonGround.shared,
        sharedLocationManager: LocationManager()
    )
}
