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
    
    /// Fetches the list of products from the data source.
    /// 
    /// This method is responsible for initiating the process of retrieving
    /// product information, which may involve network requests, database
    /// queries, or other forms of data fetching. The exact implementation
    /// details will depend on the conforming type.
    func fetchProducts()
}

// MARK: - Presenter Protocols
protocol ProductListPresenterProtocol: AnyObject {

    var view: ProductListViewProtocol? { get set }
    var interactor: ProductListInteractorProtocol? { get set }
    var router: ProductListRouterProtocol? { get set }
    
    /// Fetches the list of products.
    /// 
    /// This method is responsible for initiating the process of retrieving
    /// product data, which may involve network requests, database queries,
    /// or other data sources. The implementation details are defined in the
    /// conforming types.
    func fetchProducts()

    /// Notifies that the products have been fetched successfully.
    /// - Parameter products: An array of `Product` objects that have been fetched.
    func productsFetched(products: [Product])
    
    /// This function is called when fetching products fails.
    /// - Parameter error: The error that occurred during the fetch operation.
    func productsFetchFailed(error: Error)
    
    /// Returns the number of products.
    /// 
    /// - Returns: An integer representing the total number of products.
    func numberOfProducts() -> Int

    /// Returns the product at the specified index.
    ///
    /// - Parameter index: The index of the product to retrieve.
    /// - Returns: The product at the specified index.
    func product(at index: Int) -> Product
    
    /// Navigates to the product detail view for the product at the specified index.
    /// - Parameter index: The index of the product in the list.
    func navigateToProductDetail(at index: Int)
}

// MARK: - View Protocols
protocol ProductListViewProtocol: AnyObject {
    var presenter: ProductListPresenterProtocol? { get set }
    
    /// Reloads the data for the product list.
    /// 
    /// This method should be called to refresh the product list data, typically after
    /// data has been updated or fetched from a remote source.
    func reloadData()
    
    /// Displays an error message to the user.
    /// - Parameter message: A string containing the error message to be shown.
    func showError(message: String)
}

// MARK: - Router Protocols
protocol ProductListRouterProtocol{

    /// Creates and returns a new instance of the module's main view controller.
    /// 
    /// - Returns: A `UIViewController` instance representing the main view of the module.
    static func createModule() -> UIViewController
    
    /// Navigates to the product detail screen.
    /// 
    /// - Parameters:
    ///   - parent: The parent view controller from which the navigation will occur.
    ///   - product: The product object containing details to be displayed.
    func navigateToProductDetail(parent: UIViewController, product: Product)
}
