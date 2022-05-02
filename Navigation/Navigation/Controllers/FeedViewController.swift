//
//  FeedViewController.swift
//  Navigation
//
//  Created by Денис Штоколов on 14.04.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    var pushButton: UIButton = {
        let button = UIButton()
        button.setTitle("Go to the post", for: .normal)
        button.backgroundColor = .systemMint
        button.layer.cornerRadius = 15
        button.frame = CGRect(x: 140, y: 200, width: 150, height: 70)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
        
        return button
    }()
    
    var post = Post(title: "Mem post")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(pushButton)
        self.view.backgroundColor = .systemBackground
    }
    
    @objc
    func handleButtonTap() {
        let postViewController = PostViewController()
        self.navigationController?.pushViewController(postViewController, animated: true)
        postViewController.titlePost = post.title
    }
}
