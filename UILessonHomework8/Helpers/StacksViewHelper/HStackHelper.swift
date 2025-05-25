//
//  HStackHelper.swift
//  UILessonHomework8
//
//  Created by Авазбек Надырбек уулу on 23.05.25.
//

import UIKit

class HStackHelper: UIStackView {
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    // MARK: - Private
    
    /// Общая настройка стека
    private func configure() {
        axis         = .horizontal
        distribution = .fillEqually
        alignment    = .center
        spacing      = 8
        translatesAutoresizingMaskIntoConstraints = false
    }
}
