//
//  InfoViewController.swift
//  Navigation
//
//  Created by Денис Штоколов on 14.04.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Delete Post", for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 15
        button.frame = CGRect(x: 140, y: 200, width: 150, height: 70)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        
        return button
        
    }()
    
    let alertUI: UIAlertController = {
        let alert = UIAlertController(title: "Delete Post", message: "Are you sure?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: "Default action"), style: .default, handler: { _ in
            NSLog("Post has been deleted")
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: "Default action"), style: .default, handler: { _ in
            NSLog("Deletion cancelled")
        }))
        
        return alert
        
    }()
    
    var model: InfoModel
    
    init(model: InfoModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = model.color
        navigationItem.title = model.title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(deleteButton)
        
    }
    
    @objc
    func buttonTap() {
        self.present(alertUI, animated: true)
    }
    
}
