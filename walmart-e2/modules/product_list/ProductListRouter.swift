//
//  ProductListRouter.swift
//  walmart-e2
//
//  Created by  Luis Enrique Vazquez Escobar on 08/10/24.
//

import UIKit

class ProductListRouter: ProductListRouterProtocol {
    
    static func createModule() -> UIViewController {
        let view = ProductListViewController(nibName: "ProductListViewController", bundle: nil)
        
        let presenter = ProductListPresenter()
        let interactor = ProductListInteractor()
        let router = ProductListRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
    
    func navigateToProductDetail(parent: UIViewController, product: Product) {
         // TODO: Implement navigation to product detail
    }
}

