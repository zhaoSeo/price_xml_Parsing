//
//  PriceData.swift
//  price_xml_Parsing
//
//  Created by Sang won Seo on 19/11/2018.
//  Copyright © 2018 Sang won Seo. All rights reserved.
//
import Foundation
class PriceData {
    var productNm: String
    var prdlstDetailNm: String
    var grade: String
    var weight: String
    var distributePrice: String
    var price: String
    var image: String
    init(productNm: String, prdlstDetailNm: String, grade: String, weight: String, distributePrice: String, price: String, image: String) {
        self.productNm = productNm
        self.prdlstDetailNm = prdlstDetailNm
        self.grade = grade
        self.weight = weight
        self.distributePrice = distributePrice
        self.price = price
        self.image = image
    }
    
    //    convenience init() {
    //        self.init(name: "", image: "", address: "", tel: "", menu: "")
    //    }
}
