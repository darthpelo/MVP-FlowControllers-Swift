//
//  MVP_FlowControllersTests.swift
//  MVP-FlowControllersTests
//
//  Created by Alessio Roberto on 28/05/2017.
//  Copyright © 2017 Alessio Roberto. All rights reserved.
//

import XCTest
@testable import MVP_FlowControllers

class MVP_FlowControllersTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDashboardPresenter() {
        let view = StubViewController()
        let sut = DashboardPresenterImplementation(view: view)
        view.presenter = sut
        
        sut.setupUI()
    }
}

private extension XCTestCase {
    class StubViewController: DashboardView {
        var presenter: DashboardPresenter!
        
        func updateUI(withTitleLabel titleText: String, withDescriptionLabel descriptionText: String, andButton title: String) {
            XCTAssertEqual(titleText, "a")
            XCTAssertEqual(descriptionText, "aa")
            XCTAssertEqual("next", title)
        }
    }
}
