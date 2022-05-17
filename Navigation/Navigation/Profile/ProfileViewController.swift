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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        subView.backgroundColor = .lightGray
        self.navigationItem.title = titleProfile
        view.addSubview(subView)
        view.addSubview(subView)
        view.addSubview(subView.name)
        view.addSubview(subView.avatar)
        view.addSubview(subView.statusButton)
        view.addSubview(subView.statusText)
        subView.statusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        view.addSubview(subView.statusField)
        subView.statusField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        subView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            subView.heightAnchor.constraint(equalToConstant: 220),
            subView.widthAnchor.constraint(equalTo: view.widthAnchor)
            
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
