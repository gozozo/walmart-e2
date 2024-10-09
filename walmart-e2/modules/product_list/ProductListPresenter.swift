//
//  ProductListPresenter.swift
//  walmart-e2
//
//  Created by Luis Enrique Vazquez Escobar on 08/10/24.
//

import UIKit

class ProductListPresenter: ProductListPresenterProtocol {
    
    weak var view: ProductListViewProtocol?
    var interactor: ProductListInteractorProtocol?
    var router: ProductListRouterProtocol?
    
    /// An array that holds the list of products.
    /// This property is used to store and manage the products displayed in the product list.
    private var products: [Product] = []
    
    func fetchProducts() {
        interactor?.fetchProducts()
    }
    
    func productsFetched(products: [Product]) {
        self.products = products
        view?.reloadData()
    }
    
    func productsFetchFailed(error: any Error) {
        view?.showError(message: error.localizedDescription)
    }
    
    func numberOfProducts() -> Int {
        return products.count
    }
    
    func product(at index: Int) -> Product {
        return products[index]
    }
    
    func navigateToProductDetail(at index: Int) {
        guard let view = view as? UIViewController else { return }
        let product = products[index]
        router?.navigateToProductDetail(parent: view, product: product)
    }
}
