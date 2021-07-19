//
//  BeerListViewController.swift
//  AwesomeBeerApp-MVP
//
//  Created by Osamu Hiraoka on 2021/07/19.
//

import UIKit

class BeerListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

    // MARK: - UITableView DataSource
extension BeerListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.IdOfBeerList,
                                                 for: indexPath)
        cell.textLabel?.text = ""
        return cell
    }
}

    // MARK: - UITableView Delegate
extension BeerListViewController: UITableViewDelegate {
    
}
