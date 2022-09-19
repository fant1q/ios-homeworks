//
//  InfoViewController.swift
//  Navigation
//
//  Created by Денис Штоколов on 14.04.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Delete Post", for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 15
        //        button.frame = CGRect(x: 140, y: 200, width: 150, height: 70)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        
        return button
        
    }()
    
    let alertUI: UIAlertController = {
        let alert = UIAlertController(title: "Delete Post", message: "Are you sure?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: "Default action"), style: .default, handler: { _ in
            NSLog("Post has been deleted")
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: "Default action"), style: .default, handler: { _ in
            NSLog("Deletion cancelled")
        }))
        
        return alert
        
    }()
    
    private let requestLabel: UILabel = {
        let label = UILabel()
        //        label.frame = CGRect(x: 40, y: 300, width: 500, height: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let planetLabel: UILabel = {
        let label = UILabel()
        //        label.frame = CGRect(x: 40, y: 400, width: 500, height: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let networkService: NetworkServiceInfoProtocol = NetworkServiceInfo()
    
    private var orbitalPeriod: String?
    
    var model: InfoModel
    
    init(model: InfoModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = model.color
        navigationItem.title = model.title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        fetchData()
        fetchDataWithDecoder()
    }
    
    private func layout() {
        [deleteButton, requestLabel, planetLabel].forEach { view.addSubview($0) }
        view.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 140),
            deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deleteButton.widthAnchor.constraint(equalToConstant: 150),
            
            requestLabel.topAnchor.constraint(equalTo: deleteButton.bottomAnchor, constant: 40),
            requestLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            planetLabel.topAnchor.constraint(equalTo: requestLabel.bottomAnchor, constant: 40),
            planetLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            planetLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            planetLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20)
            
            
        ])
    }
    
    private func fetchData() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos/7") else { return }
        self .networkService.request(url: url) { [weak self] result in
            switch result {
            case .success(let data):
                print("🫐", String(data: data, encoding: .utf8) as Any)
                do {
                    let object = try JSONSerialization.jsonObject(with: data, options: [])
                    print("🍓", object)
                    
                    if let dictionary = object as? [String: Any] {
                        guard let textLabel = dictionary["title"] else { return }
                        self?.requestLabel.text = textLabel as? String
                    }
                } catch let error {
                    print("🍊", error)
                }
            case .failure(let error):
                print("🍊", error)
            }
        }
    }
    
    private func fetchDataWithDecoder() {
        guard let url = URL(string: "https://swapi.dev/api/planets/1") else { return }
        self.networkService.request(url: url) { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let planet = try JSONDecoder().decode(Planet.self, from: data)
                    print("🍆", dump(planet))
                    self?.planetLabel.text = "The period of the planet Tatooine's orbit around its star: \(planet.orbital_period)"
                } catch let error {
                    print("🍊", error)
                }
            case .failure(let error):
                print("🍊", error)
            }
        }
    }
    
    @objc
    func buttonTap() {
        self.present(alertUI, animated: true)
    }
    
}
