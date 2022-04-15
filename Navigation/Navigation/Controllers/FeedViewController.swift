//
//  FeedViewController.swift
//  Navigation
//
//  Created by Денис Штоколов on 14.04.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    let pushButton = UIButton()
    var post = Post(title: "Mem post")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pushButton.setTitle("Go to the post", for: .normal)
        self.pushButton.backgroundColor = .systemMint
        self.pushButton.layer.cornerRadius = 15
        self.view.addSubview(pushButton)
        self.pushButton.frame = CGRect(x: 140, y: 200, width: 150, height: 70)
        self.pushButton.setTitleColor(.blue, for: .normal)
        self.pushButton.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
        self.view.backgroundColor = .systemBackground
    }
    
    @objc
    func handleButtonTap() {
        let postViewController = PostViewController()
        self.navigationController?.pushViewController(postViewController, animated: true)
        postViewController.titlePost = post.title
    }
}
