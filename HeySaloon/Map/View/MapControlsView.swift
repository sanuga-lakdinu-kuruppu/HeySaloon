import SwiftUI

struct MapControlsView: View {

    var sharedLocationManager: LocationManager
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width

    var body: some View {
        VStack {

            HStack {
                Spacer()
                VStack(spacing: screenwidth * 0.04) {

                    //zoom in
                    Button {
                        //                        sharedLocationManager.zoomIn()
                    } label: {
                        MapControlButtonView(icon: "plus.magnifyingglass")
                    }

                    //zoom out
                    Button {
                        //                        sharedLocationManager.zoomOut()
                    } label: {
                        MapControlButtonView(icon: "minus.magnifyingglass")
                    }

                    //current location
                    Button {
                        //                        sharedLocationManager.recenter()
                    } label: {
                        MapControlButtonView(icon: "location.fill")
                    }
                }
            }
            .padding(.top, screenwidth * 0.18)
            Spacer()
        }
        .padding(.horizontal, screenwidth * 0.05)
    }
}

#Preview {
    //    MapControlsView()
}
