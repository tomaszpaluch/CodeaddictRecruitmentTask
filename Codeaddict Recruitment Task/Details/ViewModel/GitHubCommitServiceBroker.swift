import Foundation
import RxSwift

class GitHubCommitServiceBroker {
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
