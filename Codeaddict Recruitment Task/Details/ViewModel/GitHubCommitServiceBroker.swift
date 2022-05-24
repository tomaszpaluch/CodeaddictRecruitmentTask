import Foundation
import RxSwift

protocol GitHubCommitServiceBrokerable {
    func makeObservable(owner: String, repo: String) -> Observable<[GitHubCommit]>
}

class GitHubCommitServiceBroker: GitHubCommitServiceBrokerable {
    private let serviceURL: (String, String) -> URL?
    private let restService: RestService<[GitHubCommit]>
    
    init() {
        serviceURL = { owner, repo in
            URL(string: "https://api.github.com/repos/\(owner)/\(repo)/commits")
        }
        
        restService = RestService()
    }
    
    func makeObservable(
        owner: String,
        repo: String
    ) -> Observable<[GitHubCommit]> {
        if let requestURL = serviceURL(owner, repo) {
            let request = URLRequest(url: requestURL)
            return restService.makeInquiry(for: request)
        } else {
            return .empty()
        }
    }
}
