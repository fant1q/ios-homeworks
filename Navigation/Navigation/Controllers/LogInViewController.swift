//
//  LogInViewController.swift
//  Navigation
//
//  Created by Денис Штоколов on 29.05.2022.
//

import UIKit

class LogInViewController: UIViewController {
    
    private let nc = NotificationCenter.default
    
    weak var delegate: LogInViewControllerDelegate?
    var coordinator: LoginCoordinator?
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
        return $0
    }(UIView())
    
    lazy var loginField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email or phone"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.backgroundColor = .systemGray6
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .black
        textField.tintColor = .black
        textField.autocapitalizationType = .none
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
    }()
    
    private lazy var passField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.backgroundColor = .systemGray6
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .black
        textField.tintColor = .black
        textField.autocapitalizationType = .none
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let loginButton = CustomButton(title: "Log In", backgroundColor: .systemBackground)
    private let passwordGuessingButton = CustomButton(title: "Pick up a password", backgroundColor: .systemBlue)
    
    let bruteForce = BruteForce()
    let passOperation = OperationQueue()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.style = .medium
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.isHidden = true
        layuot()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nc.addObserver(self, selector: #selector(kbdShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.addObserver(self, selector: #selector(kbdHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        nc.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func kbdShow(notification: NSNotification) {
        if let kbdSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as?  NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = kbdSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbdSize.height, right: 0)
        }
    }
    
    @objc private func kbdHide() {
        scrollView.contentInset = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
    
    private func layuot() {
        view.addSubview(scrollView)
        loginButton.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        loginButton.tapAction = { [weak self] in
            let name = self!.loginField.text ?? ""
#if DEBUG
            let userService = TestUserService()
#else
            let userService = CurrentUserService()
#endif
            if MyLoginFactory.loginInspector().checkLoginPass(log: self!.loginField.text!, pass: self!.passField.text!) == true {
                self!.coordinator = LoginCoordinator(navigation: self?.navigationController ?? UINavigationController())
                self!.coordinator?.profileTransition(name: name, userService: userService)
            } else { return print("Error") }
        }
        passwordGuessingButton.tapAction = { [weak self] in
            if self!.loginField.text?.isEmpty == false {
                self!.activityIndicator.startAnimating()
                guard let enteredLogin = self!.loginField.text else { return }
                self!.bruteForce.completionBlock = { [weak self] in
                    DispatchQueue.global().async {
                        self!.passField.text = self!.bruteForce.bruteForce(login: enteredLogin)
                        self!.passField.isSecureTextEntry = false
                        self!.activityIndicator.stopAnimating()
                    }
                }
                self!.passOperation.addOperation(self!.bruteForce)
                self!.passOperation.qualityOfService = .userInitiated
            } else { return print("no login") }
        }
        
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        [loginField, passField, imageView, loginButton, passwordGuessingButton, activityIndicator].forEach { contentView.addSubview($0)}
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 120),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.bottomAnchor.constraint(equalTo: loginField.topAnchor, constant: -120),
            loginField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 120),
            loginField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -36),
            loginField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 36),
            loginField.heightAnchor.constraint(equalToConstant: 50),
            loginField.bottomAnchor.constraint(equalTo: passField.topAnchor),
            passField.topAnchor.constraint(equalTo: loginField.bottomAnchor),
            passField.trailingAnchor.constraint(equalTo: loginField.trailingAnchor),
            passField.leadingAnchor.constraint(equalTo: loginField.leadingAnchor),
            passField.heightAnchor.constraint(equalToConstant: 50),
            passField.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -16),
            loginButton.topAnchor.constraint(equalTo: passField.bottomAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: passField.trailingAnchor),
            loginButton.leadingAnchor.constraint(equalTo: passField.leadingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            passwordGuessingButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            passwordGuessingButton.leadingAnchor.constraint(equalTo: loginButton.leadingAnchor),
            passwordGuessingButton.trailingAnchor.constraint(equalTo: loginButton.trailingAnchor),
            passwordGuessingButton.heightAnchor.constraint(equalToConstant: 50),
            passwordGuessingButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            activityIndicator.topAnchor.constraint(equalTo: passField.topAnchor),
            activityIndicator.leadingAnchor.constraint(equalTo: passField.trailingAnchor, constant: -30),
            activityIndicator.bottomAnchor.constraint(equalTo: passField.bottomAnchor)
        ])
    }
}

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

protocol LogInViewControllerDelegate: AnyObject {
    
    func checkLoginPass(log: String, pass: String) -> Bool
}
