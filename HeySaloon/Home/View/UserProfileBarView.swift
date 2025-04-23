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
            Button {
                CommonGround.shared.selectedTab = .account
            } label: {
                ProfileImageView(url: userProfile?.imageUrl ?? "")
            }

        }
    }

}

#Preview {
    UserProfileBarView()
}
