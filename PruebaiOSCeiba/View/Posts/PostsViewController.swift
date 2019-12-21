//
//  PostsViewController.swift
//  PruebaiOSCeiba
//
//  Created by Andrés Carrillo on 19/12/19.
//  Copyright © 2019 Andres Carrillo. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController {
    
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let cellId = "PostCell"
    var userViewModel: UserViewModel?
    var viewModel: [PostViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        setupUserInformation()
        loadUserPosts()
        tableView.setupTableView(viewController: self)
        tableView.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: cellId)
    }
    
    private func loadUserPosts () {
        PostRepository().getPostsById(userId: userViewModel!.userId, completion: { (response) in
            switch response {
            case .success(let result):
                let postsResult = result as! [Post]
                self.viewModel = postsResult.map {
                    return PostViewModel(post: $0)
                }
                break
            case .failure:
                break
            }
            DispatchQueue.main.sync {
                self.tableView.reloadData()
            }
        })
    }
    
    //Pendiente refactor esta función
    private func setupNavbar () {
        navigationItem.title = userViewModel?.name
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func setupUserInformation () {
        phoneNumberLabel.text = userViewModel?.phoneNumber
        emailLabel.text = userViewModel?.email
    }

}

extension PostsViewController: UITableViewDelegate {
    
}

extension PostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! PostCell
        cell.postTitleLabel.text = viewModel[indexPath.row].title
        cell.postBodyLabel.text = viewModel[indexPath.row].text
        return cell
    }
    
    
}
