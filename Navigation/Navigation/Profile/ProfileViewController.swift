//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Денис Штоколов on 14.04.2022.
//

import UIKit
import Storage_Service

class ProfileViewController: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        
#if DEBUG
        view.backgroundColor = .systemRed
#else
        view.backgroundColor = .systemGreen
#endif
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
            postCell.setupCell(post: posts[indexPath.row])
            
            return postCell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let vc = PhotosViewController()
            self.navigationController?.pushViewController(vc, animated: true)
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
