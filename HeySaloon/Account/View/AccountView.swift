import SwiftUI

struct AccountView: View {

    @State var userProfile: UserProfileModel? = CommonGround.shared.userProfile
    @State var screenwidth: CGFloat = UIScreen.main.bounds.width
    @State var isShowSignOutSheet: Bool = false

    var body: some View {
        ZStack {
            MainBackgroundView()
            
            //profile view
            ScrollView(.vertical, showsIndicators: false) {
                if let userProfile = userProfile {
                    VStack(spacing: screenwidth * 0.08) {
                        VStack(spacing: screenwidth * 0.02) {
                            
                            //image view
                            AsyncImage(
                                url: URL(
                                    string: userProfile.imageUrl
                                )
                            ) { Image in
                                Image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(Circle())
                            } placeholder: {
                                Circle()
                                    .foregroundColor(.gray)
                            }
                            .frame(
                                width: screenwidth * 0.33,
                                height: screenwidth * 0.33
                            )

                            LargeTitleTextView(
                                text:
                                    "\(userProfile.firstName) \(userProfile.lastName)"
                            )

                            CalloutTextView(text: "Since 22nd of March 2025")
                        }

                        //list view
                        VStack {
                            VStack(spacing: 0) {
                                CommonListItemView(
                                    title: "Messages",
                                    value: "More"
                                )
                                CommonListItemView(
                                    title: "History",
                                    value: "More"
                                )
                                CommonListItemView(
                                    title: "Privacy & Policies",
                                    value: "More"
                                )
                                CommonListItemView(
                                    title: "Updates",
                                    value: "1"
                                )
                                CommonListItemView(
                                    title: "Software Version",
                                    value: "v1.2.33"
                                )

                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, screenwidth * 0.05)
                            .frame(maxWidth: .infinity)
                            .background(Color("SecondaryBackgroundColor"))
                            .cornerRadius(screenwidth * 0.08)
                            .overlay(
                                RoundedRectangle(
                                    cornerRadius: screenwidth * 0.08
                                )
                                .stroke(
                                    Color("BorderLineColor"),
                                    lineWidth: 2
                                )
                            )

                        }

                        //sign out button
                        Button {
                            isShowSignOutSheet.toggle()
                        } label: {
                            MainButtonView(
                                text: "Sign Out",
                                foregroundColor: Color.white,
                                backgroundColor: Color(
                                    "SecondaryBackgroundColor"
                                ),
                                isBoarder: true
                            )
                        }

                        Spacer()
                    }
                    .padding(.top, 32)
                    .padding(.horizontal, screenwidth * 0.05)
                }
            }
        }
        .sheet(isPresented: $isShowSignOutSheet) {
            SignoutConfirmationSheet(
                isShowSignOutSheet: $isShowSignOutSheet
            )
        }
    }
}

#Preview {
    AccountView()
}
