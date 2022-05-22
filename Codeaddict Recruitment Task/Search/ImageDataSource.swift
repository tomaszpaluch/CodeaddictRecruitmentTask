import Foundation
import UIKit

class ImageDataSource {
    var images: [String : UIImage]
    var dates: [Date : String]
    
    init() {
        images = [:]
        dates = [:]
    }
    
    func getImage(
        from path: String,
        completion: ((UIImage?) -> Void)? = nil
    ) -> UIImage? {
        if let image = images[path] {
            return image
        } else if let url = URL(string: path) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: request) { [weak self] data, response, error -> Void in
                if let dataResponse = data, let image = UIImage(data: dataResponse) {
                    self?.images[path] = image
                    self?.dates[Date()] = path
                    
                    completion?(image)
                }
            }.resume()
            
            return nil
        } else {
            return nil
        }
    }
}
