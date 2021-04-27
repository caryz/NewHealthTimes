//
//  APIError.swift
//  NewHealthTimes
//
//  Created by Cary Zhou on 4/27/21.
//

import Foundation

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
