//
//  ProductListProtocols.swift
//  walmart-e2
//
//  Created by Luis Enrique Vazquez Escobar on 08/10/24.
//

import UIKit

// MARK: - Interactor Protocols
protocol ProductListInteractorProtocol {
    var presenter: ProductListPresenterProtocol? { get set }
    
    func fetchProducts()
}

// MARK: - Presenter Protocols
protocol ProductListPresenterProtocol: AnyObject {
    var view: ProductListViewProtocol? { get set }
    var interactor: ProductListInteractorProtocol? { get set }
    var router: ProductListRouterProtocol? { get set }
    
    func fetchProducts()
    func productsFetched(products: [Product])
    func productsFetchFailed(error: Error)
    
    func numberOfProducts() -> Int
    func product(at index: Int) -> Product
    
    func navigateToProductDetail(at index: Int)
}

// MARK: - View Protocols
protocol ProductListViewProtocol: AnyObject {
    var presenter: ProductListPresenterProtocol? { get set }
    
    func reloadData()
    func showError(message: String)
}

// MARK: - Router Protocols
protocol ProductListRouterProtocol{
    static func createModule() -> UIViewController
    
    func navigateToProductDetail(parent: UIViewController, product: Product)
}
