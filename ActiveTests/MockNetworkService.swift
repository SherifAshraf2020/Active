//
//  MockNetworkService.swift
//  ActiveTests
//
//  Created by Yomna on 16/05/2026.
//

import Foundation
@testable import Active
struct MockLeagueResponse: Decodable {

    let success: Int
}

class MockNetworkService: NetworkServiceProtocol {

    var shouldReturnError = false

    func fetchData<T>(
        urlString: String,
        type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) where T : Decodable {

        if shouldReturnError {

            let error = NSError(
                domain: "",
                code: 400
            )

            completion(.failure(error))

        } else {

            let mockResponse = MockLeagueResponse(
                success: 1
            )

            completion(.success(mockResponse as! T))
        }
    }
}
