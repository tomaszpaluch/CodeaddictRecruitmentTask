import Foundation
import RxSwift

class RestService<T: Codable> {
    func makeInquiry(
        for request: URLRequest
    ) -> Observable<T> {
        Observable.create { observer in
            let task = URLSession(configuration: .default).dataTask(with: request) { (data,
            response, error) in
                if let dataResponse = data, error == nil {
                    do {
                        let jsonDecoder = JSONDecoder()
                        let responseModel = try jsonDecoder.decode(
                            T.self,
                            from: dataResponse
                        )
                        
                        observer.onNext(responseModel)
                    } catch {
                        observer.onError(error)
                    }
                } else if let error = error {
                    observer.onError(error)
                }
                
                observer.onCompleted()
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}


