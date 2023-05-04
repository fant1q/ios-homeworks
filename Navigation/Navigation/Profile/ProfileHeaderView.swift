//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Денис Штоколов on 02.05.2022.
//

import Foundation
import UIKit
import SnapKit

class ProfileHeaderView: UIView {
    
    let userService = CurrentUserService()
    
    var name: UILabel = {
        let text = UILabel()
        text.text = "cyberCat.profile.name".localized
        text.textColor = .black
        text.font = UIFont.boldSystemFont(ofSize: 18)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    var avatar: UIImageView = {
        let image = UIImageView(image: UIImage(named: "cyberCat-1"))
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor.systemBackground.cgColor
        image.layer.cornerRadius = 50
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        return image
    }()
    
    let statusButton = CustomButton(title: "setStatus.status".localized, backgroundColor: .systemBlue)
    
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
        textField.placeholder = "listening.to.music.status".localized
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
    
    let imageAnimation: UIView = {
        let view = UIView(frame: .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        view.translatesAutoresizingMaskIntoConstraints = true
        view.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        view.isHidden = true
        return view
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular , scale: .medium)
        button.setBackgroundImage(UIImage(systemName: "xmark", withConfiguration: largeConfig)?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(closeButtonTap), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        setupGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTap))
        avatar.addGestureRecognizer(tapGesture)
    }
    
    @objc private func imageTap() {
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseIn, animations: {
            self.avatar.center.x = UIScreen.main.bounds.midX
            self.avatar.center.y = UIScreen.main.bounds.midY
            self.avatar.transform = self.avatar.transform.scaledBy(x: UIScreen.main.bounds.width / 100 , y: UIScreen.main.bounds.height / 180)
            self.avatar.layer.cornerRadius = 0
            self.imageAnimation.isHidden = false
        }, completion: { _ in
            UIView.animate(withDuration: 0.3, animations: {
                self.closeButton.isHidden = false
            })
        })
    }
    
    @objc private func closeButtonTap() {
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseIn, animations: {
            self.closeButton.isHidden = true
            self.avatar.transform = self.avatar.transform.scaledBy(x: 0.23 , y: 0.23)
            self.avatar.layer.cornerRadius = 50
            self.imageAnimation.isHidden = true
        }, completion: { _ in
            UIView.animate(withDuration: 0.3, animations: {
                self.layout()
            })
        })
    }
    
    private func layout() {
        
        backgroundColor = .systemGray6
        
        name.text = userService.user.name
        avatar = userService.user.avatar
        statusText.text = userService.user.status
        statusButton.addShadow()
        
        [name, statusButton, statusText, statusField, imageAnimation, avatar, closeButton].forEach { addSubview($0) }
        
        statusButton.tapAction = { [weak self] in
            self!.statusText.text = self!.statusField.text
            self!.statusField.endEditing(true)
        }
        statusField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        
        name.snp.makeConstraints { (make) -> Void in
            make.top.equalToSuperview().offset(27)
            make.centerX.equalToSuperview()
        }
        
        statusButton.snp.makeConstraints { (make) -> Void in
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalTo(avatar.snp.bottom).offset(32)
            make.width.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        statusText.snp.makeConstraints { (make) -> Void in
            make.centerX.equalToSuperview().offset(34)
            make.bottom.equalTo(statusButton.snp.top).offset(-50)
        }
        
        statusField.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(40)
            make.top.equalTo(statusText.snp.bottom).offset(4)
            make.leading.equalTo(avatar.snp.trailing).offset(40)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        avatar.snp.makeConstraints { (make) -> Void in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
        
        closeButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(imageAnimation.safeAreaLayoutGuide.snp.top).offset(13)
            make.trailing.equalTo(imageAnimation.snp.trailing).offset(-26)
        }
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        if statusButton.isPointerInteractionEnabled == true {
            statusText.text = textField.text ?? ""
        }
    }
}
