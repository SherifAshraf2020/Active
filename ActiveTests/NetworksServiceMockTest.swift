//
//  NetworksServiceMockTest.swift
//  ActiveTests
//
//  Created by Yomna on 16/05/2026.
//

import XCTest
@testable import Active

final class NetworksServiceMockTest: XCTestCase {

    var mockNetwork: MockNetworkService!

      override func setUp() {

          mockNetwork = MockNetworkService()
      }

      override func tearDown() {

          mockNetwork = nil
      }

      func testFetchDataSuccess() {

          let expectation = expectation(
              description: "Success response"
          )

          mockNetwork.shouldReturnError = false

          mockNetwork.fetchData(
              urlString: "",
              type: MockLeagueResponse.self
          ) { result in

              switch result {

              case .success(let data):

                  XCTAssertEqual(data.success, 1)

              case .failure:

                  XCTFail("Expected success")
              }

              expectation.fulfill()
          }

          waitForExpectations(timeout: 2)
      }

      func testFetchDataFailure() {

          let expectation = expectation(
              description: "Failure response"
          )

          mockNetwork.shouldReturnError = true

          mockNetwork.fetchData(
              urlString: "",
              type: MockLeagueResponse.self
          ) { result in

              switch result {

              case .success:

                  XCTFail("Expected failure")

              case .failure:

                  XCTAssertTrue(true)
              }

              expectation.fulfill()
          }

          waitForExpectations(timeout: 2)
      }
}
