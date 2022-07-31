//
//  CustomButton.swift
//  Navigation
//
//  Created by Денис Штоколов on 31.07.2022.
//

import UIKit

final class CustomButton: UIButton {
    
    private var title: String
    public let bluePixel = UIImage(named: "blue_pixel")
    var tapAction: (() -> Void)?
    
    init(title: String, backgroundColor: UIColor) {
        self.title = title
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(title, for: .normal)
        layer.cornerRadius = 12
        clipsToBounds = true
        addTarget(self, action: #selector(tap), for: .touchUpInside)
        if self .isSelected || self .isHighlighted {
            self.alpha = 0.8
        } else {
            self.alpha = 1
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.7
    }
    
    @objc private func tap() {
        tapAction?()
    }
    
}
