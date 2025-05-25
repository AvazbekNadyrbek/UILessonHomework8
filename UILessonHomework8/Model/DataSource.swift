//
//  DataModel.swift
//  UILessonHomework8
//
//  Created by Авазбек Надырбек уулу on 23.05.25.
//

import UIKit

struct DataSource: Identifiable {
    var id = UUID().uuidString
    var img: String
    var price: String
    var icon: String
    var title: String
    var bigDesrption: String?
    var specs: [Specification] = []

    private static var defaultSpecs: [Specification] = [
        Specification(name: "Тип:",                  value: "Смартфон"),
        Specification(name: "ОС:",                   value: "iOS 16"),
        Specification(name: "Тип корпуса:",          value: "Классический"),
        Specification(name: "Конструкция:",          value: "Водозащита"),
        Specification(name: "Материал корпуса:",     value: "Стекло, керамика, нержавеющая сталь"),
        Specification(name: "Тип SIM-карты:",        value: "nano-SIM + eSIM"),
        Specification(name: "Кол-во SIM-карт:",      value: "1"),
        Specification(name: "Вес:",                  value: "240 г"),
        Specification(name: "Размеры:",              value: "160.7×77.6×8.5 мм")
    ]

    static var mockData: [DataSource] {
        [
            DataSource(img: "img1", price: "107 990 ₽", icon: "bookmark",
                       title: "Apple iPhone 14 256 GB Серебристый",
                       bigDesrption: "",
                       specs: defaultSpecs),
            DataSource(img: "img2", price: "89 990 ₽", icon: "bookmark",
                       title: "Apple iPhone 14 128Gb Черный",
                       bigDesrption: nil,
                       specs: defaultSpecs),
            DataSource(img: "img3", price: "119 990 ₽", icon: "bookmark",
                       title: "Apple iPhone 14 Pro Max 256Gb Золотой",
                       bigDesrption: nil,
                       specs: defaultSpecs),
            DataSource(img: "img4", price: "95 990 ₽", icon: "bookmark",
                       title: "Apple iPhone 14 Plus 128Gb Фиолетовый",
                       bigDesrption: nil,
                       specs: defaultSpecs),
            DataSource(img: "img5", price: "99 990 ₽", icon: "bookmark",
                       title: "Apple iPhone 14 Pro 128Gb Xерный",
                       bigDesrption: nil,
                       specs: defaultSpecs),
            DataSource(img: "img6", price: "134 990 ₽", icon: "bookmark",
                       title: "Apple iPhone 14 Pro 512Gb Серебристый",
                       bigDesrption: nil,
                       specs: defaultSpecs)
        ]
    }

    init(img: String, price: String, icon: String, title: String, bigDesrption: String? = nil, specs: [Specification] = []) {
        self.img = img
        self.price = price
        self.icon = icon
        self.title = title
        self.bigDesrption = bigDesrption
        self.specs = specs
    }
}
