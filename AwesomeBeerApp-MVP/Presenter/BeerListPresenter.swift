//
//  BeerListPresenter.swift
//  AwesomeBeerApp-MVP
//
//  Created by Osamu Hiraoka on 2021/07/19.
//

import Foundation

protocol BeerListPresenterInput {
    var numberOfBeers: Int { get }
    func beer(forRow row: Int) -> Beer?
    func loadBeers()
    func didSelectRowAt(_ indexPath: IndexPath)
}

protocol BeerListPresenterOutPut: NSObject {
    func didLoad(_ beers: [Beer])
    func didFailToLoadBeers(with error: Error)
    func transitionToBeerDetail(of beer: Beer)
}

class BeerListPresenter: BeerListPresenterInput {
    
    private(set) var beers = [Beer]()
    
    private weak var outputView: BeerListPresenterOutPut?
    
    init(view: BeerListPresenterOutPut) {
        outputView = view
    }

    var numberOfBeers: Int {
        return beers.count
    }
    
    func beer(forRow row: Int) -> Beer? {
        if row > beers.count {
            return nil
        }
        return beers[row]
    }
    
    func didSelectRowAt(_ indexPath: IndexPath) {
        guard let beer = beer(forRow: indexPath.row)
        else { return }
        outputView?.transitionToBeerDetail(of: beer)
    }
    
    func loadBeers() {
        PunkAPIManager.instance.loadBeer { [weak self] result in
            switch result {
            case .failure(let error):
                self?.outputView?.didFailToLoadBeers(with: error)
            case .success(let loadedBeer):
                self?.beers = loadedBeer
                guard let beers = self?.beers
                else { return }
                self?.outputView?.didLoad(beers)
            }
        }
    }
}
