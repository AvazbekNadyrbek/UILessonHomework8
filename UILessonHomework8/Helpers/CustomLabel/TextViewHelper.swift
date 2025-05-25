//
//  TextViewHelper.swift
//  UILessonHomework8
//
//  Created by Авазбек Надырбек уулу on 23.05.25.
//

import UIKit

class TextViewHelper: UILabel {

    init(text: String? = "No text", font: UIFont = .systemFont(ofSize: 16, weight: .regular), textColor: UIColor = .black) {
        super.init(frame: .zero)
        self.font = font
        self.text = text
        self.textColor = textColor
        self.numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
