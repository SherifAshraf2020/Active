//
//  NetworkService.swift
//  Active
//
//  Created by Sherif Ashraf Farooq  on 05/05/2026.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol {
    func fetchData<T: Decodable>(urlString: String, type: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    static let shared = NetworkService()
    private init() {}
    
    func fetchData<T: Decodable>(urlString: String, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(urlString)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let decodedData):
                    completion(.success(decodedData))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
