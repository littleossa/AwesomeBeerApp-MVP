//
//  BeerListPresenter.swift
//  AwesomeBeerApp-MVPTests
//
//  Created by Osamu Hiraoka on 2021/07/19.
//

import XCTest
@testable import AwesomeBeerApp_MVP

class BeerListPresenterInputMock: BeerListPresenterInput {
    
    private (set) var beers = Beer.mockBeers()
    
    var numberOfBeers: Int {
        return beers.count
    }
    
    func beer(forRow row: Int) -> Beer? {
        if row >= beers.count {
            return nil
        }
        return beers[row]
    }
    
    func didSelectRowAt(_ indexPath: IndexPath) {
//        guard let beer = beer(forRow: indexPath.row)
//        else { return }
//        outputView?.transitionToBeerDetail(of: beer)
    }
    
    func loadBeers() {
        PunkAPIManager.instance.loadBeer { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
//                self?.outputView?.didFailToLoadBeers(with: error)
            case .success(let loadedBeer):
                self?.beers = loadedBeer
                guard let beers = self?.beers
                else { return }
                print(beers)
//                self?.outputView?.didLoad(beers)
            }
        }
    }
}

class BeerListPresenterTests: XCTestCase {
    
    var presenter = BeerListPresenterInputMock()

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }
    
    func testBeerForRow() throws {
        // mockBeersのカウントは3
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
