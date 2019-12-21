//
//  UsersViewController.swift
//  PruebaiOSCeiba
//
//  Created by Andrés Carrillo on 19/12/19.
//  Copyright © 2019 Andres Carrillo. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController, UserViewModelDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = UserViewModel()
    let searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        setupTableView()
        setupSearchController()
        loadUsers()
        setupNavbar()
    }
    
    //MARK: UserViewModel Delegate
    func reloadTable() {
        DispatchQueue.main.sync {
            tableView.reloadData()
        }
    }
    
    private func loadUsers () {
        viewModel.getUsers()
    }
    
    private func setupNavbar () {
        self.navigationItem.title = viewModel.navigationTitle
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupTableView () {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: viewModel.cellId)
    }
    
    private func setupSearchController () {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

//MARK: - TableViewDelegate
extension UsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userSelected = !isFiltering ? viewModel.userView[indexPath.row] : viewModel.userViewFiltered[indexPath.row]
        let story = UIStoryboard(name: "Posts", bundle: nil)
        let viewController = story.instantiateViewController(withIdentifier: "PostsViewController") as! PostsViewController
        viewController.viewModel.userView = userSelected
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

//MARK: - TableViewDataSource
extension UsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = !isFiltering ? viewModel.userView.count : viewModel.userViewFiltered.count
        
        if count == 0 {
            tableView.setEmptyMessage(viewModel.emptyListMessage)
        } else {
            tableView.restore()
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(80.0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellId) as! UserCell
        let userView = !isFiltering ? viewModel.userView[indexPath.row] : viewModel.userViewFiltered[indexPath.row]
        cell.configureCell(user: userView)
        return cell
    }
}


// MARK: - Extension of SearchController
extension UsersViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        if let searchText = searchBar.text {
            filterContentForSearchText(searchText)
        }
    }
    
}
