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
}

// MARK: - Presenter Protocols
protocol ProductListPresenterProtocol: AnyObject {
    var view: ProductListViewProtocol? { get set }
    var interactor: ProductListInteractorProtocol? { get set }
    var router: ProductListRouterProtocol? { get set }
}

// MARK: - View Protocols
protocol ProductListViewProtocol: AnyObject {
    var presenter: ProductListPresenterProtocol? { get set }
}

// MARK: - Router Protocols
protocol ProductListRouterProtocol{
    static func createModule() -> UIViewController
}
