//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Денис Штоколов on 14.04.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var titleProfile: String = "Profile"
    
    let subView: ProfileHeaderView = {
        let view = ProfileHeaderView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        subView.backgroundColor = .lightGray
        self.navigationItem.title = titleProfile
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let h = view.frame.height - 105
        subView.frame = CGRect(x: 0, y: 60, width: view.frame.width, height: h)
        view.addSubview(subView)
        view.addSubview(subView.name)
        view.addSubview(subView.avatar)
        view.addSubview(subView.statusButton)
        view.addSubview(subView.statusText)
        subView.statusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
    }
    
    @objc func buttonPressed() {
        print(subView.statusText.text!)
    }
}
