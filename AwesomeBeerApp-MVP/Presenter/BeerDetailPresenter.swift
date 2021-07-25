//
//  BeerDetailPresenter.swift
//  AwesomeBeerApp-MVP
//
//  Created by Osamu Hiraoka on 2021/07/25.
//

import Foundation

protocol BeerDetailPresenterInput {
    var numberOfProperties: Int { get }
    var beerProperties: [String] { get}
    func property(forRow row: Int) -> String?
    func viewDidLoad()
}

protocol BeerDetailPresenterOutput: AnyObject {
    func display(_ beer: Beer)
}

class BeerDetailPresenter: BeerDetailPresenterInput {
    
    private(set) var beer: Beer!
    private weak var view: BeerDetailPresenterOutput?
    
    init(with view: BeerDetailPresenterOutput, and beer: Beer) {
        self.view = view
        self.beer = beer
    }
    
    var numberOfProperties: Int {
        beerProperties.count
    }
    
    var beerProperties: [String] {
        var properties = [String]()
        properties.append(String(beer.id))
        properties.append(beer.name)
        properties.append(beer.tagline)
        properties.append(beer.firstBrewed)
        properties.append(beer.description)
        return properties
    }
    
    func property(forRow row: Int) -> String? {
        if row >= beerProperties.count {
            return nil
        }
        return beerProperties[row]
    }
    
    func viewDidLoad() {
        view?.display(beer)
    }
}
