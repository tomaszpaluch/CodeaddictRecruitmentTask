import Foundation

struct GitHubSearchResult: Codable {
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
    
    let totalCount: Int
    let incompleteResults: Bool
    let items: [GitHubSearchItem]
}

struct GitHubSearchItem: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case owner
        case htmlURL = "html_url"
        case stargazersCount = "stargazers_count"
    }
    
    let name: String
    let owner: GitHubSearchItemOwner
    let htmlURL: String
    let stargazersCount: Int
}

struct GitHubSearchItemOwner: Codable {
    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
    }
    
    let login: String
    let avatarURL: String
}
