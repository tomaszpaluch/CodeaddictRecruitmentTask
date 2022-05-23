import Foundation

struct GitHubCommit: Codable {
    let commit: GitHubInnerCommit
}

struct GitHubInnerCommit: Codable {
    let author: GitHubCommitAuthor
    let message: String
}

struct GitHubCommitAuthor: Codable {
    let name: String
    let email: String
}
