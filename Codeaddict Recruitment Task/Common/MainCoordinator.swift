import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }

    func initalizeRoot()
}

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func initalizeRoot() {
        let search = SearchViewController(viewModel:
            .init(
                navigationItemTitle: "Search",
                headerViewLabelText: "Repositories"
            )
        )
        
        search.coordinator = self
        
        navigationController.pushViewController(search, animated: false)
    }
    
    func showDetails(with viewModel: DetailsViewModel) {
        let details = DetailsViewController(viewModel: viewModel)
        
        details.coordinator = self
        
        navigationController.pushViewController(details, animated: true)
    }
    
    func updateDetails(with image: UIImage?) {
        if let controller = navigationController.topViewController as? DetailsViewController {
            controller.update(image: image)
        }
    }
    
    func showActivityScreen(with items: [Any]) {
        let activity = UIActivityViewController(activityItems: items, applicationActivities: nil)
        navigationController.present(activity, animated: true)
    }
}
