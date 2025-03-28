import SwiftUI

struct UserProfileBarView: View {

    var userProfile: UserProfileModel?

    var body: some View {
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
    }

    //to convert current date into required format
    private func getDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d, yyyy"
        let currentDate = Date()
        return formatter.string(from: currentDate)
    }
}

#Preview {
    UserProfileBarView()
}
