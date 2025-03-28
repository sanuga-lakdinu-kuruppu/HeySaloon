//
//  TestView.swift
//  HeySaloon
//
//  Created by Kuruppuge Sanuga Lakdinu Kuruppu on 2025-03-24.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        Text("Temporary OTP screen")
    }
}

#Preview {
    TestView()
}

//VStack(spacing: 8) {
//    //image
//    AsyncImage(
//        url: URL(
//            string:
//                imageUrl
//        )
//    ) { Image in
//        Image
//            .resizable()
//            .scaledToFill()
//            .frame(
//                maxWidth: .infinity,
//                maxHeight: verticalCardWidth * 0.8
//            )
//            .clipShape(
//                RoundedRectangle(cornerRadius: 24)
//            )
//            .clipped()
//    } placeholder: {
//        RoundedRectangle(cornerRadius: 24)
//            .foregroundColor(.hint)
//            .frame(
//                width: verticalCardWidth - 16,
//                height: verticalCardWidth * 0.8)
//    }
//
//    Spacer()
//
//    CaptionTextView(
//        text: "Open Now",
//        foregroundColor: Color("AccentColor")
//    )
//
//    CaptionTextView(
//        text: "(09:00 - 20:00)",
//        foregroundColor: .hint
//    )
//
//    CalloutTextView(
//        text:
//            "Michael Wix3fafe",
//        foregroundColor: .white
//    )
//    CaptionTextView(
//        text: "From Wix Saloon",
//        foregroundColor: .white
//    )
//
//    HStack {
//        Image(systemName: "person.2.fill")
//            .foregroundColor(.hint)
//        CaptionTextView(
//            text: "08 Until (17:20)",
//            foregroundColor: .hint
//        )
//    }
//
//    Button {
//
//    } label: {
//        Text("Book Now")
//            .font(.caption)
//            .fontWeight(.bold)
//            .foregroundColor(
//                Color("MainBackgroundColor")
//            )
//            .padding(.vertical, 8)
//            .padding(.horizontal, 16)
//            .background(.white)
//            .cornerRadius(50)
//            .accessibilityLabel("")
//            .accessibilityHint("Tap to continue")
//            .accessibilityAddTraits(.isButton)
//    }
//    Spacer()
//}
////                        .padding(16)
//.frame(
//    width: verticalCardWidth,
//    height: 340
//)
//
//.background(.secondaryBackground)
//.cornerRadius(32)
//.overlay(
//    RoundedRectangle(cornerRadius: 32)
//        .stroke(
//            Color("BorderLineColor"),
//            lineWidth: 2
//        )
//)
