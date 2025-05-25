//
//  IconViewHelper.swift
//  UILessonHomework8
//
//  Created by Авазбек Надырбек уулу on 23.05.25.
//

import UIKit

/// Вспомогательный класс для работы с SF-symbols.
/// Позволяет получить `UIImage` или готовый `UIImageView`
final class IconViewHelper {
    
    /// Возвращает `UIImage` c указанным SF-symbol.
    /// - Parameters:
    ///   - name: имя символа (`"bookmark"`, `"heart.fill"` и т.д.).
    ///   - pointSize: размер в pt.
    ///   - weight: толщина линии.
    ///   - tintColor: цвет символа (по умолчанию наследует `tintColor` получателя).
    static func image(
        named name: String = "bookmark",
        pointSize: CGFloat = 10,
        weight: UIImage.SymbolWeight = .regular,
        tintColor: UIColor? = nil
    ) -> UIImage? {
        let config = UIImage.SymbolConfiguration(pointSize: pointSize, weight: weight)
        var image = UIImage(systemName: name, withConfiguration: config)
        
        // Если нужен конкретный цвет — подкрасим и установим режим отрисовки
        if let tintColor {
            image = image?.withTintColor(tintColor, renderingMode: .alwaysOriginal)
        }
        return image
    }
    
    /// Возвращает готовый `UIImageView` с символом.
    /// - Parameters:
    ///   - name: имя символа (`"bookmark"` по умолчанию).
    ///   - pointSize: размер символа.
    ///   - weight: толщина линии.
    ///   - tintColor: цвет (по умолчанию `.label`).
    ///   - contentMode: режим отображения.
    static func imageView(
        named name: String = "bookmark",
        pointSize: CGFloat = 10,
        weight: UIImage.SymbolWeight = .regular,
        tintColor: UIColor = .label,
        contentMode: UIView.ContentMode = .scaleAspectFit
    ) -> UIImageView {
        let iv = UIImageView()
        iv.image = image(
            named: name,
            pointSize: pointSize,
            weight: weight,
            tintColor: tintColor
        )
        iv.contentMode = contentMode
        iv.tintColor = tintColor
        return iv
    }
}
