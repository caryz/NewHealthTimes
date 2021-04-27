//
//  APIConfiguration.swift
//  NewHealthTimes
//
//  Created by Cary Zhou on 4/26/21.
//

import Foundation
import Alamofire

// Error Handling
struct APIError: Error {
    let status: Int?
    let errorMsg: String

    static let defaultErrorMessage = "Something went wrong, please try again later."
}

struct ErrorMessage: Codable {
    var status: Int
    var errorMsg: String
}

extension Data {
    var errorMessage: String {
        return (try? JSONDecoder().decode(ErrorMessage.self, from: self).errorMsg) ?? APIError.defaultErrorMessage
    }
}

// API Configuration
public protocol APIConfiguration: URLRequestConvertible {
    var httpMethod: HTTPMethod { get }
    var path: String { get }
    var queryParams: Parameters? { get }
    var httpBody: Parameters? { get }

    func asURLRequest() throws -> URLRequest
}

public extension APIConfiguration {
    var path: String { "https://api.nytimes.com/svc" }
    var httpMethod: HTTPMethod { .get }
    var queryParams: Parameters? { nil }
    var httpBody: Parameters? { nil }

    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: "\(APIConstants.baseURL)/\(path)") else {
            throw APIError(status: nil, errorMsg: "Path not convertible to URL")
        }
        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = httpMethod.rawValue
        return urlRequest
    }
}
