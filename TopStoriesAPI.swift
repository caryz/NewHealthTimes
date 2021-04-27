//
//  TopStoriesAPI.swift
//  NewHealthTimes
//
//  Created by Cary Zhou on 4/26/21.
//

import Foundation
import Alamofire

struct TopStoriesRoot: Codable {
    let status: String
    let copyright: String
    let section: String
    let lastUpdated: String
    let numResults: Int
    let results: [TopStoriesResult]

    private enum CodingKeys: String, CodingKey {
        case status, copyright, section,
        lastUpdated = "last_updated",
        numResults = "num_results",
        results
    }
}

struct TopStoriesResult: Codable {
    let section: String
    let subsection: String
    let title: String
    let abstract: String
    let url: String
    let byline: String
    let itemType: String
    let publishedDate: String
    let multimedia: [StoryMultimedia]

    private enum CodingKeys: String, CodingKey {
        case section, subsection, title, abstract, url, byline,
             itemType = "item_type",
             publishedDate = "published_date",
             multimedia
    }
}

struct StoryMultimedia: Codable {
    let url: String
    let caption: String
    let copyright: String
}

struct TopStoriesAPI: APIConfiguration {
    var httpMethod: HTTPMethod { .get }

    var path: String { "topstories/v2" }

    var queryParams: Parameters? {
        return ["api-key" : APIConstants.apiKey]
    }
}

extension TopStoriesAPI {
    func get(section: String = "health", completion: ((Result<TopStoriesRoot, APIError>) -> Void)? = nil) {
        let urlString = "\(APIConstants.baseURL)/\(path)/\(section).json"

        AF.request(urlString,
                   method: httpMethod,
                   parameters: queryParams)
            .responseDecodable(of: TopStoriesRoot.self) { response in
                switch response.result {
                case .success(let topStoriesRoot):
                    print(topStoriesRoot)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
