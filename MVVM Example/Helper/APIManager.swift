//
//  APIManager.swift
//  MVVM Example
//
//  Created by Admin on 15/01/23.
//

import UIKit
enum DataError: Error {
    case invalidResponse
    case invalidURL
    case invalidData
    case network(_ error: Error?)
}

//Singleton design pattern
final class APIManager {
    
    static let shared = APIManager()
    typealias Handler = (Result<[Product], DataError>) -> Void
    
    private init() { }
    
    func fetchProduct(complition: @escaping Handler) {
        
        guard let url = URL(string: Constant.API.productURL) else { return}
        
        //background task
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                complition(.failure(.invalidData))
                return}
            
            guard let response = response as? HTTPURLResponse, 200 ... 299 ~= response.statusCode else {
                complition(.failure(.invalidResponse))
                return
            }
            //JSONDecoder() -> data ko Model(Array) main conver kare ga
            do{
                let product = try JSONDecoder().decode([Product].self, from: data)
                complition(.success(product))
            }catch {
                complition(.failure(.network(error)))
            }
        }
        task.resume()
    }
}

//resume -> completion ko call kr ta hai 

//final keywoard k help se uska inheritance property ko block kr te hai
//s->singleton -> ka object hum log bahar create kr sakta hai
//S-> Singleton -> ka object bahar nhi ban sakta
