//
//  MainLogic.swift
//  Codeaddict Recruitment Task
//
//  Created by Tomasz Paluch on 19/05/2022.
//

import UIKit

class SearchLogic: NSObject {
    private let viewModel: SearchViewModel
    private let cellIdentifier: String
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        cellIdentifier = "cellID"
    }
    
    func setupTableView(_ tableView: UITableView) {
        tableView.register(
            MainTableViewCell.self,
            forCellReuseIdentifier: cellIdentifier
        )
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension SearchLogic: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}

extension SearchLogic: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = MainTableViewHeaderView()
        headerView.label.text = viewModel.headerViewLabelText
            
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         46
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        if let cell = cell as? MainTableViewCell {
            cell.setup()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
