//
//  BeerListPresenter.swift
//  AwesomeBeerApp-MVPTests
//
//  Created by Osamu Hiraoka on 2021/07/19.
//

import XCTest
@testable import AwesomeBeerApp_MVP

class BeerListPresenterOutputMock: BeerListPresenterOutput {
    
    func didFetch(_ beers: [Beer]) {
    }
    
    func didFailToFetchBeer(with error: Error) {
    }
    
    func didPrepareInfomation(of beer: Beer) {
    }
}

class BeerListPresenterStub: BeerListPresenter {
    
    override var beers: [Beer] {
        Beer.mockBeers()
    }
}

class BeerListPresenterTests: XCTestCase {
    
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }
    
    func testBeerForRow() throws {
        // mockBeersのカウントは3
        let mock = BeerListPresenterOutputMock()
        let presenter = BeerListPresenterStub(with: mock)
        XCTContext.runActivity(named: "rowの値がbeersのcountより小さい場合は戻り値がnilではないこと") { _ in
            let beer = presenter.beer(forRow: 0)
            XCTAssertNotNil(beer, "beerが返されること")
        }
        
        XCTContext.runActivity(named: "rowの値がbeersのcount - 1と等しい場合は戻り値がnilではないこと") { _ in
            let beer = presenter.beer(forRow: 2)
            XCTAssertNotNil(beer, "beerが返されること")
        }
        
        XCTContext.runActivity(named: "rowの値がbeersのcountと等しい場合は戻り値がnilであること") { _ in
            let beer = presenter.beer(forRow: 3)
            XCTAssertNil(beer)
        }
        
        XCTContext.runActivity(named: "rowの値がbeersのcountより大きい場合は戻り値がnilであること") { _ in
            let beer = presenter.beer(forRow: 4)
            XCTAssertNil(beer)
        }
    }
}
