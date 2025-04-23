import SwiftUI

struct UserProfileBarView: View {

    var userProfile: UserProfileModel?

    var body: some View {
        HStack {
            VStack {
                HStack {
                    LargeTitleTextView(
                        text:
                            "Hello, \(userProfile?.firstName.isEmpty == false ? userProfile!.firstName : "Guest")"
                    )

                    Spacer()
                }
                HStack {
                    CalloutTextView(
                        text:
                            SupportManager.shared.getDateString(date: Date())
                    )
                    Spacer()
                }

            }
            Spacer()
            ProfileImageView(
                url: userProfile?.imageUrl ?? ""

            )
            .onTapGesture {
                CommonGround.shared.logout()
                CommonGround.shared.routes
                    .append(
                        Route.mainLogin
                    )
            }
        }
    }

}

#Preview {
    UserProfileBarView()
}
