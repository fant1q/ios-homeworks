//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Денис Штоколов on 08.06.2022.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    var tapHandler: (() -> Void)?
    
    private let content: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .black)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nameOfSection: UILabel = {
        let label = UILabel()
        label.text = "photos.cell".localized
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    private let arrowImg: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .black)
        imageView.image = UIImage(systemName: "arrow.right")?.withTintColor(UIColor.createColor(lightMode: .black, darkMode: .white), renderingMode: .alwaysOriginal)
        return imageView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(PhotosPreviewCollectionViewCell.self, forCellWithReuseIdentifier: "phPreCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    
    private let createPostButton = CustomButton(title: "create.post".localized, backgroundColor: .systemCyan)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layuot()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layuot() {
        
        [content, nameOfSection, arrowImg, collectionView, createPostButton].forEach { contentView.addSubview($0) }
        createPostButton.tapAction = tap
        
        NSLayoutConstraint.activate([
            content.topAnchor.constraint(equalTo: contentView.topAnchor),
            content.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            content.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            content.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            createPostButton.topAnchor.constraint(equalTo: content.topAnchor, constant: 12),
            createPostButton.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -12),
            createPostButton.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 12),
            createPostButton.heightAnchor.constraint(equalToConstant: 50),
            
            nameOfSection.topAnchor.constraint(equalTo: createPostButton.bottomAnchor, constant: 12),
            nameOfSection.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 12),
            
            arrowImg.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -12),
            arrowImg.centerYAnchor.constraint(equalTo: nameOfSection.centerYAnchor),
            arrowImg.topAnchor.constraint(equalTo: createPostButton.bottomAnchor, constant: 12),
            
            collectionView.topAnchor.constraint(equalTo: nameOfSection.bottomAnchor, constant: 12),
            collectionView.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 12),
            collectionView.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -12),
            collectionView.bottomAnchor.constraint(equalTo: content.bottomAnchor, constant: -12),
            collectionView.heightAnchor.constraint(equalToConstant: 92)
        ])
    }
    
    @objc
    private func tap() {
        if tapHandler != nil {
            tapHandler?()
        }
    }
}

extension PhotosTableViewCell: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "phPreCell", for: indexPath) as! PhotosPreviewCollectionViewCell
        cell.setupCell(photo: imageStorage[indexPath.row])
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
}

extension PhotosTableViewCell: UICollectionViewDelegateFlowLayout {
    private var sideInset: CGFloat { return 8 }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - sideInset * 5) / 4
        return CGSize(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }
}
