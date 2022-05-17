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
        subView.backgroundColor = .lightGray
        self.navigationItem.title = titleProfile
        view.addSubview(subView)
        view.addSubview(subView.name)
        view.addSubview(subView.avatar)
        view.addSubview(subView.statusButton)
        view.addSubview(subView.statusText)
        view.addSubview(subView.statusField)
        view.addSubview(someButton)
        subView.statusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        subView.statusField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        subView.translatesAutoresizingMaskIntoConstraints = false
        someButton.translatesAutoresizingMaskIntoConstraints = false
        subView.avatar.translatesAutoresizingMaskIntoConstraints = false
        subView.name.translatesAutoresizingMaskIntoConstraints = false
        subView.statusButton.translatesAutoresizingMaskIntoConstraints = false
        subView.statusText.translatesAutoresizingMaskIntoConstraints = false
        subView.statusField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            subView.heightAnchor.constraint(equalToConstant: 220),
            subView.widthAnchor.constraint(equalTo: view.widthAnchor),
            someButton.widthAnchor.constraint(equalTo: view.widthAnchor),
            someButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            subView.avatar.topAnchor.constraint(equalTo: subView.topAnchor, constant: 16),
            subView.avatar.leftAnchor.constraint(equalTo: subView.leftAnchor, constant: 16),
            subView.avatar.heightAnchor.constraint(equalToConstant: 100),
            subView.avatar.widthAnchor.constraint(equalToConstant: 100),
            subView.name.topAnchor.constraint(equalTo: subView.topAnchor, constant: 27),
            subView.name.centerXAnchor.constraint(equalTo: subView.centerXAnchor),
            subView.statusButton.centerXAnchor.constraint(equalTo: subView.centerXAnchor),
            subView.statusButton.heightAnchor.constraint(equalToConstant: 50),
            subView.statusButton.topAnchor.constraint(equalTo: subView.avatar.bottomAnchor, constant: 32),
            subView.statusButton.widthAnchor.constraint(equalTo: subView.widthAnchor, constant: -16),
            subView.statusText.centerXAnchor.constraint(equalTo: subView.centerXAnchor, constant: 34),
            subView.statusText.bottomAnchor.constraint(equalTo: subView.statusButton.topAnchor, constant: -50),
            subView.statusField.heightAnchor.constraint(equalToConstant: 40),
            subView.statusField.topAnchor.constraint(equalTo: subView.statusText.bottomAnchor, constant: 4),
            subView.statusField.leftAnchor.constraint(equalTo: subView.avatar.rightAnchor, constant: 40),
            subView.statusField.rightAnchor.constraint(equalTo: subView.rightAnchor, constant: -16)
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
