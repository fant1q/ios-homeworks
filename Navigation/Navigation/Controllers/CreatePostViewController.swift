//
//  CreatePostViewController.swift
//  Navigation
//
//  Created by Денис Штоколов on 05.11.2023.
//

import UIKit
import CoreData
import Storage_Service

class CreatePostViewController: UIViewController {
    
    var model: CreatePostModel
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .label
        label.text = CurrentUserService().user.name
        label.numberOfLines = 2
        label.backgroundColor = .systemBackground
        return label
    }()
    
    private lazy var avatarPreview: UIImageView = {
        let image = CurrentUserService().user.avatar
        image.layer.cornerRadius = 50
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var photoPreview: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var postDescription: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = true
        textView.backgroundColor = .systemGray6
        textView.textColor = UIColor.createColor(lightMode: .black, darkMode: .white)
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.autocapitalizationType = .none
        return textView
    }()
    
    private lazy var postButton: UIButton = {
        let button = UIButton()
        button.setTitle("post.name".localized, for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.backgroundColor = .systemBackground
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(postTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var imageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "photo"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(imageTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeTap), for: .touchUpInside)
        return button
    }()
    
    
    init(model: CreatePostModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        
        navigationItem.title = model.title
        view.backgroundColor = model.color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layuot()
    }
    
    private func layuot() {
        
        [avatarPreview, authorLabel, postDescription, closeButton, postButton, imageButton, photoPreview].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            postButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            postButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            avatarPreview.topAnchor.constraint(equalTo: postButton.bottomAnchor, constant: 16),
            avatarPreview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            avatarPreview.heightAnchor.constraint(equalToConstant: 35),
            avatarPreview.widthAnchor.constraint(equalToConstant: 35),
            
            authorLabel.topAnchor.constraint(equalTo: postButton.bottomAnchor, constant: 16),
            authorLabel.leadingAnchor.constraint(equalTo: avatarPreview.trailingAnchor, constant: 16),
            authorLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            authorLabel.heightAnchor.constraint(equalToConstant: 35),
            
            postDescription.topAnchor.constraint(equalTo: avatarPreview.bottomAnchor, constant: 8),
            postDescription.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            postDescription.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            postDescription.heightAnchor.constraint(equalToConstant: 150),
            
            imageButton.topAnchor.constraint(equalTo: postDescription.bottomAnchor, constant: 16),
            imageButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            photoPreview.topAnchor.constraint(equalTo: postDescription.bottomAnchor, constant: 16),
            photoPreview.centerXAnchor.constraint(equalTo: postDescription.centerXAnchor),
            photoPreview.heightAnchor.constraint(equalToConstant: 120),
            photoPreview.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    @objc private func closeTap() {
        self.dismiss(animated: true)
    }
    
    @objc private func imageTap() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc private func postTap() {
        
        guard let image1 = self.avatarPreview.image else { return }
        guard let imageAvatar = image1.pngData() else { return }
        
        guard let image2 = self.photoPreview.image else { return }
        guard let imagePhoto = image2.pngData() else { return }
        
        let myPost = MyPost(authorLabel: self.authorLabel.text!, avatar: imageAvatar, photo: imagePhoto, postText: self.postDescription.text)
        myPosts.append(myPost)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload"), object: nil)
        self.dismiss(animated: true)
    }
}

extension CreatePostViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        photoPreview.image = image
        
        dismiss(animated: true)
    }
}
