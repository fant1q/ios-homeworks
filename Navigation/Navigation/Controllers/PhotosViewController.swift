//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Денис Штоколов on 17.06.2022.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {
    
    private var publisherPhotos: [UIImage] = []
    private let publisher = ImagePublisherFacade()
    var model: PhotosModel
    let imageProcessor = ImageProcessor()
    
    private lazy var collection: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "phCollCell")
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    init(model: PhotosModel) {
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
        self.navigationController?.navigationBar.isHidden = false
        layout()
        publisher.rechargeImageLibrary()
        publisher.addImagesWithTimer(time: 0.1, repeat: 40)
        receive(images: imageStorage)
    }
    
    private func layout() {
        view.addSubview(collection)
        
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        publisherPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "phCollCell", for: indexPath) as! PhotosCollectionViewCell
        cell.setupCell(photo: publisherPhotos[indexPath.row])
        return cell
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    private var sideInset: CGFloat { return 8 }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - sideInset * 4) / 3
        return CGSize(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: sideInset, left: sideInset, bottom: sideInset, right: sideInset)
    }
}

extension PhotosViewController: ImageLibrarySubscriber {
    func receive(images: [UIImage]) {
        publisherPhotos = images
        
        let startTime = CFAbsoluteTimeGetCurrent()
        self.imageProcessor.processImagesOnThread(sourceImages: images, filter: .noir, qos: .default, completion: { images in
            DispatchQueue.main.async {
                images.forEach {
                    guard let img = $0 else { return }
                    self.publisherPhotos.append(UIImage(cgImage: img))
                }
                let finishTime = CFAbsoluteTimeGetCurrent()
                let diffTime = finishTime - startTime
                print("\(diffTime)")
                self.collection.reloadData()
                
                // filter: .sepia(intensity: 2), qos: .userInteractive - diff = 2.650012969970703
                // filter: .sepia(intensity: 2), qos: .default - diff = 2.5466660261154175
                // filter: .sepia(intensity: 2), qos: .background - diff = 9.493250012397766
                // filter: .noir, qos: .default - diff = 2.536806106567383
                // filter: .noir, qos: .background - diff = 11.157283067703247
                
            }
        })
    }
}
