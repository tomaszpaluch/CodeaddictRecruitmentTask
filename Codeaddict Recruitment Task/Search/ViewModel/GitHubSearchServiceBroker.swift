import Foundation
import RxSwift

class GitHubSearchServiceBroker {
    private let serviceURL: (String) -> URL?
    private let restService: RestService<GitHubSearchResult>
    
    init() {
        serviceURL = { phrase in
            let servicePath = "https://api.github.com/search/repositories"
            if var urlComponents = URLComponents(string: servicePath) {
                urlComponents.queryItems = [
                    URLQueryItem(name: "q", value: phrase),
                    URLQueryItem(name: "order", value: "asc")
                ]
                
                return urlComponents.url
            } else {
                return nil
            }
        }
        
        restService = RestService()
    }
    
    func makeObservable(
        for phrase: String
    ) -> Observable<GitHubSearchResult> {
        if let requestURL = serviceURL(phrase) {
            let request = URLRequest(url: requestURL)
            return restService.makeInquiry(for: request)
        } else {
            return .empty()
        }
    }
}

