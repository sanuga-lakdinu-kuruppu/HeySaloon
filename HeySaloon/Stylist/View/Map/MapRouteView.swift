import MapKit
import SwiftUI

struct MapRouteView: UIViewRepresentable {

    @ObservedObject var locationManager: LocationManager
    var selectecStylist: StylistModel
    @Binding var steps: [MKRoute.Step]
    var lastRouteDrawTime: Date? = nil

    let mapView = MKMapView()

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> MKMapView {
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        mapView.showsCompass = true
        mapView.showsScale = true
        mapView.showsTraffic = true
        mapView.showsBuildings = true
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.isRotateEnabled = true
        mapView.isPitchEnabled = true
        mapView.userTrackingMode = .follow
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        let now = Date()

        if let lastTime = context.coordinator.lastRouteDrawTime,
            now.timeIntervalSince(lastTime) < 10
        {
            return
        }

        context.coordinator.lastRouteDrawTime = now

        let from = CLLocationCoordinate2D(
            latitude: 36.74957485440294,
            longitude: -119.44732082211506
        )

        guard from.latitude != 0.0 && from.longitude != 0.0 else {
            print("Invalid source coordinate, skipping route")
            return
        }

        if let lat = selectecStylist.location?.coordinates?.last,
            let lng = selectecStylist.location?.coordinates?.first
        {

            //add 3d view
            let center = from
            let camera = MKMapCamera()
            camera.centerCoordinate = center
            camera.pitch = 60
            camera.altitude = 100
            camera.heading = 0
            uiView.setCamera(camera, animated: true)

            //draw the route
            drawRoute(
                from: from,
                to: CLLocationCoordinate2D(
                    latitude: lat,
                    longitude: lng
                )
            )
        } else {
            print("Coordinates are missing or invalid")
        }

    }

    func drawRoute(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) {
        mapView.removeOverlays(mapView.overlays)

        let sourcePlacemark = MKPlacemark(coordinate: from)
        let destinationPlacemark = MKPlacemark(coordinate: to)

        //start location
        let startAnnotation = MKPointAnnotation()
        startAnnotation.coordinate = from
        startAnnotation.title = "Start Location"
        mapView.addAnnotation(startAnnotation)

        //end location
        let endAnnotation = MKPointAnnotation()
        endAnnotation.coordinate = to
        endAnnotation.title = selectecStylist.saloonName
        mapView.addAnnotation(endAnnotation)

        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: sourcePlacemark)
        request.destination = MKMapItem(placemark: destinationPlacemark)
        request.transportType = .automobile

        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            if let error = error {
                print("Error calculating route: \(error.localizedDescription)")
                return
            }

            guard let route = response?.routes.first else {
                print("No route found.")
                return
            }

            mapView.addOverlay(route.polyline)
            mapView.setVisibleMapRect(
                route.polyline.boundingMapRect,
                edgePadding: UIEdgeInsets(
                    top: 50,
                    left: 50,
                    bottom: 50,
                    right: 50
                ),
                animated: true
            )

            DispatchQueue.main.async {
                let filteredSteps = route.steps.filter {
                    !$0.instructions.trimmingCharacters(
                        in: .whitespacesAndNewlines
                    ).isEmpty
                }
                self.steps = filteredSteps
            }
        }
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapRouteView
        var lastRouteDrawTime: Date?

        init(_ parent: MapRouteView) {
            self.parent = parent
        }

        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay)
            -> MKOverlayRenderer
        {
            if let polyline = overlay as? MKPolyline {
                let renderer = MKPolylineRenderer(polyline: polyline)
                renderer.strokeColor = .systemPink
                renderer.lineWidth = 6
                return renderer
            }
            return MKOverlayRenderer(overlay: overlay)
        }
    }
}
