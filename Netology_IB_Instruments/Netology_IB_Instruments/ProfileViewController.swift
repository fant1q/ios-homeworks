//
//  ProfileViewController.swift
//  Netology_IB_Instruments
//
//  Created by Денис Штоколов on 11.04.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenWidth = UIScreen.main.bounds.width
        if let myView = Bundle.main.loadNibNamed("ProfileView", owner: nil, options: nil)?.first as? ProfileView {
            myView.frame = CGRect(x: 16, y: 16, width: screenWidth - 5, height: 0)
            view.addSubview(myView)
        }
    }
    


}
