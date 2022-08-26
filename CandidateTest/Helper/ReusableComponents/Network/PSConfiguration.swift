//
//  PSConfiguration.swift
//  ArticleDemo
//
//  Created by Prabhjot Singh Gogana on 14/7/2022.
//

import Foundation


struct PSconfiguration {
    //staticHeaders
    static let shared = PSconfiguration()
    var headers = ["":""]
    var baseURL = "https://zip.co"
}

struct AppConstants {
    static let strCongo = "Congratulations!"
    static let strBoughtGiftCard = "You have bought the '%@' Gift Card"
    static let strSelectedDenomPrice = "Selected Denomination Price %.1f"
    static let strContShop = "Continue Shopping"
    static let strGiftAlreadyAdded = "Gift is Already added"
    static let strGiftIsAdded = "Gift is Added to the Cart"
    static let strAdded = "Added"
    static let strTerms = "Terms And Conditions"
    static let strDisc = "Disclamer"
    static let strAddToCart = "Add To Cart"
    static let strBuyNow = "Buy Now"
}
