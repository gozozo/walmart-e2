//
//  ServiceManager.swift
//  walmart-e2
//
//  Created by Personal on 08/10/24.
//

import Foundation

class ServiceManager {
    
    let baseURL = "https://fakestoreapi.com/products"
    
    static let shared = ServiceManager()
    
    private init() {}
    
    // Función para obtener todos los productos
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
