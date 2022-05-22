import UIKit

protocol Coordinator {
//    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func initalizeRoot()
}

class MainCoordinator: Coordinator {
//    var childCoordinators = [Coordinator]()
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
        
        navigationController.pushViewController(details, animated: true)
    }
    
    func updateDetails(with image: UIImage?) {
        if let controller = navigationController.topViewController as? DetailsViewController {
            controller.update(image: image)
        }
    }
}
