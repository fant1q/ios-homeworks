//
//  FeedViewController.swift
//  Navigation
//
//  Created by Денис Штоколов on 14.04.2022.
//

import UIKit
import Storage_Service

class FeedViewController: UIViewController {
    
    private lazy var dataItems: [Post] = posts
    let coreDataService = CoreDataService.shared
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "postCell")
        tableView.sectionHeaderTopPadding = 0
        return tableView
    }()
    
    var model: FeedModel
    var coordinator: FeedCoordinator?
    
    init(model: FeedModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        
        self.navigationItem.title = model.title
        view.backgroundColor = model.color
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
        view.addSubview(tableView)
        
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

extension FeedViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let postCell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostTableViewCell
        postCell.setupCell(post: posts[indexPath.row])
        postCell.tapHandler = { [weak self] in self?.savePostToFavorites(index: indexPath.row) }
        
        return postCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
}
