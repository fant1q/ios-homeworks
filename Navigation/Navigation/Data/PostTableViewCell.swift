//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Денис Штоколов on 02.06.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    private let content: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    private let carImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
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
        label.textColor = .black
        return label
    }()
    
    private let viewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layuot()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(post: Post) {
        carImageView.image = post.image
        authorLabel.text = post.author
        descriptionLabel.text = post.description
        likesLabel.text = "Likes: \(post.likes)"
        viewsLabel.text = "Views: \(post.views)"
        
    }
    
    private func layuot() {
        
        [content, carImageView, authorLabel, descriptionLabel, likesLabel, viewsLabel].forEach { contentView.addSubview($0) }
        
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
            
        ])
    }
}
