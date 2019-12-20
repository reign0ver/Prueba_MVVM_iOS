//
//  PostsViewController.swift
//  PruebaiOSCeiba
//
//  Created by Andrés Carrillo on 19/12/19.
//  Copyright © 2019 Andres Carrillo. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavbar()
    }
    
    //Pendiente refactor esta función
    private func setupNavbar () {
        self.navigationItem.title = "Leanne Graham"
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }

}
