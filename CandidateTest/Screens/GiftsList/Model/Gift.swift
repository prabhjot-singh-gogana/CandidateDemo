//
//  Gift.swift
//  CandidateTest
//
//  Created by Prabhjot Singh Gogana on 21/8/2022.
//

import UIKit
import RxSwift
import RxCocoa
import Foundation

// MARK: - Gift
struct Gift: Codable, PSJsonDecoding {
    typealias PSMapperModel = Gift
    
    var vendor, id, brand, image,terms, importantContent, cardTypeStatus, disclaimer: String?
    var denominations: [Denomination]?
    var position: Int?
    var discount: Double?
    
    init() {
        
    }
}

// MARK: - Denomination
struct Denomination: Codable, PSJsonDecoding {
    typealias PSMapperModel = Denomination
    var price: Double?
    var currency, stock: String?
    var isSelected:Bool? = false
    init() {
        
    }
}
