import Foundation
import RxSwift

class RestService {
    private let serviceURL: URL!
    
    init() {
        serviceURL = URL(
            string: "https://api.github.com/search/repositories"
        )
    }
    
    func makeInquiry(
        for phrase: String
    ) -> Observable<GitHubSearchResult> {
        if let requestURL = createActualURL(for: phrase) {
            let request = URLRequest(url: requestURL)
            let urlSession = URLSession(configuration: .default)
            
            return Observable.create { observer in
                let task = urlSession.dataTask(with: request) { (data,
                response, error) in
                    if let dataResponse = data, error == nil {
                        do {
                            let jsonDecoder = JSONDecoder()
                            let responseModel = try jsonDecoder.decode(
                                GitHubSearchResult.self,
                                from: dataResponse
                            )
                            
                            observer.onNext(responseModel)
                        } catch {
                            observer.onError(error)
                        }
                    } else {
                        observer.onError(error!)
                    }
                    
                    observer.onCompleted()
                }
                
                task.resume()
                
                return Disposables.create {
                    task.cancel()
                }
            }
        } else {
            return .empty()
        }
    }
    
    private func createActualURL(for phrase: String) -> URL? {
        if let serviceURL = serviceURL, var urlComponents = URLComponents(string: serviceURL.absoluteString) {
            urlComponents.queryItems = [
                URLQueryItem(name: "q", value: phrase),
                URLQueryItem(name: "order", value: "asc")
            ]
            
            return urlComponents.url
        }
        
        return nil
    }
}

