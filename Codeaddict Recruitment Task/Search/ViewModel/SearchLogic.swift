import UIKit
import RxSwift
import RxCocoa

class SearchLogic: NSObject {
    var coordinator: MainCoordinator?
    
    var setNewViewModel: (() -> Void)?
    var showActivityIndicator: ((Bool) -> Void)?
    
    var viewModel: SearchViewModel {
        didSet {
            setNewViewModel?()
        }
    }
    
    private let restService: GitHubSearchServiceBrokerable
    private let imageDataSource: ImageDataSourceable
    private let disposeBag: DisposeBag

    private let cellIdentifier: String
    
//    private var searchResults: BehaviorRelay<GitHubSearchResult>?
    
    init(
        viewModel: SearchViewModel,
        restService: GitHubSearchServiceBrokerable,
        imageDataSource: ImageDataSourceable,
        disposeBag: DisposeBag
    ) {
        self.viewModel = viewModel
        self.restService = restService
        self.imageDataSource = imageDataSource
        self.disposeBag = disposeBag
        cellIdentifier = "cellID"
        
//        searchResults = BehaviorRelay(
//            value: GitHubSearchResult(
//                totalCount: 0,
//                incompleteResults: true,
//                items: []
//            )
//        )
    }
    
    func setupSearchBar(_ searchBar: UISearchBar) {
        searchBar.rx.text
            .orEmpty
            .do(onCompleted: {
                print("completed")
            })
            .do(onNext: { [weak self] phrase in
                if !phrase.isEmpty {
                    self?.showActivityIndicator?(true)
                }
            }, afterNext: { [weak self] _ in
                self?.showActivityIndicator?(false)
            })
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMap { [weak self] phrase -> Observable<GitHubSearchResult> in
                if phrase.isEmpty {
                    return .empty()
                } else {
                    return self?.restService.makeObservable(
                        for: phrase
                    ) ?? .empty()
                }
            }
            .subscribe(onNext: { [weak self] result in
                self?.viewModel.searchItems = result.items
                self?.setNewViewModel?()
            }, onError: { [weak self] error in
                self?.coordinator?.showAlert()
            })
            .disposed(by: disposeBag)
    }
    
    func setupTableView(_ tableView: UITableView) {
        tableView.register(
            MainTableViewCell.self,
            forCellReuseIdentifier: cellIdentifier
        )
        
        tableView.delegate = self
        tableView.dataSource = self
//        searchResults?
//            .asObservable()
//            .map { $0.items }
//            .do(onNext: { [weak self] _ in
//                self?.showActivityIndicator?(false)
//            })
//            .bind(
//                to: tableView.rx.items(
//                    cellIdentifier: cellIdentifier,
//                    cellType: MainTableViewCell.self
//                )
//            ) {  [weak self] row, item, cell in
//                let image = self?.imageDataSource.getImage(from: item.owner.avatarURL) { [weak self] image in
//                    DispatchQueue.main.async {
//                        tableView.reloadRows(
//                            at: [IndexPath(row: row, section: 0)],
//                            with: .fade
//                        )
//                        self?.coordinator?.updateDetails(with: image)
//                    }
//                }
//
//                cell.setup(image: image, item: item)
//            }
//            .disposed(by: disposeBag)
    }
}

extension SearchLogic: UITableViewDelegate, UITableViewDataSource {
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
        
        let item = viewModel.searchItems[indexPath.row]
        let image = imageDataSource.getImage(from: item.owner.avatarURL)
        
        coordinator?.showDetails(
            with: .init(
                ownerImage: image,
                item: item
            )
        )
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.searchItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: cellIdentifier,
            for: indexPath
        )
        
        if let cell = cell as? MainTableViewCell {
            let item = viewModel.searchItems[indexPath.row]
            
            let image = imageDataSource.getImage(from: item.owner.avatarURL) { [weak self] image in
                DispatchQueue.main.async {
                    tableView.reloadRows(
                        at: [indexPath],
                        with: .fade
                    )
                    self?.coordinator?.updateDetails(with: image)
                }
            }
            
            cell.setup(image: image, item: item)
        }
        
        return cell
    }
}
