//
//  MashimashiViewController.swift
//  AwesomeBeerApp-MVP
//
//  Created by Osamu Hiraoka on 2021/07/22.
//

import UIKit

class MashimashiViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var beers = [Beer]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        fetchBeer { result in
            switch result {
            case .failure(let error):
                print(error)
                let alert = UIAlertController(title: "Error",
                                              message: "\(error)",
                                              preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .cancel)
                alert.addAction(alertAction)
                DispatchQueue.main.async {
                    self.present(alert, animated: true)
                }
            case .success(let beers):
                self.beers = beers
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    private func fetchBeer(completion: @escaping ((Result<[Beer], Error>) -> ())) {
        guard let url = URL(string: PunkAPIService.baseUrlString)
        else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            guard let data = data,
                  let decodedData = try? jsonDecoder.decode([Beer].self, from: data) else {
                let error = NSError(domain: "parse-error",
                                    code: 1,
                                    userInfo: nil)
                completion(.failure(error))
                return
            }
            completion(.success(decodedData))
        }
        task.resume()
    }
}

extension MashimashiViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.IdOfBeerList, for: indexPath)
        let beer = beers[indexPath.row]
        cell.textLabel?.text = beer.name
        return cell
    }
}

extension MashimashiViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let beer = beers[indexPath.row]
        let alert = UIAlertController(title: beer.name,
                                      message: "\(beer.tagline)\n\n\(beer.description)",
                                      preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
}
