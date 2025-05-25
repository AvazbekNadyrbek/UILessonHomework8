//
//  VStackHElper.swift
//  UILessonHomework8
//
//  Created by Авазбек Надырбек уулу on 24.05.25.
//

import UIKit

class VStackHelper: UIStackView {
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
        axis         = .vertical
        distribution = .fill
        alignment    = .leading
        spacing      = 8
        translatesAutoresizingMaskIntoConstraints = false
    }
}
