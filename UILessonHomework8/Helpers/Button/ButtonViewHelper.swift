//
//  ButtonViewHelper.swift
//  UILessonHomework8
//
//  Created by Авазбек Надырбек уулу on 23.05.25.
//

import UIKit

class ButtonViewHelper: UIButton {
    
    init(title: String = "Купить", titleColor: UIColor = .white) {
        super.init(frame: .zero)
        
        // Configure
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        backgroundColor        = .systemGreen
        titleLabel?.font       = .systemFont(ofSize: 17, weight: .regular)
        layer.cornerRadius     = 10
        translatesAutoresizingMaskIntoConstraints = false
        layer.masksToBounds    = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
