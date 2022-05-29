//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Денис Штоколов on 14.04.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var titleProfile: String = "Profile"
    
    let subView: ProfileHeaderView = {
        let view = ProfileHeaderView()
        view.layout()
        return view
    }()
    
    let someButton: UIButton = {
        let button = UIButton()
        button.setTitle("Some Button", for: .normal)
        button.backgroundColor = .systemBlue
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
    }
    private func layout() {
        
        view.backgroundColor = .systemBackground
        navigationItem.title = titleProfile
        
        [subView, someButton].forEach { view.addSubview($0)}
        
        NSLayoutConstraint.activate([
            subView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            subView.heightAnchor.constraint(equalToConstant: 220),
            subView.widthAnchor.constraint(equalTo: view.widthAnchor),
            someButton.widthAnchor.constraint(equalTo: view.widthAnchor),
            someButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
