//
//  InfoViewController.swift
//  Navigation
//
//  Created by Денис Штоколов on 14.04.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("delete.post.button".localized, for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        
        return button
        
    }()
    
    let alertUI: UIAlertController = {
        let alert = UIAlertController(title: "delete.post.button".localized, message: "are.you.sure?.alert.message".localized, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("yes.alert.action".localized, comment: "Default action"), style: .default, handler: { _ in
            NSLog("Post has been deleted")
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("no.alert.action".localized, comment: "Default action"), style: .default, handler: { _ in
            NSLog("Deletion cancelled")
        }))
        
        return alert
        
    }()
    
    private let requestLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var model: InfoModel
    
    init(model: InfoModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = model.color
        navigationItem.title = model.title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
    }
    
    private func layout() {
        [deleteButton, requestLabel].forEach { view.addSubview($0) }
        view.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 140),
            deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deleteButton.widthAnchor.constraint(equalToConstant: 150),
            
            requestLabel.topAnchor.constraint(equalTo: deleteButton.bottomAnchor, constant: 40),
            requestLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc
    func buttonTap() {
        self.present(alertUI, animated: true)
    }
    
}
