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

    //to serach a string (global location search)
    func search(query: String) {
        suggestions.removeAll()
        localSearchCompleter.queryFragment = query
    }

    //any time user change the input query
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        DispatchQueue.main.async {
            self.suggestions = completer.results
        }
    }

    //to get the location coordinates for a particular user selection in the location list
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
