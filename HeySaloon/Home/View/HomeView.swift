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

    var body: some View {
        ZStack {
            MainBackgroundView()
            VStack(spacing: 32) {
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

                SpecialSearchBarView(
                    searchText: $searchText, hint: "Where is your stylist?",
                    isTapped: $isShowingSearchSheet
                )
                .onTapGesture {
                    isShowingSearchSheet = true
                }

                if let favoriteStylists = favoriteStylists {
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

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(favoriteStylists, id: \._id) {
                                    stylist in
                                    FavoritesCardView(
                                        imageUrl: stylist.thumbnailUrl,
                                        stylistName:
                                            "\(stylist.firstName) \(stylist.lastName)",
                                        saloonName: stylist.saloonName,
                                        rating: stylist.rating,
                                        totalRating: stylist.totalRating,
                                        isOpen: stylist.isOpen
                                    )
                                }
                            }
                        }
                    }
                }

                Spacer()
            }
            .padding(.top, 32)
            .padding(.horizontal, screenwidth * 0.05)
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

    private func getDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d, yyyy"
        let currentDate = Date()
        return formatter.string(from: currentDate)
    }

    private func getHomeData() {
        Task {
            isLoading = true
            await getProfileData()
            await getFavoriteStylists()
            isLoading = false
        }
    }

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
