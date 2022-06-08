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
    var pushButton: UIButton = {
        let button = UIButton()
        button.setTitle("Go to the post", for: .normal)
        button.backgroundColor = .systemMint
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
        
        return button
    }()
    
    var pushButton2: UIButton = {
        let button = UIButton()
        button.setTitle("Go to the post", for: .normal)
        button.backgroundColor = .systemCyan
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
        
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        buttonStack.addArrangedSubview(pushButton)
        buttonStack.addArrangedSubview(pushButton2)
        view.addSubview(buttonStack)
        
        NSLayoutConstraint.activate([
            buttonStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            buttonStack.widthAnchor.constraint(equalToConstant: 150),
            buttonStack.heightAnchor.constraint(equalToConstant: 150),
            pushButton.widthAnchor.constraint(equalToConstant: 120),
            pushButton2.widthAnchor.constraint(equalToConstant: 120),
        ])
        
    }
    
    @objc
    func handleButtonTap() {
        let postViewController = PostViewController()
        self.navigationController?.pushViewController(postViewController, animated: true)
        postViewController.titlePost = "Mem Post"
    }
}
