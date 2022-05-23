import UIKit
import RxSwift

class DetailsLogic: NSObject {
    var coordinator: MainCoordinator?
    
    private let viewModel: DetailsViewModel
    
    private let restService: GitHubCommitServiceBroker
    private let disposeBag: DisposeBag

    private let cellIdentifier: String
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        
        restService = GitHubCommitServiceBroker()
        disposeBag = DisposeBag()

        cellIdentifier = "cellID"
    }
    
    func setupTableView(_ tableView: UITableView) {
        tableView.register(DetailsTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.setNeedsLayout()
        tableView.layoutIfNeeded()
              
        restService.makeObservable(owner: viewModel.repoAuthorName, repo: viewModel.repoTitle)
            .map { $0.enumerated().prefix(3) }
            .bind(
                to: tableView.rx.items(
                cellIdentifier: cellIdentifier,
                cellType: DetailsTableViewCell.self
            )
        ) { row, item, cell in
            cell.setup(item: item.element, at: item.offset + 1)
        }
        .disposed(by: disposeBag)
    }
    
    func openRepoURL() {
        if let url = viewModel.repoURL {
            UIApplication.shared.open(url)
        }
    }
    
    func shareRepo() {
        let items: [Any?] = [viewModel.repoTitle, viewModel.repoURL]
        coordinator?.showActivityScreen(with: items.compactMap { $0 })
    }
}
