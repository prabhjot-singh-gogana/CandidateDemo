//
//  GiftListVM.swift
//  CandidateTest
//
//  Created by Prabhjot Singh Gogana on 21/8/2022.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay


enum GiftNetworkError {
    case internetError(String)
    case serverMessage(String)
}

struct GiftListVM {
    var giftList$ = BehaviorRelay<[Gift]?>(value: nil)
    var emptyGiftList = [Gift(), Gift(), Gift(), Gift()]
    let loading: BehaviorRelay<Bool> = BehaviorRelay(value: true)
    let error : PublishSubject<GiftNetworkError> = PublishSubject()
    let disposable = DisposeBag()
    
    func requestGiftData() {
        self.loading.accept(true)
        APIManager<Gift>.request(.list)
            .responseArray
            .subscribe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { (array) in
                self.loading.accept(false)
                self.giftList$.accept(array)
            }).disposed(by: self.disposable)
        
    }
}

