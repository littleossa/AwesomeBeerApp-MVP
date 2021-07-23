//
//  BeerListViewController.swift
//  AwesomeBeerApp-MVP
//
//  Created by Osamu Hiraoka on 2021/07/19.
//

import UIKit

class BeerListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var presenter: BeerListPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        presenter = BeerListPresenter.init(with: self)
        presenter.viewDidLoad()
    }
}

extension BeerListViewController: BeerListPresenterOutput {
    
    func didFetch(_ beers: [Beer]) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFailToFetchBeer(with error: Error) {
        UIAlertController.present(on: self,
                                  title: "Error",
                                  messsage: "\(error)",
                                  cancelActionTitle: "OK",
                                  shouldWorkOnMainThread: true)
    }
    
    func didPrepareInfomation(of beer: Beer) {
        UIAlertController.present(on: self,
                                  title: beer.name,
                                  messsage: "\(beer.tagline)\n\n\(beer.description)",
                                  cancelActionTitle: "OK")
    }
}

    // MARK: - UITableView DataSource
extension BeerListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfBeers
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.IdOfBeerList,
                                                 for: indexPath)
        let beer = presenter.beer(forRow: indexPath.row)
        cell.textLabel?.text = beer?.name
        return cell
    }
}

    // MARK: - UITableView Delegate
extension BeerListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelectRowAt(indexPath)
    }
}
