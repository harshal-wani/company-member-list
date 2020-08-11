//
//  APIServiceError.swift
//  CompanyMembersList
//
//  Created by Harshal Wani on 11/08/20.
//  Copyright © 2020 Harshal Wani. All rights reserved.
//

import Foundation

enum APIError: Error {

    case invalidURL
    case invalidResponse
    case pageNotFound
    case noData
    case noNetwork
    case unknownError
    case serverError
    case decodeError(String)

    var rawValue: String {

        switch self {
        case .invalidURL:
            return "Invalid url"
        case .invalidResponse:
            return "Invalid response"
        case .pageNotFound:
            return "Requested page not found!"
        case .noData:
            return "Oops! No words found."
        case .noNetwork:
            return "Internet connection not available!"
        case .unknownError:
            return "Unknown error"
        case .serverError:
            return "Server not found, operation could't not be completed!"
        case .decodeError(let error):
            return error
        }
    }

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

    static func parseDecodingError(_ error: DecodingError) -> APIError {
        var errorToReport = error.localizedDescription
        switch error {
        case .dataCorrupted(let context):
            errorToReport = context.debugDescription
        case .keyNotFound( _, let context), .typeMismatch(_, let context), .valueNotFound(_, let context):
            errorToReport = context.debugDescription
        @unknown default:
            break
        }
        return APIError.decodeError(errorToReport)
    }
}
