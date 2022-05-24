import UIKit

class SearchViewController: UIViewController {
    var coordinator: MainCoordinator? {
        get { logic.coordinator }
        set { logic.coordinator = newValue }
    }
    
    private let logic: SearchLogic
    private let searchBar: UISearchBar
    private let activityIndicator: UIActivityIndicatorView
    private let tableView: UITableView
    
    init(logic: SearchLogic) {
        self.logic = logic
        
        searchBar = UISearchBar()
        activityIndicator = UIActivityIndicatorView()
        tableView = UITableView()
        
        searchBar.searchBarStyle = .minimal
        searchBar.sizeToFit()
                
        tableView.rowHeight = 100
        tableView.separatorStyle = .none
        tableView.tableHeaderView = searchBar
        
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .systemBackground
        navigationItem.title = logic.viewModel.navigationItemTitle
        
        view.addSubview(tableView)
        tableView.addSubview(activityIndicator)

        setupSearchBarConstraints()
        setupTableViewConstraints()
        setupActivityIndicatorConstraints()

        logic.showActivityIndicator = { [weak self] show in
            DispatchQueue.main.async {
                if show {
                    self?.activityIndicator.startAnimating()
                } else {
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
        
        logic.setupSearchBar(searchBar)
        logic.setupTableView(tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.sizeToFit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSearchBarConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false

        if let view = tableView.tableHeaderView {
            searchBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            searchBar.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
        
        searchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        searchBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
    }
    
    private func setupActivityIndicatorConstraints() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerYAnchor.constraint(equalTo: tableView.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
    }
    
    private func setupTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}
