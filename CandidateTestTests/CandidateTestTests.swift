//
//  CandidateTestTests.swift
//  CandidateTestTests
//
//  Created by Prabhjot Singh Gogana on 20/8/2022.
//

import XCTest
import RxSwift

@testable import CandidateTest

class CandidateTestTests: XCTestCase {
    var disposeBag: DisposeBag!
    var listVM: GiftListVM!
    var scheduler: ConcurrentDispatchQueueScheduler!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        disposeBag = DisposeBag()
        listVM = GiftListVM()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        disposeBag = nil
        listVM = nil
        super.tearDown()
    }
    // Test the GiftListVM requestGiftData method and also test the gift response
    // expected gift not nil
    func testResponseForGiftList() throws {
        let responseExpectaion = expectation(description: "expectation.response")
        listVM.giftList$.compactMap({$0}).subscribe(onNext: {gifts in
            XCTAssertNotNil(gifts) // check the case if not nil
            XCTAssert(gifts.count > 0) // check the case if array has some count
            XCTAssert(gifts[0].toJSON()?["id"] != nil) //there should be id after reverse engineering
            responseExpectaion.fulfill()
        }).disposed(by: self.disposeBag)
        listVM.requestGiftData()
        waitForExpectations(timeout: 20) { (error) in
        }
    }
    
    // Test the API manager by not to use Gift (expected model) but any other model(TestModel)
    // expected result would be array of TestModel but with empty inside it which can be test by toJSON method.
    func testAPIManagerClassWithJustResponse() {
        struct TestModel: Codable, PSJsonDecoding {
            typealias PSMapperModel = TestModel
        }
        let responseExpectaion = expectation(description: "expectation.response")
        let manager = APIManager<TestModel>.request(.list)
        manager.failureError.compactMap({$0}).subscribe(onNext: {error in
            XCTAssert(error.isResponseSerializationError == true)
        }).disposed(by: self.disposeBag)
        // response of array
        manager.responseArray.compactMap({$0}).subscribe(onNext: {list in
            XCTAssert(list.count > 0) // check the case if array has some count
            XCTAssert(list[0].toJSON()?["id"] == nil) // there should be id after reverse engineering
            responseExpectaion.fulfill()
        }).disposed(by: self.disposeBag)
        waitForExpectations(timeout: 20) { (error) in
        }
    }
    
//    the test case is use to check if gift is already added or not. However the could be scenerio with different denominations which is not done by me
//    Note as it save the data to userdefault so make sure you have to delete the app everytime before test this case
    func testToCheckGiftIsAlreadyExitInCart() {
        let vm = DetailOfGiftVM()
        var gift1 = Gift()
        gift1.id = "1"
        gift1.brand = "Rebel"
        var gift2 = Gift()
        gift2.id = "2"
        gift2.brand = "Target"
        XCTAssert(vm.addToCart(gift: gift1)) // it should return true to clear the test.
        XCTAssert((vm.addToCart(gift: gift1)) == false) // it should return false to clear the test. because we should not have to add same gift card to the cart
        XCTAssert(vm.addToCart(gift: gift2)) // it should return true to clear the test. because gift2 has never been added.
    }
}
