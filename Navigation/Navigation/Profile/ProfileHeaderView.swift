//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Денис Штоколов on 02.05.2022.
//

import Foundation
import UIKit

class ProfileHeaderView: UIView {
    
    var name: UILabel = {
        let text = UILabel()
        text.text = "Cyber Cat"
        text.textColor = .black
        text.font = UIFont.boldSystemFont(ofSize: 18)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let avatar: UIImageView = {
        let image = UIImageView(image: UIImage(named: "cyberCat-1"))
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor.systemBackground.cgColor
        image.layer.cornerRadius = 50
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let statusButton: UIButton = {
        let button = UIButton()
        button.setTitle("Set Status", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        button.setTitleColor(.white, for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.7
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let statusText: UILabel = {
        let label = UILabel()
        label.text = "Waiting for something..."
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let statusField: UITextField = {
        let textField = UITextField()
        textField.text = "Listening to music"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.backgroundColor = .white
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.textColor = .black
        textField.layer.cornerRadius = 12
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    func layout() {
        
        backgroundColor = .lightGray
        
        [name, avatar, statusButton, statusText, statusField].forEach { addSubview($0) }
        
        statusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        statusField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatar.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            avatar.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            avatar.heightAnchor.constraint(equalToConstant: 100),
            avatar.widthAnchor.constraint(equalToConstant: 100),
            name.topAnchor.constraint(equalTo: topAnchor, constant: 27),
            name.centerXAnchor.constraint(equalTo: centerXAnchor),
            statusButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            statusButton.heightAnchor.constraint(equalToConstant: 50),
            statusButton.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 32),
            statusButton.widthAnchor.constraint(equalTo: widthAnchor, constant: -16),
            statusText.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 34),
            statusText.bottomAnchor.constraint(equalTo: statusButton.topAnchor, constant: -50),
            statusField.heightAnchor.constraint(equalToConstant: 40),
            statusField.topAnchor.constraint(equalTo: statusText.bottomAnchor, constant: 4),
            statusField.leftAnchor.constraint(equalTo: avatar.rightAnchor, constant: 40),
            statusField.rightAnchor.constraint(equalTo: rightAnchor, constant: -16)
        ])
    }
    
    @objc func buttonPressed() {
        statusText.text = statusField.text
        statusField.endEditing(true)
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        if statusButton.isPointerInteractionEnabled == true {
            statusText.text = textField.text ?? ""
        }
    }
}
