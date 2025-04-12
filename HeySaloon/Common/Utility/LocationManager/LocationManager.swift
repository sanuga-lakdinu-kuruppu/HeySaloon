import MapKit
import SwiftUI

enum DefaultDetails {
    static let defaultLocation = CLLocationCoordinate2D(
        latitude: 7.228148805239604,
        longitude: 80.01536355827066
    )
    static let defaultSpan = MKCoordinateSpan(
        latitudeDelta: 0.01,
        longitudeDelta: 0.01
    )
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {

    var locationManager: CLLocationManager?
    @Published var region: MKCoordinateRegion = MKCoordinateRegion(
        center: DefaultDetails.defaultLocation,
        span: DefaultDetails.defaultSpan
    )

    func checkIfLocationServiceIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
            locationManager!.desiredAccuracy = kCLLocationAccuracyBest
            locationManager!.startUpdatingLocation()
        } else {
            print(
                "Location service is off and need to enable this in the settings"
            )
        }
    }

    func checkLocationAuthorizationStatus() {
        guard let locationManager = locationManager else { return }

        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("location service restricted!")
        case .denied:
            print("location service denied!")
        case .authorizedAlways, .authorizedWhenInUse:
            if let location = locationManager.location {
                region = MKCoordinateRegion(
                    center: location.coordinate,
                    span: DefaultDetails.defaultSpan
                )
            }

        @unknown default:
            break
        }
    }

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let newLocation = locations.last else { return }
        DispatchQueue.main.async {
            self.region.center = newLocation.coordinate
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorizationStatus()
    }

    func getCurrentLocation() -> CLLocationCoordinate2D? {
        return locationManager?.location?.coordinate
    }
    //
    //    func zoomIn() {
    //        region.span.latitudeDelta *= 0.5
    //        region.span.longitudeDelta *= 0.5
    //    }
    //
    //    func zoomOut() {
    //        region.span.latitudeDelta *= 2.0
    //        region.span.longitudeDelta *= 2.0
    //    }
    //
    //    func recenter() {
    //        region.center = (locationManager?.location?.coordinate)!
    //    }
}
