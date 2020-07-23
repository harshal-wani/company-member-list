//
//  APIService.swift
//  CompanyMembersList
//
//  Created by Harshal Wani on 23/07/20.
//  Copyright © 2020 Harshal Wani. All rights reserved.
//

import Foundation

/// API Error mapping
enum APIError: String, Error {
    case invalidURL             = "Invalid url"
    case invalidResponse        = "Invalid response"
    case decodeError            = "Decode error"
    case pageNotFound           = "Requested page not found!"
    case noData                 = "Oops! No words found."
    case noNetwork              = "Internet connection not available!"
    case unknownError           = "Unknown error"
    case serverError            = "Server not found, operation could't not be completed!"

    static func checkErrorCode(_ errorCode: Int = 0) -> APIError {
        switch errorCode {
        case 400:
            return .invalidURL
        case 500:
            return .serverError
        case 404:
            return .pageNotFound
        default:
            return .unknownError
        }
    }
}

protocol APIServiceProtocol {

    func fetch(_ endPoint: EndPoint, completion: @escaping (Result<Data, APIError>) -> Void)
}

final class APIService: APIServiceProtocol {

    func fetch(_ endPoint: EndPoint, completion: @escaping (Result<Data, APIError>) -> Void) {

        guard let url = endPoint.url else {
            return completion(.failure(APIError.invalidURL))
        }
        /// Check is internet available
        if !Utilities.isInternetAvailable() {
            completion(.failure(APIError.noNetwork))
            return
        }
        /// Set URLRequest and type
        var request = URLRequest(url: url)
        request.httpMethod = endPoint.method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if let data = endPoint.data {
            request.httpBody = data
        }

        /// Make request
        let task = URLSession.shared.dataTask(with: request) { (data, response, _) in

            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                completion(.failure(APIError.checkErrorCode((response as? HTTPURLResponse)!.statusCode)))
                return
            }
            guard data != nil else {
                completion(.failure(APIError.noData))
                return
            }
            completion(.success(data!))
        }
        task.resume()
    }
}
