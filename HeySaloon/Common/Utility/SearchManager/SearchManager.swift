import MapKit
import SwiftUI

class SearchManager: NSObject, ObservableObject, MKLocalSearchCompleterDelegate
{

    @Published var suggestions: [MKLocalSearchCompletion] = []

    private var localSearchCompleter: MKLocalSearchCompleter =
        MKLocalSearchCompleter()

    override init() {
        super.init()
        localSearchCompleter.delegate = self
        localSearchCompleter.resultTypes = .query
    }

    func search(query: String) {
        suggestions.removeAll()
        localSearchCompleter.queryFragment = query
    }

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        DispatchQueue.main.async {
            self.suggestions = completer.results
        }
    }

    func getLocationCoordinates(
        for suggestion: String,
        completion: @escaping (CLLocationCoordinate2D?) -> Void
    ) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = suggestion

        let search = MKLocalSearch(request: searchRequest)
        search.start { response, _ in
            guard
                let coordinate = response?.mapItems.first?.placemark.location?
                    .coordinate
            else {
                completion(nil)
                return
            }
            completion(coordinate)
        }
    }

}
