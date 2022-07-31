//
//  FeedViewController.swift
//  Navigation
//
//  Created by Денис Штоколов on 14.04.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    var buttonStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = .systemGray
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    let pushButton = CustomButton(title: "Go to the post", backgroundColor: .red)
    
    let pushButton2 = CustomButton(title: "Go to the post", backgroundColor: .green)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        buttonStack.addArrangedSubview(pushButton)
        buttonStack.addArrangedSubview(pushButton2)
        view.addSubview(buttonStack)
        pushButton.tapAction = { [weak self] in
            let postViewController = PostViewController()
            self?.navigationController?.pushViewController(postViewController, animated: true)
            postViewController.titlePost = "Mem Post"
        }
        pushButton2.tapAction = pushButton.tapAction
        
        NSLayoutConstraint.activate([
            buttonStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            buttonStack.widthAnchor.constraint(equalToConstant: 150),
            buttonStack.heightAnchor.constraint(equalToConstant: 150),
            pushButton.widthAnchor.constraint(equalToConstant: 120),
            pushButton2.widthAnchor.constraint(equalToConstant: 120),
        ])
        
    }
}
