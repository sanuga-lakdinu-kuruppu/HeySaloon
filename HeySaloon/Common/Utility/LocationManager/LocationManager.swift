import CoreLocation
import SwiftUI

class LocationManager {

    static let shared = LocationManager()
    let locationManager = CLLocationManager()

    private init() {}

    func requestWhenInUseAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }

    private func getUserLocation(
        completion: @escaping (CLLocationCoordinate2D?) -> Void
    ) {
        requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
}
