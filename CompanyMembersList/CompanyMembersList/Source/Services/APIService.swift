//
//  APIService.swift
//  CompanyMembersList
//
//  Created by Harshal Wani on 23/07/20.
//  Copyright © 2020 Harshal Wani. All rights reserved.
//

import Foundation

protocol APIServiceProtocol {
    func fetch<T: Decodable>(_ endPoint: EndPoint, _ type: T.Type, completion: @escaping (Result<T, APIError>) -> Void)
}

final class APIService: APIServiceProtocol {

    func fetch<T: Decodable>(_ endPoint: EndPoint, _ type: T.Type, completion: @escaping (Result<T, APIError>) -> Void) {

        guard let url = endPoint.url else {
            return completion(.failure(.invalidURL))
        }

        /// Check is internet available
        if !Utilities.isInternetAvailable() {
            completion(.failure(.noNetwork))
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
                completion(.failure(.noData))
                return
            }
            completion(self.decodeData(data!))
        }
        task.resume()
    }

    /// Generic decode data into model
    /// - Parameter data: Data to parse in model
    private func decodeData<T: Decodable>(_ data: Data) -> Result<T, APIError> {

        do {
            let model = try JSONDecoder().decode(T.self, from: data)
            return .success(model)
        } catch let error {
            if let err = error as? DecodingError {
                return  .failure(APIError.parseDecodingError(err))
            } else {
                return .failure(.unknownError)
            }
        }
    }
}
