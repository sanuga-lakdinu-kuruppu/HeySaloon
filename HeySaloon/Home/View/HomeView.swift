import CoreLocation
import SwiftUI

struct HomeView: View {

    @ObservedObject var commonGround: CommonGround
    let homeViewModel: HomeViewModel = HomeViewModel.shared
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

    var body: some View {
        ZStack {
            MainBackgroundView()
            VStack {
                //Top profile bar
                HStack {
                    VStack {
                        HStack {
                            LargeTitleTextView(
                                text:
                                    "Hello, \(userProfile?.firstName ?? "Guest")"
                            )
                            Spacer()
                        }
                        HStack {
                            CalloutTextView(
                                text:
                                    getDateString()
                            )
                            Spacer()
                        }

                    }
                    Spacer()
                    ProfileImageView(
                        url: userProfile?.imageUrl ?? ""

                    )
                }

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
                            VStack {
                                HStack {
                                    HeadlineTextView(
                                        text:
                                            "\(userProfile?.firstName ?? "Guest")'s Favorites"
                                    )

                                    Spacer()
                                    CalloutTextView(
                                        text:
                                            "See more"
                                    )
                                    .onTapGesture {
                                        print("see more clicked")
                                    }
                                }

                                ScrollView(.horizontal, showsIndicators: false)
                                {
                                    HStack(spacing: 16) {
                                        ForEach(favoriteStylists, id: \._id) {
                                            stylist in
                                            FavoritesCardView(
                                                imageUrl: stylist.thumbnailUrl,
                                                stylistName:
                                                    "\(stylist.firstName) \(stylist.lastName)",
                                                saloonName: stylist.saloonName,
                                                rating: stylist.rating,
                                                totalRating: stylist
                                                    .totalRating,
                                                isOpen: stylist.isOpen
                                            )
                                        }
                                    }
                                }
                            }
                        }

                        //nearby tab
                        if let nearByStylists = nearByStylists,
                            !nearByStylists.isEmpty
                        {
                            VStack {
                                HStack {
                                    HeadlineTextView(
                                        text:
                                            "Nearby Stylists"
                                    )

                                    Spacer()
                                    CalloutTextView(
                                        text:
                                            "See more"
                                    )
                                    .onTapGesture {
                                        print("see more clicked")
                                    }
                                }

                                ScrollView(.horizontal, showsIndicators: false)
                                {
                                    HStack(spacing: 16) {
                                        ForEach(nearByStylists, id: \._id) {
                                            stylist in
                                            FavoritesCardView(
                                                imageUrl: stylist.thumbnailUrl,
                                                stylistName:
                                                    "\(stylist.firstName) \(stylist.lastName)",
                                                saloonName: stylist.saloonName,
                                                rating: stylist.rating,
                                                totalRating: stylist
                                                    .totalRating,
                                                isOpen: stylist.isOpen
                                            )
                                        }
                                    }
                                }
                            }
                        }

                        //top rated tab
                        if let topRatedStylists = topRatedStylists,
                            !topRatedStylists.isEmpty
                        {
                            VStack {
                                HStack {
                                    HeadlineTextView(
                                        text:
                                            "Top Rated Stylists"
                                    )
                                    Spacer()
                                }

                                ScrollView(.horizontal, showsIndicators: false)
                                {
                                    HStack(spacing: 16) {
                                        ForEach(topRatedStylists, id: \._id) {
                                            stylist in
                                            NearByStylistCardView(
                                                stylist: stylist)
                                        }
                                    }
                                }

                            }
                        }

                    }
                }
                .padding(.top, 32)

                Spacer()
            }
            .padding(.top, 32)
            .padding(.horizontal, screenwidth * 0.05)

            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
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
        .sheet(isPresented: $isShowingSearchSheet) {
            VStack {
                Text("jkdfsl")
                Spacer()
            }
            .padding(.horizontal, screenwidth * 0.05)
            .presentationDetents([.large])
            .presentationCornerRadius(50)
            .presentationBackground(Color("SecondaryBackgroundColor"))
            .presentationDragIndicator(.hidden)
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

    //to get the near by stylists
    private func getNearByStylists() async {
        do {
            // need to get the exact location
            nearByStylists =
                try await homeViewModel
                .getNearByStylists()
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
