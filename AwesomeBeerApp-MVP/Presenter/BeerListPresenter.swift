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
    func viewDidLoad()
    func didSelectRowAt(_ indexPath: IndexPath)
}

protocol BeerListPresenterOutput: AnyObject {
    func didFetch(_ beers: [Beer])
    func didFailToFetchBeer(with error: Error)
    func transitionToBeerDetail(of beer: Beer)
}

class BeerListPresenter: BeerListPresenterInput {
    
    private(set) var beers = [Beer]()
    
    private weak var view: BeerListPresenterOutput?
    private var dataModel: PunkAPIDataModelInput
    
    init(with view: BeerListPresenterOutput) {
        self.view = view
        self.dataModel = PunkAPIDataModel()
    }

    var numberOfBeers: Int {
        return beers.count
    }
    
    func beer(forRow row: Int) -> Beer? {
        if row >= beers.count {
            return nil
        }
        return beers[row]
    }
    
    func viewDidLoad() {
        dataModel.fetchBeers { [weak self] result in
            switch result {
            case .failure(let error):
                self?.view?.didFailToFetchBeer(with: error)
            case .success(let loadedBeer):
                self?.beers = loadedBeer
                guard let beers = self?.beers
                else { fatalError() }
                self?.view?.didFetch(beers)
            }
        }
    }
    
    func didSelectRowAt(_ indexPath: IndexPath) {
        guard let beer = beer(forRow: indexPath.row)
        else { return }
        view?.transitionToBeerDetail(of: beer)
    }
}
