//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Денис Штоколов on 17.06.2022.
//

import UIKit
import iOSIntPackage

class PhotosCollectionViewCell: UICollectionViewCell {
    
    private let picture: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(photo: UIImage) {
        picture.image = photo
    }
    
    private func layout() {
        contentView.addSubview(picture)
        
        NSLayoutConstraint.activate([
            picture.topAnchor.constraint(equalTo: contentView.topAnchor),
            picture.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            picture.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            picture.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
