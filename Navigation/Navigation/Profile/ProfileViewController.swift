//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Денис Штоколов on 14.04.2022.
//

import UIKit
import Storage_Service

class ProfileViewController: UIViewController {
    
    private lazy var dataItems: [Post] = posts
    let coreDataService = CoreDataService.shared
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "postCell")
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
        view.backgroundColor = .systemRed
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
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func savePostToFavorites(index: IndexPath.Index) {
        if dataItems[index].isLiked {
            var unlikedPost = dataItems[index]
            unlikedPost.isLiked = false
            unlikedPost.likes -= 1
            dataItems[index] = unlikedPost
            tableView.reloadData()
            coreDataService.deletePost(dataItems[index])
        } else {
            var likedPost = dataItems[index]
            likedPost.isLiked = true
            likedPost.likes += 1
            dataItems[index] = likedPost
            tableView.reloadData()
            coreDataService.addPost(dataItems[index])
        }
    }
}

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let photosCell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as! PhotosTableViewCell
            
            return photosCell
        } else {
            let postCell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostTableViewCell
            postCell.setupCell(post: dataItems[indexPath.row])
            postCell.tapHandler = { [weak self] in self?.savePostToFavorites(index: indexPath.row) }
            
            return postCell
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
            return posts.count
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
