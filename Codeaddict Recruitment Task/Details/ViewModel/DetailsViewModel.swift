import UIKit

struct DetailsViewModel {
    let ownerImage: UIImage?
    
    let repoAuthorName: String
    let starCount: Int
    let repoTitle: String
    let repoURL: URL?
    
    init(ownerImage: UIImage?, item: GitHubSearchItem) {
        self.ownerImage = ownerImage
        
        repoAuthorName = item.owner.login
        starCount = item.stargazersCount
        repoTitle = item.name
        
        repoURL = URL(string: item.htmlURL)
    }
}
