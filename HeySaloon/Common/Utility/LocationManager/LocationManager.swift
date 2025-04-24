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

    //to check the location service enabled by the user
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

    //to check the location authorization status for the application
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

    //to notify the app whenever user change the location permissions.
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorizationStatus()
    }

    //to get the user's gps location
    func getCurrentLocation() -> CLLocationCoordinate2D? {
        return locationManager?.location?.coordinate
    }
}
