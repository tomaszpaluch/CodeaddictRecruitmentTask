import Foundation

struct GitHubSearchResult: Codable {
    let total_count: Int
    let incomplete_results: Bool
    let items: [GitHubSearchItem]
}

struct GitHubSearchItem: Codable {
    let full_name: String
    let owner: GitHubSearchItemOwner
    let stargazers_count: Int
}

struct GitHubSearchItemOwner: Codable {
    let avatar_url: String
}
