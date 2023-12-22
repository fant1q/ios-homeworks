//
//  LogInViewController.swift
//  Navigation
//
//  Created by Денис Штоколов on 29.05.2022.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {
    
    private let nc = NotificationCenter.default
    private lazy var delegate: LogInViewControllerDelegate = LoginInspector()
    private var handle: AuthStateDidChangeListenerHandle?
    var coordinator: LoginCoordinator?
    var myTimer: Timer?
    private let localAuthService = LocalAuthorizationService()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .systemBackground
        return $0
    }(UIView())
    
    lazy var loginField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "enter.email.loginField".localized
        textField.keyboardType = .emailAddress
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.backgroundColor = UIColor.createColor(lightMode: .systemGray6, darkMode: .systemGray3)
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .label
        textField.tintColor = .tintColor
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
        textField.placeholder = "enter.password.passField".localized
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.backgroundColor = UIColor.createColor(lightMode: .systemGray6, darkMode: .systemGray3)
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .label
        textField.tintColor = .tintColor
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
    
    private let loginButton = CustomButton(title: "enter.login.button".localized, backgroundColor: .systemBackground)
    private let signUpButton = CustomButton(title: "register.button".localized, backgroundColor: .systemIndigo)
    private let biometryLoginButton = CustomButton(title: "Войти с помощью биометрии", backgroundColor: .systemPurple)
    private var counter = 31
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.borderColor = UIColor.systemBackground.cgColor
        label.textColor = .systemBlue
        label.backgroundColor = .systemBackground
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.isHidden = true
        layuot()
        createTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nc.addObserver(self, selector: #selector(kbdShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.addObserver(self, selector: #selector(kbdHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        handle = Auth.auth().addStateDidChangeListener { auth, user in }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        nc.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        Auth.auth().removeStateDidChangeListener(handle!)
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
    
    private func createTimer() {
        if myTimer == nil {
            DispatchQueue.global().async {
                self.myTimer = Timer(timeInterval: 1, target: self, selector: #selector(self.timerAction), userInfo: nil, repeats: true)
                self.myTimer?.tolerance = 0.3
                RunLoop.current.add((self.myTimer!), forMode: .common)
                RunLoop.current.run()
            }
        }
    }
    
    private func loginTapAction() throws {
        
        guard let name = self.loginField.text else { throw ApiError.loginFieldEmpty(viewController: self) }
        guard let password = self.passField.text else { throw ApiError.passFieldEmpty(viewController: self) }
        
        delegate.checkCredentials(email: name,
                                  password: password,
                                  completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                let userService = CurrentUserService()
                self.coordinator = LoginCoordinator(navigation: self.navigationController ?? UINavigationController())
                self.coordinator?.profileTransition(name: name, userService: userService)
            case .failure(_):
                if name.isEmpty == true {
                    AppError().handle(error: .loginFieldEmpty(viewController: self))
                } else if password.isEmpty == true {
                    AppError().handle(error: .passFieldEmpty(viewController: self))
                } else {
                    AppError().handle(error: .wrongLoginOrPassword(viewController: self))
                }
            }
        })
    }
    
    private func registerUser() {
        
        let name = self.loginField.text ?? ""
        let password = self.passField.text ?? ""
        
        delegate.signUp(email: name,
                        password: password,
                        completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                let userService = CurrentUserService()
                self.coordinator = LoginCoordinator(navigation: self.navigationController ?? UINavigationController())
                self.coordinator?.profileTransition(name: name, userService: userService)
                AppError().handle(error: .registrationComplete(viewController: self))
                AppError().handle(error: .registrationComplete(viewController: self))
            case .failure(_):
                AppError().handle(error: .shortPassword(viewController: self))
            }
        })
    }
    
    @objc private func biometryAuth() {
        localAuthService.authorizeIfPossible { result in
            if result == true {
                let name = self.loginField.text
                let userService = CurrentUserService()
                self.coordinator = LoginCoordinator(navigation: self.navigationController ?? UINavigationController())
                self.coordinator?.profileTransition(name: name ?? "", userService: userService)
            }
        }
    }
    
    @objc private func timerAction() {
        DispatchQueue.main.async {
            if self.counter != 0 {
                self.counter -= 1
                if self.counter < 31 {
                    self.timerLabel.text = "time.remaining.to.refresh.timerLabel: ".localized + "\(self.counter)"
                }
            } else {
                self.loginField.text = ""
                self.passField.text = ""
                self.timerLabel.text = ""
                self.counter = 30
            }
        }
    }
    
    private func layuot() {
        view.addSubview(scrollView)
        loginButton.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        loginButton.tapAction = { try? self.loginTapAction() }
        signUpButton.tapAction = { self.registerUser() }
        biometryLoginButton.tapAction = { self.biometryAuth() }
        
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
        
        [loginField, passField, imageView, loginButton, timerLabel, signUpButton, biometryLoginButton].forEach { contentView.addSubview($0)}
        
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
            
            signUpButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 8),
            signUpButton.trailingAnchor.constraint(equalTo: loginButton.trailingAnchor),
            signUpButton.leadingAnchor.constraint(equalTo: loginButton.leadingAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
            
            biometryLoginButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 8),
            biometryLoginButton.trailingAnchor.constraint(equalTo: signUpButton.trailingAnchor),
            biometryLoginButton.leadingAnchor.constraint(equalTo: signUpButton.leadingAnchor),
            biometryLoginButton.heightAnchor.constraint(equalToConstant: 50),
            biometryLoginButton.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            timerLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            timerLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50)
        ])
    }
}

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

protocol LogInViewControllerDelegate: LoginServiceProtocol, AnyObject { }
