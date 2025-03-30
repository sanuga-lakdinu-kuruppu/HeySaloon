import CoreLocation
import SwiftUI

struct HomeView: View {

    @ObservedObject var commonGround: CommonGround
    let homeViewModel: HomeViewModel = HomeViewModel.shared
    @StateObject private var searchManager = SearchManager()
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width
    @State var searchText: String = ""
    @State var isShowingSearchSheet: Bool = false
    @State var userProfile: UserProfileModel?
    @State var isLoading: Bool = false
    @State var alertMessage: String = ""
    @State var isShowAlert: Bool = false
    @State var favoriteStylists: [StylistModel]?
    @State var nearByStylists: [StylistModel]?
    @State var topRatedStylists: [StylistModel]?
    @State var selectedPlace: String = ""
    @State var searchedStylists: [StylistModel]?
    @State var isShowingSearchResult: Bool = false

    var body: some View {
        ZStack {
            MainBackgroundView()
            VStack {
                //Top profile bar
                UserProfileBarView(userProfile: userProfile)

                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 32) {

                        //Search bar
                        SpecialSearchBarView(
                            searchText: $searchText,
                            hint: "Where is your stylist?",
                            isTapped: $isShowingSearchSheet
                        )
                        .onTapGesture {
                            isShowingSearchSheet = true
                        }

                        //favorites tab
                        if let favoriteStylists = favoriteStylists,
                            !favoriteStylists.isEmpty
                        {
                            FavoriteTabView(
                                userProfile: userProfile,
                                favoriteStylists: favoriteStylists
                            )
                        }

                        //nearby tab
                        if let nearByStylists = nearByStylists,
                            !nearByStylists.isEmpty
                        {
                            NearByTabView(nearByStylists: nearByStylists)
                        }

                        //top rated tab
                        if let topRatedStylists = topRatedStylists,
                            !topRatedStylists.isEmpty
                        {
                            TopRatedTabView(topRatedStylists: topRatedStylists)
                        }

                    }
                }
                .padding(.top, 32)

                Spacer()
            }
            .padding(.top, 32)
            .padding(.horizontal, screenwidth * 0.05)

