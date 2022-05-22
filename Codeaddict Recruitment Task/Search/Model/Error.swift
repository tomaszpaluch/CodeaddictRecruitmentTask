import Foundation

enum GitHubError: Error {
    case internetConnectionError
    case serviceConnectionError
    case imageLoadingError
}
