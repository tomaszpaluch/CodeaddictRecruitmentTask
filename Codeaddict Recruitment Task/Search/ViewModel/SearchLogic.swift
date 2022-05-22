import UIKit
import RxSwift
import RxCocoa

class SearchLogic: NSObject {
    var coordinator: MainCoordinator?
    
    private let viewModel: SearchViewModel
    
    private let restService: RestService
    private let imageDataSource: ImageDataSource
    private let disposeBag: DisposeBag

    private let cellIdentifier: String
    
    private var searchResults: BehaviorRelay<GitHubSearchResult>?
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        disposeBag = DisposeBag()
        restService = RestService()
        imageDataSource = ImageDataSource()
        cellIdentifier = "cellID"
        
        searchResults = BehaviorRelay(
            value: GitHubSearchResult(
                total_count: 0,
                incomplete_results: true,
                items: []
            )
        )
    }
    
    func setupSearchBar(_ searchBar: UISearchBar) {
        searchBar.rx.text
            .orEmpty
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .do(onNext: { print($0) })
            .flatMap { [weak self] phrase -> Observable<GitHubSearchResult> in
                if phrase.isEmpty {
                    return .empty()
                } else {
                    return                 self?.restService.makeInquiry(
                        for: phrase
                    ) ?? .empty()
                }
            }
            .subscribe(onNext: { [weak self] result in
                self?.searchResults?.accept(
                    result
                )
            })
            .disposed(by: disposeBag)
    }
    
    func setupTableView(_ tableView: UITableView) {
        tableView.register(
            MainTableViewCell.self,
            forCellReuseIdentifier: cellIdentifier
        )
        
        tableView.delegate = self
        
        searchResults?
            .asObservable()
            .map { $0.items }
            .bind(
                to: tableView.rx.items(
                    cellIdentifier: cellIdentifier,
                    cellType: MainTableViewCell.self
                )
            ) {  [weak self] row, item, cell in
                let image = self?.imageDataSource.getImage(from: item.owner.avatar_url) { [weak self] image in
                    DispatchQueue.main.async {
                        tableView.reloadRows(
                            at: [IndexPath(row: row, section: 0)],
                            with: .fade
                        )
                        self?.coordinator?.updateDetails(with: image)
                    }
                }
                
                cell.setup(image: image, item: item)
            }
            .disposed(by: disposeBag)
    }
}

extension SearchLogic: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = MainTableViewHeaderView()
        headerView.label.text = viewModel.headerViewLabelText
            
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         46
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let item = searchResults?.value.items[indexPath.row] {
            let image = imageDataSource.getImage(from: item.owner.avatar_url)
            
            coordinator?.showDetails(
                with: .init(
                    ownerImage: image,
                    item: item
                )
            )
        }
    }
}
