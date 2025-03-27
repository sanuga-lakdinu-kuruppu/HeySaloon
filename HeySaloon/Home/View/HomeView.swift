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
    @State var favoriteStylists = HomeViewModel.shared.getTemp()

    var body: some View {
        ZStack {
            MainBackgroundView()
            VStack(spacing: 32) {
                HStack {
                    VStack {
                        HStack {
                            LargeTitleTextView(
                                text:
                                    "Hello, \(userProfile?.firstname ?? "Guest")"
                            )
                            Spacer()
                        }
                        HStack {
                            CalloutTextView(
                                text:
                                    "Tuesday, November 12, 2025"
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

                VStack {
                    HStack {
                        HeadlineTextView(text: "Luke's Favorites")

                        Spacer()
                        CalloutTextView(
                            text:
                                "See more"
                        )
                        .onTapGesture {
                            print("sess")
                        }
                    }

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(favoriteStylists) { stylist in
                                FavoritesCardView(
                                    imageUrl: stylist.thumbnailUrl,
                                    stylistName:
                                        "\(stylist.firstname) \(stylist.lastname)",
                                    saloonName: stylist.saloon,
                                    rating: stylist.rating,
                                    totalRating: stylist.totalRating,
                                    isOpen: stylist.isOpen
                                )
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

    private func getHomeData() {
        Task {
            isLoading = true
            await getProfileData()
            isLoading = false
        }
    }

    private func getFavoriteStylists() async {
        //        do {
        //            favoriteStylists =
        //                try await homeViewModel
        //                .getFavoriteStylists()
        //        } catch NetworkError.notAuthorized {
        //            commonGround.logout()
        //            commonGround.routes
        //                .append(
        //                    Route.mainLogin
        //                )
        //        } catch {
        //            showAlert(
        //                message:
        //                    "Sorry!, Something went wrong. Please try again later."
        //            )
        //        }
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
