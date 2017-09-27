//
//  MVP_FlowControllersTests.swift
//  MVP-FlowControllersTests
//
//  Created by Alessio Roberto on 28/05/2017.
//  Copyright © 2017 Alessio Roberto. All rights reserved.
//

import XCTest
@testable import MVP_FlowControllers

class MVPFlowControllersTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDashboardPresenter() {
        let view = MockDashboardViewController()
        let sut = DashboardPresenterImplementation(view: view)
        view.presenter = sut
        
        sut.setupUI()
    }
    
    func testSecondPresenter() {
        let view = MockSecondViewController()
        let sut = SecondPresenter(view: view, dataManager: MockDataManager())
        view.presenter = sut
        
        sut.setupUI()
    }
}

private extension XCTestCase {
    class MockDashboardViewController: DashboardView {
        var presenter: DashboardPresenter!
        
        func updateUI(withTitleLabel titleText: String, withDescriptionLabel descriptionText: String, andButton title: String) {
            XCTAssertEqual(titleText, "a")
            XCTAssertEqual(descriptionText, "aa")
            XCTAssertEqual("next", title)
        }
    }
    
    class MockSecondViewController: SecondView {
        var presenter: SecondPresentable!
        
        func updateUI(withDescriptionLabel descriptionText: String) {
            XCTAssertEqual(descriptionText, StubObject.object)
        }
    }
    
    class MockDataManager: DataManager {
        func gerData(completition: @escaping (Any?) -> Void) {
            completition(StubObject.object)
        }
    }
    
    struct StubObject {
        static let object = "TestMVP"
    }
}