            if isLoading {
                CommonProgressView()
            }
        }
        .alert(
            alertMessage,
            isPresented: $isShowAlert
        ) {
            Button("OK", role: .cancel) {}
        }
        .onAppear {
            getHomeData()
        }
        .onDisappear {
            commonGround.commingFrom = Route.home
        }
        .onChange(of: commonGround.commingFrom) { newValue in
            if commonGround.commingFrom == Route.stylistIndetail {
                isShowingSearchSheet = true
            }
        }
        .sheet(isPresented: $isShowingSearchSheet) {
            ZStack {
                VStack {
                    VStack(spacing: 32) {

                        //title
                        SearchViewTitleView(
                            isShowingSearchSheet: $isShowingSearchSheet,
                            isShowingSearchResult: $isShowingSearchResult
                        )

                        //search bar
                        if !isShowingSearchResult {
                            CommonSearchBarView(
                                searchText: $searchText,
                                hint: "Where is your stylists?"
                            )
                            .onChange(of: searchText) { newValue in
                                searchManager.search(query: newValue)
                            }
                        }

                        //search results
                        if isShowingSearchResult {
                            //near by stylists
                            if let searchedStylists = searchedStylists,
                                !searchedStylists.isEmpty
                            {
                                ScrollView(.vertical, showsIndicators: false) {
                                    ForEach(searchedStylists, id: \._id) {
                                        stylist in
                                        SearchResultCardView(stylist: stylist)
                                            .onTapGesture {
                                                isShowingSearchSheet = false
                                                commonGround.selectedStylist =
                                                    stylist
                                                commonGround.routes
                                                    .append(
                                                        Route.stylistIndetail
                                                    )
                                            }
                                    }
                                }
                            } else {
                                CaptionTextView(
                                    text:
                                        "No stylists found near by \(selectedPlace)"
                                )
                            }

                        } else {
                            //suggetions
                            VStack {
                                CommonDividerView()

                                SearchItemView(
                                    titleText: "My Location",
                                    subtitleText: ""
                                )
                                .onTapGesture {
                                    selectedPlace = ""
                                    getSearchResults()
                                }

                                ScrollView(.vertical, showsIndicators: false) {
                                    ForEach(
                                        searchManager.suggestions, id: \.title
                                    ) {
                                        suggestion in
                                        SearchItemView(
                                            titleText: suggestion.title,
                                            subtitleText: suggestion.subtitle,
                                            isThisLocation: false
                                        )
                                        .onTapGesture {
                                            selectedPlace = suggestion.title
                                            getSearchResults()
                                        }
                                    }
                                }

                            }

                        }

                    }
                    .padding(.top, 32)
                    .padding(.horizontal, screenwidth * 0.05)

                    Spacer()
                }
                .presentationDetents([.large])
                .presentationCornerRadius(50)
                .presentationBackground(Color("SecondaryBackgroundColor"))
                .presentationDragIndicator(.hidden)
                .interactiveDismissDisabled(true)

                if isLoading {
                    CommonProgressView()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    //to convert current date into required format
    private func getDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d, yyyy"
        let currentDate = Date()
        return formatter.string(from: currentDate)
    }

    //to get home data mainfunction
    private func getHomeData() {
        Task {
            isLoading = true
            await getProfileData()
            await getFavoriteStylists()
            await getNearByStylists()
            await getTopRatedStylists()
            isLoading = false
        }
    }

    //to get the top rated stylists
    private func getTopRatedStylists() async {
        do {
            topRatedStylists =
                try await homeViewModel
                .getTopRatedStylists()
        } catch NetworkError.notAuthorized {
            commonGround.logout()
            commonGround.routes
                .append(
                    Route.mainLogin
                )
        } catch {
            showAlert(
                message:
                    "Sorry!, Something went wrong. Please try again later."
            )
        }
    }

    private func getSearchResults() {
        searchText = selectedPlace
        if selectedPlace.isEmpty {
            //current location
        } else {
            searchManager
                .getLocationCoordinates(
                    for: selectedPlace
                ) { coordinates in
                    if let coordinates = coordinates {
                        Task {
                            isLoading = true
                            await self.getSearchedStylists(
                                lat: coordinates.latitude,
                                log: coordinates.longitude
                            )
                            isLoading = false
                            isShowingSearchResult = true
                        }
                    }
                }
        }

    }

    private func getSearchedStylists(lat: Double, log: Double) async {
        do {
            searchedStylists =
                try await homeViewModel
                .getNearByStylists(
                    lat: lat, log: log)
        } catch NetworkError.notAuthorized {
            commonGround.logout()
            commonGround.routes
                .append(
                    Route.mainLogin
                )
        } catch {
            showAlert(
                message:
                    "Sorry!, Something went wrong. Please try again later."
            )
        }
    }

    //to get the near by stylists
    private func getNearByStylists() async {
        do {
            // need to get the exact location
            nearByStylists =
                try await homeViewModel
                .getNearByStylists(
                    lat: 37.75826042644298, log: -122.43800997698538)
        } catch NetworkError.notAuthorized {
            commonGround.logout()
            commonGround.routes
                .append(
                    Route.mainLogin
                )
        } catch {
            showAlert(
                message:
                    "Sorry!, Something went wrong. Please try again later."
            )
        }
    }

    //to get the users favorites stylists
    private func getFavoriteStylists() async {
        do {
            favoriteStylists =
                try await homeViewModel
                .getFavoriteStylists()
        } catch NetworkError.notAuthorized {
            commonGround.logout()
            commonGround.routes
                .append(
                    Route.mainLogin
                )
        } catch {
            showAlert(
                message:
                    "Sorry!, Something went wrong. Please try again later."
            )
        }
    }

    //to get the basic profile data
    private func getProfileData() async {
        do {
            userProfile =
                try await homeViewModel
                .getUserProfile()
        } catch NetworkError.notAuthorized {
            commonGround.logout()
            commonGround.routes
                .append(
                    Route.mainLogin
                )
        } catch {
            showAlert(
                message:
                    "Sorry!, Something went wrong. Please try again later."
            )
        }
    }

    //to show the alert
    private func showAlert(message: String) {
        alertMessage = message
        isShowAlert = true
    }
}

#Preview {
    HomeView(commonGround: CommonGround.shared)
}
