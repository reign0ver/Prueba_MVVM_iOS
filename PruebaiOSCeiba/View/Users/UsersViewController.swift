//
//  UsersViewController.swift
//  PruebaiOSCeiba
//
//  Created by Andrés Carrillo on 19/12/19.
//  Copyright © 2019 Andres Carrillo. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let cellId = "userCell"
    var viewModel: [UserViewModel] = []
    var viewModelFiltered: [UserViewModel] = []
    let searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupSearchController()
        loadUsers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupNavbar()
    }
    
    private func loadUsers () {
        UserRepository().getUsers { (response) in
            switch response {
            case .success(let result):
                let usersResult = result as! [User]
                self.viewModel = usersResult.map {
                    return UserViewModel(user: $0)
                }
                break
            case .failure:
                break
            }
            DispatchQueue.main.sync {
                self.tableView.reloadData()
            }
        }
    }
    
    private func setupNavbar () {
        self.navigationItem.title = "Usuarios"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupTableView () {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: cellId)
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
        let story = UIStoryboard(name: "Posts", bundle: nil)
        let viewController = story.instantiateViewController(withIdentifier: "PostsViewController") as! PostsViewController
        viewController.userViewModel = viewModel[indexPath.row]
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

//MARK: - TableViewDataSource
extension UsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = !isFiltering ? viewModel.count : viewModelFiltered.count
        
        if count == 0 {
            tableView.setEmptyMessage("List is empty")
        } else {
            tableView.restore()
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(80.0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! UserCell
        
        let user = !isFiltering ? viewModel[indexPath.row] : viewModelFiltered[indexPath.row]
        
        cell.nameLabel.text = user.name
        cell.phoneNumberLabel.text = user.phoneNumber
        cell.emailLabel.text = user.email
        
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
