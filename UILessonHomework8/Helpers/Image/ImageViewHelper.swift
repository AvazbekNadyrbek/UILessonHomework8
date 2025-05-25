//
//  ImageViewHelper.swift
//  UILessonHomework8
//
//  Created by Авазбек Надырбек уулу on 23.05.25.
//

import UIKit

class ImageViewHelper: UIImageView {
    
    init(image: UIImage? = nil, cornerRadius: CGFloat = 10) {
        super.init(image: image)
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        contentMode = .scaleAspectFill
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

