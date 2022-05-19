import UIKit

class SearchViewController: UIViewController {
    private let logic: SearchLogic
    private let searchBar: UISearchBar
    private let tableView: UITableView
    
    init(viewModel: SearchViewModel) {
        logic = SearchLogic(viewModel: viewModel)
        searchBar = UISearchBar()
        tableView = UITableView()
        
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .systemBackground
        navigationItem.title = viewModel.navigationItemTitle
        
        searchBar.delegate = logic
        searchBar.searchBarStyle = .minimal
        searchBar.sizeToFit()

        tableView.rowHeight = 100
        tableView.separatorStyle = .none
        tableView.tableHeaderView = searchBar
        logic.setupTableView(tableView)
        
        view.addSubview(tableView)

        setupSearchBarConstrainta()
        setupTableViewConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.sizeToFit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSearchBarConstrainta() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false

        if let view = tableView.tableHeaderView {
            searchBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            searchBar.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
        
        searchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        searchBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
    }
    
    private func setupTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}
