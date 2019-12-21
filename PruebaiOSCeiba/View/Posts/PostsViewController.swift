//
//  PostsViewController.swift
//  PruebaiOSCeiba
//
//  Created by Andrés Carrillo on 19/12/19.
//  Copyright © 2019 Andres Carrillo. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController, PostViewModelDelegate {
    
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    let viewModel = PostViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        setupNavbar()
        setupUserInformation()
        loadUserPosts()
        tableView.setupTableView(viewController: self)
        tableView.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: viewModel.cellId)
    }
    
    //MARK: PostViewModel Delegate
    func reloadTable() {
        self.tableView.reloadData()
        self.hideLoading()
    }
    
    private func loadUserPosts () {
        self.showLoading()
        viewModel.getPostsByUser()
    }
    
    private func setupNavbar () {
        navigationItem.title = viewModel.userView?.name
    }
    
    private func setupUserInformation () {
        phoneNumberLabel.text = viewModel.userView?.phoneNumber
        emailLabel.text = viewModel.userView?.email
    }

}

extension PostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.postView.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellId) as! PostCell
        cell.configureCell(viewModel: viewModel, indexPath.row)
        return cell
    }
}
