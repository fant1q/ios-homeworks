//
//  MyPostTableViewCell.swift
//  Navigation
//
//  Created by Денис Штоколов on 05.11.2023.
//

import UIKit
import Storage_Service

class MyPostTableViewCell: UITableViewCell {
    
    private let content: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .black)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 2
        label.backgroundColor = .systemBackground
        return label
    }()
    
    private lazy var avatarPreview: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 50
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var photo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.createColor(lightMode: .black, darkMode: .systemGray6)
        return imageView
    }()
    
    private lazy var descriptionTextView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 26)
        label.textColor = UIColor.createColor(lightMode: .black, darkMode: .systemGray6)
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layuot()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(post: MyPost) {
        photo.image = UIImage(data: post.photo )
        avatarPreview.image = UIImage(data: post.avatar )
        authorLabel.text = post.authorLabel
        descriptionTextView.text = post.postText
        
    }
    
    private func layuot() {
        
        [content, photo, avatarPreview, authorLabel, descriptionTextView].forEach { contentView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            content.topAnchor.constraint(equalTo: contentView.topAnchor),
            content.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            content.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            content.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            avatarPreview.topAnchor.constraint(equalTo: content.topAnchor, constant: 16),
            avatarPreview.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 16),
            avatarPreview.heightAnchor.constraint(equalToConstant: 35),
            avatarPreview.widthAnchor.constraint(equalToConstant: 35),
            
            authorLabel.topAnchor.constraint(equalTo: content.topAnchor, constant: 16),
            authorLabel.leadingAnchor.constraint(equalTo: avatarPreview.trailingAnchor, constant: 16),
            authorLabel.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -16),
            authorLabel.heightAnchor.constraint(equalToConstant: 35),
            
            photo.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 8),
            photo.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 16),
            photo.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -16),
            photo.heightAnchor.constraint(equalToConstant: 100),
            
            descriptionTextView.topAnchor.constraint(equalTo: photo.bottomAnchor, constant: 16),
            descriptionTextView.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 16),
            descriptionTextView.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -16),
            descriptionTextView.bottomAnchor.constraint(equalTo: content.bottomAnchor, constant: -8)
        ])
    }
}
