//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Денис Штоколов on 14.04.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var titleProfile: String = "Profile"
    private var statusText: String = ""
    
    let subView: ProfileHeaderView = {
        let view = ProfileHeaderView()
        view.backgroundColor = .lightGray
        view.addSubview(view.name)
        view.addSubview(view.avatar)
        view.addSubview(view.statusButton)
        view.addSubview(view.statusText)
        view.addSubview(view.statusField)
        view.statusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        view.statusField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.avatar.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            view.avatar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            view.avatar.heightAnchor.constraint(equalToConstant: 100),
            view.avatar.widthAnchor.constraint(equalToConstant: 100),
            view.name.topAnchor.constraint(equalTo: view.topAnchor, constant: 27),
            view.name.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            view.statusButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            view.statusButton.heightAnchor.constraint(equalToConstant: 50),
            view.statusButton.topAnchor.constraint(equalTo: view.avatar.bottomAnchor, constant: 32),
            view.statusButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -16),
            view.statusText.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 34),
            view.statusText.bottomAnchor.constraint(equalTo: view.statusButton.topAnchor, constant: -50),
            view.statusField.heightAnchor.constraint(equalToConstant: 40),
            view.statusField.topAnchor.constraint(equalTo: view.statusText.bottomAnchor, constant: 4),
            view.statusField.leftAnchor.constraint(equalTo: view.avatar.rightAnchor, constant: 40),
            view.statusField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
        ])
        
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
        
        self.view.backgroundColor = .systemBackground
        self.navigationItem.title = titleProfile
        view.addSubview(subView)
        view.addSubview(someButton)
        NSLayoutConstraint.activate([
            subView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            subView.heightAnchor.constraint(equalToConstant: 220),
            subView.widthAnchor.constraint(equalTo: view.widthAnchor),
            someButton.widthAnchor.constraint(equalTo: view.widthAnchor),
            someButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    
    @objc func buttonPressed() {
        subView.statusText.text = subView.statusField.text
        subView.statusButton.setTitle("Show Status", for: .normal)
        subView.statusField.endEditing(true)
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        subView.statusButton.setTitle("Set Status", for: .normal)
        statusText = textField.text ?? ""
    }
}
