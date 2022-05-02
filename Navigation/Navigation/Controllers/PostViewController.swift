//
//  PostViewController.swift
//  Navigation
//
//  Created by Денис Штоколов on 14.04.2022.
//

import UIKit

class PostViewController: UIViewController {
    
    var titlePost: String = "Title"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let infoBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: #selector(onInfoButtonClicked))
        
        self.view.backgroundColor = .lightGray
        self.navigationItem.title = titlePost
        
        self.navigationItem.rightBarButtonItem  = infoBarButtonItem
        
        
    }
    
    @objc
    func onInfoButtonClicked() {
        let infoViewController = InfoViewController()
        let navigationController = UINavigationController(rootViewController: infoViewController)
        infoViewController.title = "Info"
        self.present(navigationController, animated: true)
    }
    
}
