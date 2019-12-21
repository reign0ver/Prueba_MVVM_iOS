//
//  UsersControllerHelper.swift
//  PruebaiOSCeiba
//
//  Created by Andrés Carrillo on 20/12/19.
//  Copyright © 2019 Andres Carrillo. All rights reserved.
//

import UIKit

extension UsersViewController {
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    func filterContentForSearchText(_ searchText: String) {
        viewModel.userViewFiltered = viewModel.userView.filter {
            return $0.name.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
}

