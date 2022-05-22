import UIKit

struct DetailsViewModel {
    let ownerImage: UIImage?
    
    let repoAuthorName: String
    let starCount: Int
    let repoTitle: String
    
    init(ownerImage: UIImage?, item: GitHubSearchItem) {
        self.ownerImage = ownerImage
        
        repoAuthorName = item.owner.login
        starCount = item.stargazers_count
        repoTitle = item.full_name
    }
}
