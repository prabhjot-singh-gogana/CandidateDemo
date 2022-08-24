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
    enum SectionType {
        case header, denomination, buttons, terms, disclaimer
        
        var heightForSection: CGFloat {
            switch self {
            case .header:
                return 200
            case .denomination:
                return 80
            case .buttons:
                return 100
            case .terms:
                return 60
            case .disclaimer:
                return 60
            }
        }
    }
    var sectionTypes: [SectionType] = [.header, .denomination, .buttons, .terms, .disclaimer]
    var gift: Gift?
    let disposable = DisposeBag()
}
