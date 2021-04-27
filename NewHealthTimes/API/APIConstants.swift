//
//  APIConstants.swift
//  NewHealthTimes
//
//  Created by Cary Zhou on 4/26/21.
//

import Foundation

struct APIConstants {
    static let baseURL = "https://api.nytimes.com/svc"

    /// This apiKey is fFor demonstration purposes only. A production-level application would:
    /// 1. Have an authentication endpoint that returns an auth token (apiKey) with expiration
    /// 2. Use said auth token to hit endpoints that require authentication
    static let apiKey = "j5dkKlvy9PrHhA5gLfjMBucdD2BMelVg"
}
