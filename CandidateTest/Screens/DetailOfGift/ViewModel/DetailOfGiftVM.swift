//
//  DetailOfGiftVM.swift
//  CandidateTest
//
//  Created by Prabhjot Singh Gogana on 21/8/2022.
//

import Foundation
import RxRelay
import RxSwift

struct DetailOfGiftVM {
    var sectionTypes: [SectionType] = [.header, .denomination, .buttons, .terms, .disclaimer]
    var gift: Gift?
    enum SectionType: Int {
        case header, denomination, buttons, terms, disclaimer
        var heightForSection: CGFloat {
            switch self {
            case .header:
                return 200
            case .denomination:
                return 80
            case .buttons:
                return 120
            case .terms:
                return 40
            case .disclaimer:
                return 40
            }
        }
        
        var rowsInSection: Int {
            switch self {
            case .header, .denomination , .buttons:
                return 0
            case .terms, .disclaimer:
                return 1
            }
        }
    }
    
    // function to check if gift is already added or not. Additionaly add to the userDefault
    func addToCart(gift: Gift) -> Bool {
        if var gifts: [Gift] = UserDefaults.getCart() {
            if gifts.contains(where: {$0.id == gift.id}) == false {
                gifts.append(gift)
                UserDefaults.setAddToCart(gifts)
                return true
            } else {
                return false
            }
        } else {
            UserDefaults.setAddToCart([gift])
            return true
        }
    }
}
