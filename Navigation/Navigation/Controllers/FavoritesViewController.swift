//
//  FavoritesViewController.swift
//  Navigation
//
//  Created by Денис Штоколов on 24.03.2023.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    var model: FavoritesModel
    let coreDataService = CoreDataService.shared
    var favoritePosts: [FavoritePost] {
        
        guard let searchText = self.searchController.searchBar.text,
              !searchText.isEmpty else {
            return coreDataService.favPosts
        }
        return coreDataService.searchPosts(searchText)
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: "favPostCell")
        tableView.sectionHeaderTopPadding = 0
        return tableView
    }()
    
    private lazy var searchController: UISearchController = {
        let view = UISearchController(searchResultsController: nil)
        view.searchBar.searchTextField.placeholder = "Enter the name"
        view.searchResultsUpdater = self
        return view
    }()
    
    init(model: FavoritesModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        
        self.navigationItem.title = model.title
        view.backgroundColor = model.color
        navigationItem.searchController = searchController
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        
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

extension FavoritesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let favPostCell = tableView.dequeueReusableCell(withIdentifier: "favPostCell", for: indexPath) as! FavoritesTableViewCell
        favPostCell.setupCell(post: favoritePosts[indexPath.row])
        
        return favPostCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritePosts.count
    }
}

extension FavoritesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, _) in
            guard let self = self else { return }
            let item = self.favoritePosts[indexPath.row]
            self.coreDataService.deleteFavPost(item)
            tableView.reloadData()
        }
        return .init(actions: [action])
    }
}

extension FavoritesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        tableView.reloadData()
    }
}
