//
//  ServiceManager.swift
//  walmart-e2
//
//  Created by Luis Enrique Vazquez Escobar on 08/10/24.
//

import Foundation

/// ServiceManager is responsible for handling network service requests.
/// This class provides methods to perform network operations and manage
/// the responses from various services.
class ServiceManager {
    
    let baseURL = "https://fakestoreapi.com/products"
    
    static let shared = ServiceManager()
    
    private init() {}
    
    
    /// Fetches a list of products from the service.
    /// 
    /// - Parameter completion: A closure that gets called with the result of the fetch operation. 
    ///   The closure takes a `Result` containing either an array of `Product` objects or an `Error`.
    /// 
    /// - Returns: Void
    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        guard let url = URL(string: baseURL) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let products = try JSONDecoder().decode([Product].self, from: data)
                completion(.success(products))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
