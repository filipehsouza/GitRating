import Foundation
import UIKit

struct GitListModel: Codable {
    
    let totalCount: Int
    let incompleteResults: Bool
    let items: [Item]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}

struct Item: Codable {
    let name: String
    let owner: Owner
    let stargazersCount: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case owner
        case stargazersCount = "stargazers_count"
    }
}

struct Owner: Codable {
    let login: String
    let avatarURL: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
    }
}
