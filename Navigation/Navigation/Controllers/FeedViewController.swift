//
//  FeedViewController.swift
//  Navigation
//
//  Created by Денис Штоколов on 14.04.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    private var buttonStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = .systemGray
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    private let pushButton = CustomButton(title: "Go to the post", backgroundColor: .red)
    
    private let pushButton2 = CustomButton(title: "Go to the post", backgroundColor: .green)
    
    private let checkButton = CustomButton(title: "Check password", backgroundColor: .systemBlue)
    
    private let passField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter password"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.backgroundColor = .systemGray6
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .black
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        return textField
    }()
    
    private let checkLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var model: FeedModel
    var coordinator: FeedCoordinator?
    
    init(model: FeedModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    private func layout() {
        
        self.view.backgroundColor = .systemBackground
        buttonStack.addArrangedSubview(pushButton)
        buttonStack.addArrangedSubview(pushButton2)
        
        [buttonStack, checkButton, passField, checkLabel].forEach { view.addSubview($0) }
        
        pushButton.tapAction = { [weak self] in
            self!.coordinator = FeedCoordinator(navigation: self?.navigationController ?? UINavigationController())
            self!.coordinator?.postTransition()
        }
        pushButton2.tapAction = pushButton.tapAction
        
        checkButton.tapAction = { [weak self] in
            let pass = self!.passField.text ?? ""
            if FeedModel().check(word: pass) == true {
                self!.checkLabel.text = "Верно"
                self!.checkLabel.backgroundColor = .systemGreen
            } else {
                self!.checkLabel.text = "Неверно"
                self!.checkLabel.backgroundColor = .systemRed
            }
        }
        
        NSLayoutConstraint.activate([
            buttonStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            buttonStack.widthAnchor.constraint(equalToConstant: 150),
            buttonStack.heightAnchor.constraint(equalToConstant: 150),
            
            passField.topAnchor.constraint(equalTo: buttonStack.bottomAnchor, constant: 20),
            passField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            passField.heightAnchor.constraint(equalToConstant: 35),
            passField.widthAnchor.constraint(equalToConstant: 150),
            
            checkButton.topAnchor.constraint(equalTo: buttonStack.bottomAnchor, constant: 20),
            checkButton.leadingAnchor.constraint(equalTo: passField.trailingAnchor, constant: 20),
            checkButton.widthAnchor.constraint(equalToConstant: 150),
            
            checkLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkLabel.topAnchor.constraint(equalTo: passField.bottomAnchor, constant: 20)
        ])
    }
}

extension FeedViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
