//
//  PostViewController.swift
//  Navigation
//
//  Created by Денис Штоколов on 14.04.2022.
//

import UIKit

class PostViewController: UIViewController {
    
    var model: PostModel
    
    init(model: PostModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        
        navigationItem.title = model.title
        view.backgroundColor = model.color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let infoBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: #selector(onInfoButtonClicked))
        self.navigationItem.rightBarButtonItem  = infoBarButtonItem
        
        
    }
    
    @objc
    func onInfoButtonClicked() {
        let infoViewController = ViewControllerFactory.makeViewController(.info)
        let navigationController = UINavigationController(rootViewController: infoViewController())
        self.present(navigationController, animated: true)
    }
    
}
