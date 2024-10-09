//
//  ProductListInteractor.swift
//  walmart-e2
//
//  Created by Luis Enrique Vazquez Escobar on 08/10/24.
//

import Foundation

class ProductListInteractor: ProductListInteractorProtocol {
    var presenter: ProductListPresenterProtocol?
    let serviceManager = ServiceManager.shared
    
    func fetchProducts() {
        serviceManager.fetchProducts { [weak self] result in
            switch result {
            case .success(let products):
                self?.presenter?.productsFetched(products: products)
            case .failure(let error):
                self?.presenter?.productsFetchFailed(error: error)
            }
        }
        
    }
}
