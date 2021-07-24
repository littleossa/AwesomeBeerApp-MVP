//
//  PunkAPIManager.swift
//  AwesomeBeerApp-MVP
//
//  Created by Osamu Hiraoka on 2021/07/19.
//

import Foundation

protocol PunkAPIDataModelInput {
    func fetchBeers(completion: @escaping ((Result<[Beer], Error>) -> ()))
}

class PunkAPIDataModel: PunkAPIDataModelInput {
                
    func fetchBeers(completion: @escaping ((Result<[Beer], Error>) -> ())) {
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
