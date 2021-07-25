//
//  BeerDetailViewController.swift
//  AwesomeBeerApp-MVP
//
//  Created by Osamu Hiraoka on 2021/07/25.
//

import UIKit

class BeerDetailViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    var presenter: BeerDetailPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        presenter.viewDidLoad()
    }
}

extension BeerDetailViewController: BeerDetailPresenterOutput {
    
    func display(_ beer: Beer) {
        tableView.reloadData()
    }
}

    // MARK: - UITable view data source
extension BeerDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfProperties
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.IdOfBeerDetail, for: indexPath)
        cell.textLabel?.text = presenter.property(forRow: indexPath.row)
        return cell
    }
}
