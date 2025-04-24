import XCTest

@testable import HeySaloon

class HeySaloonTests: XCTestCase {

    let jwtToken =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjbGllbnRJZCI6Ijg5Zjk3Yzg5LTk0NjUtNGQyMC1hZTk3LWY4NzY3YmI0MzZlYiIsInN0eWxpc3RJZCI6ImFhZDJlMjRiLTM2Y2EtNDE4Mi1hYTI0LWUwZDY4ZWZmYWM4YSIsInJvbGUiOiJTVFlMSVNUIiwiaWF0IjoxNzQ0NjE2ODk1LCJleHAiOjE3NDQ2MTc3OTV9.HNN9vm23-8ENyosY25r41VaZblncYiqWjGMNsO-QOQY"

    //Test for testing decoding valid jwt token
    func testDecodeValidJWTToken() async throws {
        let result = SupportManager.shared.decodeJwt(jwtToken: jwtToken)
        XCTAssertEqual(
            result?["clientId"] as? String,
            "89f97c89-9465-4d20-ae97-f8767bb436eb"
        )
        XCTAssertEqual(
            result?["stylistId"] as? String,
            "aad2e24b-36ca-4182-aa24-e0d68effac8a"
        )
        XCTAssertEqual(
            result?["role"] as? String,
            "STYLIST"
        )
    }

    //Test for testing decoding invalid jwt token
    func testDecodeInvalidJWTToken() async throws {
        let result = SupportManager.shared.decodeJwt(jwtToken: jwtToken)
        XCTAssertNotEqual(
            result?["clientId"] as? String,
            "INVALID_CLIENTID"
        )
        XCTAssertNotEqual(
            result?["stylistId"] as? String,
            "INVALID_STYLISTID"
        )
        XCTAssertNotEqual(
            result?["role"] as? String,
            "INVALID_ROLE"
        )
    }

    //Test for testing getting new access token with refresh token
    func testGetRefreshToken() async throws {
        do {
            try await SupportManager.shared.getNewRefreshToken()
        } catch {
            XCTFail("getting new access token failed: \(error)")
        }
    }

    //Test for testing getting expected time format with UTC format
    func testGetFinishTime() async throws {
        let input = "2024-08-25T14:45:00Z"
        let expected = "20:15"
        let result = SupportManager.shared.getFinishTime(finishTime: input)
        XCTAssertEqual(result, expected)
    }

    //Test for testing calculating next position for the stylist queue with existing queue value
    func testCalculateNextPositionWithCorrectValue() async throws {
        let stylist = StylistModel(
            stylistId: "jfsdlkajfaklsj",
            firstName: "Sample firstname",
            lastName: "Sample lastname",
            profileUrl: "",
            thumbnailUrl: "",
            totalQueued: 5
        )
        let position = StylistViewModel.shared.calculateNextPosition(
            stylist: stylist
        )
        XCTAssertEqual(position, 6)
    }

    //Test for testing calculating next position for the stylist queue with no existing queue value
    func testCalculateNextPositionWithInCorrectValue() async throws {
        let stylist = StylistModel(
            stylistId: "jfsdlkajfaklsj",
            firstName: "Sample firstname",
            lastName: "Sample lastname",
            profileUrl: "",
            thumbnailUrl: ""
        )
        let position = StylistViewModel.shared.calculateNextPosition(
            stylist: stylist
        )
        XCTAssertEqual(position, 1)
    }
}
