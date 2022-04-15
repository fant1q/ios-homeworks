//
//  InfoViewController.swift
//  Navigation
//
//  Created by Денис Штоколов on 14.04.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    let button = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        self.button.setTitle("Delete Post", for: .normal)
        self.button.backgroundColor = .systemRed
        self.button.layer.cornerRadius = 15
        self.view.addSubview(button)
        self.button.frame = CGRect(x: 140, y: 200, width: 150, height: 70)
        self.button.setTitleColor(.black, for: .normal)
        self.button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        
    }
    
    @objc
    func buttonTap() {
        let alertViewController = AlertViewController()
        self.navigationController?.pushViewController(alertViewController, animated: true)
    }
    
}
