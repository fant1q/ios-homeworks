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
        button.setTitle("Show Status", for: .normal)
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
    
}
