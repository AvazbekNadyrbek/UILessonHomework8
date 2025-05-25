import Foundation

/// Одна характеристика товара
struct Specification: Identifiable {
    let id = UUID()
    let name:  String      // «Тип смартфон»
    let value: String      // «iOS 16»
}