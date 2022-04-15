//
//  AlertViewController.swift
//  Navigation
//
//  Created by Денис Штоколов on 15.04.2022.
//

import UIKit

class AlertViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let alert = UIAlertController(title: "Delete Post", message: "Are you sure?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: "Default action"), style: .default, handler: { _ in
            NSLog("Post has been deleted")
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: "Default action"), style: .default, handler: { _ in
            NSLog("Deletion cancelled")
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
