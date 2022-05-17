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
        let text = UILabel(frame: CGRect(x: 152, y: 107, width: 150, height: 20))
        text.text = "Cyber Cat"
        text.textColor = .black
        text.font = UIFont.boldSystemFont(ofSize: 18)
        return text
    }()
    
    let avatar: UIImageView = {
        let image = UIImageView(image: UIImage(named: "cyberCat-1"))
        image.frame = CGRect(x: 16, y: 106, width: 100, height: 100)
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor.systemBackground.cgColor
        image.layer.cornerRadius = 50
        return image
    }()
    
    let statusButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show Status", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        button.frame = CGRect(x: 16, y: 232, width: 384, height: 50)
        button.setTitleColor(.white, for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.7
        return button
    }()
    
    let statusText: UILabel = {
        let label = UILabel(frame: CGRect(x: 152, y: 148, width: 200, height: 18))
        label.text = "Waiting for something..."
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let statusField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 152, y: 166, width: 250, height: 40))
        textField.text = "Listening to music"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.backgroundColor = .white
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.textColor = .black
        textField.layer.cornerRadius = 12
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        return textField
    }()
    
}

