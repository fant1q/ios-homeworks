//
//  FavoritesTableViewCell.swift
//  Navigation
//
//  Created by Денис Штоколов on 25.03.2023.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    
    private let content: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .black)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 2
        label.backgroundColor = .systemBackground
        return label
    }()
    
    private let carImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.createColor(lightMode: .black, darkMode: .systemGray6)
        return imageView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.numberOfLines = 0
        return label
    }()
    
    private let likesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .label
        return label
    }()
    
    private let viewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .label
        return label
    }()
    
    private let heart: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .red
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layuot()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(post: FavoritePost) {
        carImageView.image = UIImage(named: post.image!)!
        authorLabel.text = post.author
        descriptionLabel.text = post.postDescription
        likesLabel.text = String(format: "likes.count".localized, post.likes)
        viewsLabel.text = "views.cell: ".localized + "\(post.views)"
        heart.image = post.isLiked ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        
    }
    
    private func layuot() {
        
        [content, carImageView, authorLabel, descriptionLabel, likesLabel, viewsLabel, heart].forEach { contentView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            content.topAnchor.constraint(equalTo: contentView.topAnchor),
            content.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            content.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            content.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            authorLabel.topAnchor.constraint(equalTo: content.topAnchor, constant: 8),
            authorLabel.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 16),
            authorLabel.trailingAnchor.constraint(equalTo: content.trailingAnchor,constant: -16),
            
            carImageView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 8),
            carImageView.leadingAnchor.constraint(equalTo: content.leadingAnchor),
            carImageView.trailingAnchor.constraint(equalTo: content.trailingAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: carImageView.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -16),
            
            likesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            likesLabel.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 16),
            likesLabel.bottomAnchor.constraint(equalTo: content.bottomAnchor),
            
            viewsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            viewsLabel.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -16),
            viewsLabel.bottomAnchor.constraint(equalTo: content.bottomAnchor, constant: -8 * 2),
            
            heart.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            heart.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 208),
            heart.bottomAnchor.constraint(equalTo: content.bottomAnchor, constant: -16)
            
        ])
    }
}
