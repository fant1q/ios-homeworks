//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Денис Штоколов on 14.04.2022.
//

import UIKit
import Storage_Service
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MyPostTableViewCell.self, forCellReuseIdentifier: "myPostCell")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "photoCell")
        tableView.sectionHeaderTopPadding = 0
        return tableView
    }()
    
    var userService: UserService?
    var name: String?
    var model: ProfileModel
    var coordinator: ProfileCoordinator?
    
    init (model: ProfileModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        
        self.title = model.title
        self.userService = model.userService
        self.name = model.name
#if DEBUG
        view.backgroundColor = .systemBackground
#else
        view.backgroundColor = .systemGreen
#endif
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    private func layout() {
        view.addSubview(tableView)
        view.backgroundColor = .systemBackground
        self.navigationController?.navigationItem.backBarButtonItem?.isEnabled = false
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: NSNotification.Name(rawValue: "reload"), object: nil)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc private func reload(notification: NSNotification) {
        self.tableView.reloadData()
    }
    
    private func createPost() {
        guard let name = self.name else {return print("not found userName")}
        guard let service = self.userService else {return print("not found userService")}
        coordinator = ProfileCoordinator(navigation: self.navigationController ?? UINavigationController(), name: name, userService: service)
        coordinator?.createPostTransition()
    }
}

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let photosCell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as! PhotosTableViewCell
            photosCell.tapHandler = { [weak self] in self?.createPost() }
            
            return photosCell
        } else {
            let myPostCell = tableView.dequeueReusableCell(withIdentifier: "myPostCell", for: indexPath) as! MyPostTableViewCell
            myPostCell.setupCell(post: myPosts[indexPath.row])
            
            return myPostCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            guard let name = self.name else {return print("not found userName")}
            guard let service = self.userService else {return print("not found userService")}
            coordinator = ProfileCoordinator(navigation: self.navigationController ?? UINavigationController(), name: name, userService: service)
            coordinator?.photosTransition()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return myPosts.count
        }
    }
}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            let header = ProfileHeaderView()
            return header
        } else {
            return UIView(frame: .zero)
        }
    }
}
